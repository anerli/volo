## 🎲 Volo - The Loquacious D&D 5e Knowledge Companion
An Interactive D&D 5e Reference Bot in the Style of Volo's Guides


### Setup
```
pip install git+https://github.com/anerli/volo.git
```

Volo requires Anthropic API Keys to function. Create an account with [Anthropic](https://www.anthropic.com/api), then [generate an API key](https://console.anthropic.com/settings/keys) and assign the generated key to an `ANTHROPIC_API_KEY` environment variable.


### How to Run
```
python -m volo.main
```

### Example
```
> Hi, give me an overview of different goblin types

Let me consult my extensive notes on these fascinating, if somewhat infuriating, little creatures.

Ah, my dear adventurer! Let me regale you with the fascinating details of goblinoid varieties that have caused no small amount of trouble across the realms!

Primarily, you'll encounter three distinct goblin types:

1. Goblins: The most common and weakest of the lot. Small, green-skinned miscreants who are numerous, cowardly, and typically found in large groups. They're crafty little blighters who rely on overwhelming numbers and sneaky tactics.

2. Hobgoblins: These are the disciplined, militaristic cousins of goblins. Unlike their chaotic kin, hobgoblins are organized, strategic, and form regimented armies. They're larger, more intelligent, and far more dangerous in structured combat. Many a caravan has met its doom at their well-planned ambushes!

3. Bugbears: The largest and most brutish of the goblinoid family. These hulking, hairy monstrosities are the shock troops of goblin societies - powerful, stealthy, and with a penchant for surprising their victims. They're the nightmarish big brothers that make even other goblins nervous.

Each type has its own delightful method of causing mayhem, and I, Volo, have narrowly escaped their clutches more times than I care to count! A word of advice: never underestimate these devious creatures.

Would you like me to elaborate on any of these goblinoid types?

[Sources: https://www.dnd5eapi.co/api/monsters?name=goblin]

> How much health does a bugbear have?

By the gods, I shall consult my most detailed bestiary to determine the precise vitality of these hirsute terrors!

According to my meticulous notes - and trust me, I've studied these creatures extensively - a standard Bugbear has 27 hit points, calculated from 5d8+5. 

Their robust constitution allows them to take a fair bit of punishment, which makes them particularly dangerous in an ambush. Remember their "Surprise Attack" ability can add an extra 2d6 damage in the first round of combat, making them even more lethal than their hit points might initially suggest!

A word to the wise: approach a Bugbear with caution, preparation, and preferably a very sharp weapon.

[Sources: https://www.dnd5eapi.co/api/monsters/bugbear]
```

### About
When Volo can't answer a question directly, he will use https://www.dnd5eapi.co to find relevant information.

Volo may use more API credits than it looks like, since there are additional prompts running to retrieve information that you cannot see. However, Volo uses Anthropic's Haiku 3.5 model which is generally very cheap even for large volumes of information.

Volo may not always give perfectly accurate responses to all questions - for example if he fails to find the corresponding resource in the 5e API.


### Other Possible Additions
- Tool for Volo to filter or sort internal results more easily
- Better interface / web interface
- Systems for generating scenarios