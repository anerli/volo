// class FollowupLookups {

// }
class ArchivistFollowup {
    question string
    url string
}

class ArchivistFollowups {
    queries ArchivistFollowup[]
}

class ArchivistAnswer {
    answer string
}


function RecursiveLookup(question: string, current_endpoint: string, api_content: string) -> ArchivistFollowups | ArchivistAnswer {
    client Archivist
    prompt #"
        You are an archivist for DND 5e reference material.

        You are collecting resources pertaining to this query:
        {{ question }}

        To do so, you observe the output of a DND 5e API call already made to a certain endpoint, and either:
        (1) Answer the question if the provided information is sufficient
        or
        (2) Make followup queries using URLs in the output, which will be relayed to another archivist.

        API Information for {{ current_endpoint }}:
        {{ api_content }}

        {{ ctx.output_format }}
    "#
}

test how_many_conditions_pt1 {
    functions [RecursiveLookup]
    args {
        question "How many conditions are there?"
        current_endpoint "/api"
        api_content #"
            {
                "ability-scores": "/api/ability-scores",
                "alignments": "/api/alignments",
                "backgrounds": "/api/backgrounds",
                "classes": "/api/classes",
                "conditions": "/api/conditions",
                "damage-types": "/api/damage-types",
                "equipment": "/api/equipment",
                "equipment-categories": "/api/equipment-categories",
                "feats": "/api/feats",
                "features": "/api/features",
                "languages": "/api/languages",
                "magic-items": "/api/magic-items",
                "magic-schools": "/api/magic-schools",
                "monsters": "/api/monsters",
                "proficiencies": "/api/proficiencies",
                "races": "/api/races",
                "rule-sections": "/api/rule-sections",
                "rules": "/api/rules",
                "skills": "/api/skills",
                "spells": "/api/spells",
                "subclasses": "/api/subclasses",
                "subraces": "/api/subraces",
                "traits": "/api/traits",
                "weapon-properties": "/api/weapon-properties"
            }
        "#
    }
}

test how_many_conditions_pt2 {
    functions [RecursiveLookup]
    args {
        question "How many conditions are there?"
        current_endpoint "/api/conditions"
        api_content #"
            {
                "count": 15,
                "results": [
                    {
                        "index": "blinded",
                        "name": "Blinded",
                        "url": "/api/conditions/blinded"
                    },
                    {
                        "index": "charmed",
                        "name": "Charmed",
                        "url": "/api/conditions/charmed"
                    },
                    {
                        "index": "deafened",
                        "name": "Deafened",
                        "url": "/api/conditions/deafened"
                    },
                    {
                        "index": "exhaustion",
                        "name": "Exhaustion",
                        "url": "/api/conditions/exhaustion"
                    },
                    {
                        "index": "frightened",
                        "name": "Frightened",
                        "url": "/api/conditions/frightened"
                    },
                    {
                        "index": "grappled",
                        "name": "Grappled",
                        "url": "/api/conditions/grappled"
                    },
                    {
                        "index": "incapacitated",
                        "name": "Incapacitated",
                        "url": "/api/conditions/incapacitated"
                    },
                    {
                        "index": "invisible",
                        "name": "Invisible",
                        "url": "/api/conditions/invisible"
                    },
                    {
                        "index": "paralyzed",
                        "name": "Paralyzed",
                        "url": "/api/conditions/paralyzed"
                    },
                    {
                        "index": "petrified",
                        "name": "Petrified",
                        "url": "/api/conditions/petrified"
                    },
                    {
                        "index": "poisoned",
                        "name": "Poisoned",
                        "url": "/api/conditions/poisoned"
                    },
                    {
                        "index": "prone",
                        "name": "Prone",
                        "url": "/api/conditions/prone"
                    },
                    {
                        "index": "restrained",
                        "name": "Restrained",
                        "url": "/api/conditions/restrained"
                    },
                    {
                        "index": "stunned",
                        "name": "Stunned",
                        "url": "/api/conditions/stunned"
                    },
                    {
                        "index": "unconscious",
                        "name": "Unconscious",
                        "url": "/api/conditions/unconscious"
                    }
                ]
            }
        "#
    }
}

test dragons_pt1 {
    functions [RecursiveLookup]
    args {
        question "Please provide a comprehensive overview of dragon types in D&D 5e, including chromatic, metallic, and other dragon classifications, their environments, and key characteristics."
        current_endpoint "/api"
        api_content #"
            {
                "ability-scores": "/api/ability-scores",
                "alignments": "/api/alignments",
                "backgrounds": "/api/backgrounds",
                "classes": "/api/classes",
                "conditions": "/api/conditions",
                "damage-types": "/api/damage-types",
                "equipment": "/api/equipment",
                "equipment-categories": "/api/equipment-categories",
                "feats": "/api/feats",
                "features": "/api/features",
                "languages": "/api/languages",
                "magic-items": "/api/magic-items",
                "magic-schools": "/api/magic-schools",
                "monsters": "/api/monsters",
                "proficiencies": "/api/proficiencies",
                "races": "/api/races",
                "rule-sections": "/api/rule-sections",
                "rules": "/api/rules",
                "skills": "/api/skills",
                "spells": "/api/spells",
                "subclasses": "/api/subclasses",
                "subraces": "/api/subraces",
                "traits": "/api/traits",
                "weapon-properties": "/api/weapon-properties"
            }
        "#
    }
}
