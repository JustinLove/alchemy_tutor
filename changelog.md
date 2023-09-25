# Alchemy Tutor Changelog

## 0.10.0

- Art pass for mini field labs
- Main cauldron background rework in line with master tanks style
- Reward frame made a tiny bit more elaborate

## 0.9.0 Hall of Masters art update

- Art update for Hall of Masters
- Altars have been reworked in stone to reduce risk of electrical shock.
- Fix missing drains in empty large bins (and empty no longer has a right bias)
- Some changes to random calls, material placements, and material layer in hall of masters may affect saves in progress.
- Removed a regular fallback reward that I've seen double activate more often than be a proper fallback.

## 0.8.0

- Main path spawn rates reworked again - the max value proved insufficient for high intensity mod testing.
- Locations adjusted for NG+, but random overwrites can still occur
- The distance/progression settings have been combined, making them mutually exclusive - distance seemed to mainly do melt steel in low progress states.
- New setting: No Freebies, for the alchemist who likes to do everything themselves.
- New setting: Run Based Progress, start the progress system from scratch with every run
- Hall of Records can update after initial spawn
- Added a teleporter safety note to the arcane mysteries
- Printing to log is now optional when Enable Logging is on.

## 0.7.0

- Art update for Hall of Records
- Signs on completed formula in Hall of Records
- Changelog in Hall of Records
- Two new evaporation reactions
- One new bloody reaction
- One new swampy reaction
- Hall of Master rewards are proportional to intended complexity. Feedback appreciated.
- Hall of Master locations have assigned complexity based on accessability. Feedback appreciated.
- Main biome lab spawns were perhaps too common in some biomes and have been significnatly rebalanced. Feedback appreciated.

## 0.6.1

- Adjusted appends to remove load order dependency with Graham's Things and Anvil of Destiny
- Adjusted some fixed pixel scenes for Apotheosis map

## 0.6.0

- Reduced maxium steps in Hall of Masters
- Art update for main biome pixel scenes.
- Art update for remote labs.
- Vault horizontal potions have been sterilized in alcohol to try and improve stability.
- Adjusted fixed scene positions for New Biomes + Secrets.
- Adjusted fixed scene positions for Noitavania.
- Added emergency return portal to remote lab in case we are in an incompatible biome mod.
- Extracted hall of masters locations to separate file to ease integration by other mods.
- Extracted hall of records pixel scene insert to separate file to ease integration by other mods.
- Changed remote lab location setup for easier overriding.
- Changed ghost crystal spawning for easier overriding.
- Changes to translation setup to deal with changes made by other mods.
- Notice: further changes that affect mod integration may be investigated.

## 0.5.1

- Precautionary update for teleporters that could be generated into locations that had been previously generated without their intended destination scenes.

## 0.5.0 Hall of Masters Update

- Added Halls of Masters - the other labs are training, this is the test. Complete multi-step challenges for new prizes. An entryway may sometimes be found in place of a remote lab, or simply go exploring.
- Added option setting to not spawn fixed-position scenes, for use with mods that alter the biome map (this of course removes several features)
- Added several metal sand alternates to Levitatium recipe.
- Powder sacks are 66% full instead of full, like in vanilla.
- Frog cage includes a shotgun, in case your wands are inappropriate to the task.

## 0.4.0 Hall of Records Update

- Added the Hall of Records, a treecheivment like area that can be found in the world

## 0.3.0 Field Labs Update

- Added mini field labs to Overgrowth and Ancient Laboratory
- Testing Dense Steel as the default cauldron material

## 0.2.0 Remote Labs Update

- Remote Alchemy Labs for areas outside the main descent, which do not have pixel scenes, look for the entryways where chests might spawn. Frequency of appearance has a separate setting.
- Progression tracking. Formulas will be simplified the first time encountered, and the obscurity will be limited by the total number solved. (Master alchemists can disable this in settings.)
- Rework on Hisii vertical; removed a cauldron to make space for sheltered potion storage.
- Change vault horizontal potion platform from catwalk to solid to try and reduce breakage.
- Tweaked cloth (pouches) to not conduct electricity. An alchemist who takes the Electicity perk will probably still have a bad day, but at least you can use pouches now.
- Put lab decoration on a delay to try and give terrain a chance to spawn in.
- Added smoke to make torches more visible

## 0.1.0

- Went ahead and added Alchemical Reactions Expansion recipes, since I wanted to start testing them
- As part of the above, made some major updates; there are new fast detector types which should improve several formula; things that were impractical before can now usually trigger a chest - including cooking meat.
- Also as part of expansion, added a rating system so new recipes can sort in appropriately; this resulted in many formula being reordered.
- Added formula for salt and brine, since ARE has a salt formula.
- Formula that need to start a fire now provide a torch wand instead of a fire potion.
- The fungi garden provides garden shears in case you don't have a good spell on your wands
- Attempt to fix occasional disappearance of coal pits containers when activated.
- Tweak potion height in vault horiz.
- Remove left barrier in first level horiz.
- jungle pit is made of dense steel, which does not melt to mana.
- offset material checkers to reduce simultaneous success.
- removed cables from hisii base horiz.
