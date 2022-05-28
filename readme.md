# Alchemy Tutor - Noita mod

Adds alchemy labs throughout the world. Each lab is set up the materials to perform an alchemical reaction - perhaps useful, perhaps not, but you can mix some things together and see what happens.

## Mod status: Alpha

### Whats in the alpha?

- 13 alchemy labs in all the main track biomes
- Remote lab teleports findable in many other biomes
- Field labs in Overgrowth and Ancient Laboratory
- Hall of Records, a treecheivment like area that can be found in the world
- 41 experiments, from very basic (cleaning toxic) to very obscure (conversion of metals)
- +35 experiments if Alchemical Reactions Expansions is loaded.

### What might change during alpha?

- Lab design tweaks, and possibly total reworks
- Formula changes based on feedback and testing
- Backend code changes and fixes if needed (these could affect a save in progress, but mostly things get setup when the scene gets generated).

### What kind of feedback am I looking for?

- Are the labs too common or not common enough? (this has a setting,but I want a good default)
- Are certain labs/formulas likely to break?
- Are some formulas too basic?
- Do you think it's missing an important reaction?
- I left in a setup for cooking meat - but can't really detect success. Should it stay or go?
- Are chests enough of a reward, but not too good?

### What is planned for beta?

Things I want to try - which may not be successful:

- Perhaps multi-step challenges

### What is planned for final?

- Paintovers and backgrounds for lab scenes.
- Cauldron fires, perhaps other cosmetic effects.

## Caveats

Enemies, explosions, and physics glitches can and will break all your potions and spill other stuff all over your lab. (But sometimes they also solve it for you.) If you see certain scenes that seem broken more often than not, let me know and I'll see if any adjustments can be made.

## In-game Options

- Lab Spawn Chance - Main Areas: weight vs the game's built-in pixel scenes (and perhaps other mods, if they use the same system) Most vanilla scenes are 5 or 10 on this scale, but the number of scene slots, number of possible scenes, and default weight vary per biome. Feedback on a good default level appreciated.
- Lab Spawn Chance - Remote Areas: chance for a chest spawn location to contain a remote lab teleport in a non-main area without pixel scenes. This partially reduces chest spawns, but every lab can have a chest in it.
- Distance Dependent: uses distance from the start to influence experiment choice - this should tend to give more basic recipes in early levels, more appropriate for people only reaching that level. However, there is still randomness and some other factors at involved.
- Progression Dependent: Formulas will be simplified the first time encountered, and the obscurity will be limited by the total number solved.
