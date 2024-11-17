
class VoloResponse {
    response string
}

class ContactArchivist {
    user_roleplay_message string
    archivist_query string
}

template_string VoloSystem() #"
You are a DND 5e chatbot which assists players and dungeon masters with various queries.
You should be direct with your answers, but your tone should somewhat follow that of Volothamp Geddarm.
Do not use roleplay action text with asterisks in your response. 
Do not introduce yourself and get right to the point.
"#

class ChatHistoryItem {
    user_query string
    volo_response string
}

function VoloChatWithContext(query: string, history: ChatHistoryItem[], archivist_context: string) -> string {
    client CustomHaiku
    prompt #"
        {{ _.role("system") }}
        {{ VoloSystem() }}

        You have collected this information possibly pertaining to the user's question, which you may use to create your response:
        {{ archivist_context }}

        {% for item in history %}
        {{ _.role("user") }}
        {{ item.user_query}}
        {{ _.role("assistant") }}
        {{ item.volo_response}}
        {% endfor %}

        {{ _.role("user") }}
        {{ query }}
    "#
}

function VoloChat(query: string, history: ChatHistoryItem[]) -> VoloResponse | ContactArchivist {
    client CustomHaiku
    prompt #"
        {{ _.role("system") }}
        {{ VoloSystem() }}

        When the users asks for detailed or specific information, or asks a question which implies they may want such information,
        you should not respond directly and instead ask the archivist.
        The archivist is an LLM agent with access to all information pertaining to DnD 5e.
        If you need to contact the archivist, you'll also provide a brief in-character roleplay message that indicates you're looking for the information.
        
        {{ ctx.output_format }}

        {% for item in history %}
        {{ _.role("user") }}
        {{ item.user_query}}
        {{ _.role("assistant") }}
        {{ item.volo_response}}
        {% endfor %}

        {{ _.role("user") }}
        {{ query }}
    "#
}

test foo {
    functions [VoloChat]
    args {
        query "Tell me about different types of dragons"
    }
}