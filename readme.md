# Alchemy Tutor - Noita mod

Adds alchemy labs throughout the world. Each lab is set up the materials to perform an alchemical reaction - perhaps useful, perhaps not, but you can mix some things together and see what happens.

## Mod status: Beta

### Whats in the beta?

- 13 alchemy labs in all the main track biomes
- Remote lab teleports findable in many other biomes
- Field labs in Overgrowth and Ancient Laboratory
- Hall of Records, a treecheivment like area that can be found in the world
- Hall of Masters, vast alchemical playgrounds with multi-step challenges which may be found, or teleported to in place of a remote lab.
- 44 experiments, from very basic (cleaning toxic) to very obscure (conversion of metals)
- +35 experiments if Alchemical Reactions Expansions is loaded.

### What might change during beta?

The goal at this point is primarly backgrounds, paintovers, and effects. Testing and feedback may still require other changes; I'll try to keep them save-in-progress compatible where possible.

### What kind of feedback am I looking for?

- Is the goal in Hall of Masters discoverable? (doesn't have to be right away - Noita is a game of mystery)
- Is the material access in Hall of Masters too good?
- Are there too many Halls of Masters?
- Are the labs too common or not common enough? (this has a setting,but I want a good default)

### What is planned for final?

- Paintovers and backgrounds for lab scenes.
- Cauldron fires, perhaps other cosmetic effects.
- Mod compatibility checking and adjustment where possible.

## Caveats

Enemies, explosions, and physics glitches can and will break all your potions and spill other stuff all over your lab. (But sometimes they also solve it for you.) If you see certain scenes that seem broken more often than not, let me know and I'll see if any adjustments can be made.

## Mod Compatibility

Most mods are untested at this point. I'm hoping to have most world changing mods checked out before leaving beta. Mods are tested in isolation, multi-mod combinations could still have issues.

### Integrations

- Alchemical Reactions Expansion
- New Biomes & Secrets - locations adjusted, tested circa 2023-04
- Noitvania - locations overhauled, tested circa 2023-04

### No Observed Incompatibility

- Alternate Biomes - tested circa 2023-05
- Anvil of Destiny - Competes for wang pixel scene slots, tested circa 2023-06
- Flesh Biome - tested circa 2023-05
- Graham's Things - tested circa 2023-05
- More Creep and Weirdos - tested circa 2023-03
- More Stuff - Competes for wang pixel scene slots, tested circa 2023-04
- Volcano Biome

## In-game Options

- Lab Spawn Chance - Main Areas: weight vs the game's built-in pixel scenes (and perhaps other mods, if they use the same system) Most vanilla scenes are 5 or 10 on this scale, but the number of scene slots, number of possible scenes, and default weight vary per biome. Feedback on a good default level appreciated.
- Lab Spawn Chance - Remote Areas: chance for a chest spawn location to contain a remote lab teleport in a non-main area without pixel scenes. This partially reduces chest spawns, but every lab can have a chest in it.
- Fixed Position Pixel Scenes: Hall of Records and Hall of Masters are in places appropriate to the default world layout. You may disable them if this causes problems with mods that change the biome map.
- Distance Dependent: uses distance from the start to influence experiment choice - this should tend to give more basic recipes in early levels, more appropriate for people only reaching that level. However, there is still randomness and some other factors at involved.
- Progression Dependent: Formulas will be simplified the first time encountered, and the obscurity will be limited by the total number solved.
