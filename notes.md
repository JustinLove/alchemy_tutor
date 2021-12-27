- ?? jungle rock awol
- redesigns
- blank reward frame
- test hanging containers
- fungus garden cauldron
- material exclusions for cauldrons
- void spreads through fungus
- remote biomes
  - spawn key
  - clear on return/use
  - remote lab design
  - exit sequence
  - key design
- grand alchemy labs

- solids in cauldron - whether to remove cauldron material/ which formula???
- background?
- cauldron fires
- repeat resitance??
- Alchemical Reactions Expansion

- snow is awkward with powders - maybe okay as puzzle element?
- vault potions may be too exposed from above

- x toxic + water
- x mana + water
- x mana + steel
- x invis + water = water
- x slime + faster
- x slime + water/alcohol
- x toxic/wormblood/fungi = void liquid
- x toxic/sand/fungusblood = fungus creeping
- x brass + diamond = purifying
- x levi + accel = haste
- x flum + berserk = charm
- x worm pher + worm blood = flum
- x flum + blood + oil = unstable poly
- xx unstele + stable + water = unstable
- x stable + alcohol = unstable
- x unstabletele + slime = stable
- x *tele + mana = fire
- x poly + toxic = random
- x flum + metal powder = levi
- x alchol + frog meat = berserk
- x honey + diamond = ambrosia + poison
- x flum + unst tele = guiding
- x diamond + random = silver
- x gold + random = silver
- x silver + poly = copper
- x copper + tele = brass
- x brass + unstable tele = metal powder
- x blood + poison = slime
- x copper + brass + water = silver
- x silver + copper + blood = diamond
- x diamond + silver + wormblood = purifying
- x diamond + random + toxic = void
- x void + toxic = void
- x brass + liquid fire = shock powder
- x purifying + lava = gunpowder
- x wizardstone + water = teleportion
- x wizardstone + mana = acid
- x wizardstone + fire = lava
- x wizardstone + amb = steam
- x cooking meat

- x vault
  - v 01 x1 acid tank
  - v tall x2 electric tunnel *
  - h 02 x2 labs
  - h wide x2 brain/shop *
- x crypt
  - v 03 x2
  - h 01 x2, 3 things *
  - h 05 x1, 3 things
  - h 05b x1, 3 things

```
biome_impl/biome_map.png (etc) - color map of biomes
biomes/_biomes_all.xml - color to biome map
wang_tiles/coalmine.png - some tiles blank with marker pixel in corner
data/scrits/wang_scripts.csv - corner color to lua function(biome dependant)
scripts/biomes/coalmine.lua
  - load_pixel_scene2 - called function to load custom pixel scene
  - RegisterSpawnFunction - pixel scene color to function map (e.g. spawn material checker), function in same file
scripts/director_helpers.lua - load_random_pixel_scene
biome_impl/coalmine/receptacle_oil(_background, _visual).png
entities/buildings/receptacle_oil.xml - material area checker, runs script on success
entities/buildings/receptacle_oil.lua - material_area_checker_success function
entities/items/pickup/potion.xml

```

