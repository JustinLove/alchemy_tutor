- watchlist
  - ?? jungle rock awol
  - right potions broken in jungle h
  - vault h
    - only one broken potion
    - no potions
    - missing water potion, had red herrings
    - potions fell
  - vault v
    - pool drained, no potions
    - diamond, water, nothing in pot
    - breaks common
  - hisi h diamond and water
  - crypt v, polymorphine and toxic, maybe slime
- double trigger on regular cauldron (both clearing toxic)
- remote biomes
  - spawn key
  - clear on return/use
  - remote lab design
  - exit sequence
  - key design
- multi-step challenges?
- grand alchemy labs

- solids in cauldron - whether to remove cauldron material/ which formula???
- background?
- cauldron fires
- repeat resitance??
- progression tracking
- Alchemical Reactions Expansion

- snow is awkward with powders - maybe okay as puzzle element?

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

### Alchemical Reactions Extended
Breaks void detection

- vomit + toxic = urine
- charm + [blood] + [magic_polymorph] = regen
- flum + gunpowder = accel
- ambrosia + gold = regen
- mana + alcholo = ambrosia
- plasma + toxic = magic_liquid
- unstale tele + blood = plasma
- slime + toxic = pea soup
- lava + slime = endslime
- urine + soil = poo
- salt + snow = water
- fire + urine = salt
- worm pher + any poly = worm pher
- worm blood + brine = cheese
- blood + worm phere = berserk
- unstable poly + slime = poly
- flum + coal = stable tele
- inivs + fire = invis
- slime + bluefungi = invis
- fungi blood + bluefungi = flum
- blood cold + oil = wax
- oil + fire + berserk = red plastic
- worm blood + water ice = purifying powder
- diamond + sand = blue sand
- blue sand + sand = sand
- blue sand + lava = diamond
- diamond + lava = diamond brick
- bone + lava = coal
- bone + sand = sodium
- fungus blood + sand = fungi
- fungus blood + blue sand = green fungi
- braass + toxic = oil
- poison + swamp = poisen
- poison + dead soil = poisen
- slime + dead soil = poisen
- plasma + water = mana

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

