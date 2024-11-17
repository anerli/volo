import volo.baml_client as baml
import requests
import json
from dataclasses import dataclass
import asyncio

@dataclass
class ArchivistResult:
    query: str
    source_url: str
    data: dict
    answer: str

    def to_context(self) -> str:
        return f"Query: {self.query}\nQuery Answer: {self.answer}\nRaw Data:\n```json\n{self.data}\n```\nSource: {self.source_url}\n"



async def ask_archivist_rec(query: str, url: str, visited: set[str], results: list[ArchivistResult], depth: int, max_depth: int):
    '''
    sources: set of URLs visited w relevant info
    '''
    # dbg
    #print(f"ask_archivist_rec: {query} @ {url}")

    if depth > max_depth or url in visited:
        return

    try:
        data_json = requests.get(f"https://www.dnd5eapi.co{url}").json()
    except Exception as e:
        # Probably hallicinated endpoint or something
        return
    
    data_context = json.dumps(data_json, indent=2)

    visited.add(url)

    archivist_resp = await baml.b.RecursiveLookup(
        question=query,
        current_endpoint=url,
        api_content=data_context
    )

    if isinstance(archivist_resp, baml.types.ArchivistAnswer):
        results.append(ArchivistResult(
            query=query,
            source_url=url,
            data=data_json,
            answer=archivist_resp.answer
        ))
        return
    
    jobs = []
    for followup in archivist_resp.queries:
        jobs.append(ask_archivist_rec(
            query=followup.question,
            url=followup.url,
            visited=visited,
            results=results,
            depth=depth+1,
            max_depth=max_depth
        ))
    await asyncio.gather(*jobs)


def ask_archivist(query: str, max_depth=5) -> list[ArchivistResult]:
    results = []
    asyncio.run(ask_archivist_rec(query, url="/api", visited=set(), results=results, depth=0, max_depth=max_depth))
    return results

    #archivist_resp = baml.b.RecursiveLookup(query=query)

if __name__ == '__main__':
    include_sources = True

    history: list[baml.types.ChatHistoryItem] = []

    while True:
        query = input('> ')

        resp = asyncio.run(baml.b.VoloChat(query=query, history=history))

        if isinstance(resp, baml.types.VoloResponse):
            volo_resp = resp.response
            
        else:
            print(f"\n{resp.user_roleplay_message}")
            #archivist_query = resp.archivist_query
            results = ask_archivist(resp.archivist_query)
            
            archivist_context = "\n\n".join(result.to_context() for result in results)
            #print("=== Archivist Context ===", archivist_context, sep="\n")

            volo_resp = asyncio.run(baml.b.VoloChatWithContext(
                query=query,
                history=history,
                archivist_context=archivist_context
            ))
            #print(volo_resp)

            if results and include_sources:
                sources_desc = ", ".join(f"https://www.dnd5eapi.co{result.source_url}" for result in results)
                sources_desc = f"[Sources: {sources_desc}]"

                volo_resp += f"\n\n{sources_desc}"
            #print(f"\n[Sources: {sources_desc}]")
        
        print(f"\n{volo_resp}\n")
        history.append(baml.types.ChatHistoryItem(user_query=query, volo_response=volo_resp))
        
#print(ask_archivist("Tell me about different kinds of dragons"))