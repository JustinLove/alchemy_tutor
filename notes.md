- multi-step challenges?
  - central mixing area not needed?
  - instancing
  - persistant spawning
    - pixel trigger load timing
    - return portals if loaded normally
    - pixel scenes.xml are not in parallel worlds
  - lava leakage
  - detect void?
  - output water? (ex) readily available
  - touch of water
  - target selection criteria?
  - item spawning
    - hall of records - roughed in
    - customize item - temp
  - altar art
  - gold is root of all solids
    - needs lots of poly??
- pillars??

- check hanging with special detectors

- background?
- cauldron fires
- translations - partly done

  - bulk storage areas
    - x 4 big (5-6 units)
    - x 21 (3 units) (don't seem to need 21 in practice)

- watchlist
  - steel cauldrons - `steel_static_strong`
  - double lab spawn - added logging
  - remote biomes
    - x breakage problems - extended delay
    - x exit detection?
  - scene lab chance overage?
  - item spawns break over 50000 down
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
  - suspended container tele+mana, self solved
  - brass + unstable tele burned
  - concentrated mana/wizardbrik didn't activate
  - green fungi did not activate for void1
  - double spawn of mystery fungus on level 1

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

- x vomit + toxic = urine
- x charm + [blood] + [magic_polymorph] = regen
- x flum + gunpowder = accel
- x ambrosia + gold = regen - custom detector
- x mana + alcohol = ambrosia
- x plasma + toxic = magic_liquid
- x tele + blood = plasma
- x plasma + water = mana
- x slime + toxic = pea soup
- x lava + slime = endslime
- x urine + soil = poo
- x salt + snow = water
- x fire + urine = salt
- x worm pher + any poly = worm pher
- x worm blood + brine = cheese - custom detector
- x blood + worm phere = berserk
- x unstable poly + slime = poly
- x flum + coal = stable tele
- x inivs + fire = invis
- x slime + bluefungi = invis - custom cauldron
- x fungi blood + bluefungi = flum - custom cauldron
- x blood cold + oil = wax
- x oil + fire + berserk = red plastic
- x worm blood + water ice = purifying powder
- x diamond + sand = blue sand - custom checker
- x blue sand + sand = sand
- x blue sand + lava = diamond - transient
- x diamond + lava = diamond brick - custom checker
- x bone + lava = coal
- x bone + sand = sodium
- x fungus blood + sand = fungi - custom checker
- x fungus blood + blue sand = green fungi
- x brass + toxic = oil
- x poison + swamp = poison
- x slime + dead soil = poison - custom cauldron

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

## Records

1  x toxic + water = water -> toxic (cauldron)
2  mana + steel = mana steel platform? mat if cust cauld yes
3  mana + water = mana  xx cauldron matif cust cauld yes; both NO
4  x slime + water = empty -> slime (cauldron)  xxx not cauldron only, good with cauldron empty  check
5  x *tele + mana = empty -> fire? xxx filled by empty cauldron
6  x slime/alcohol = empty -> alcohol? xxx slime by empty
7  x levi + accel = haste
8  slime + faster -> empty -> gunpowder??, half potion? matif cust cauld yes
9  wizardstone + water = teleportion -> brick pillar? mat if cust cauld NO
10 x invis + water = water -> inivis (cauldron)
11 x flum + berserk = charm
12 x worm pher + worm blood = flum
13 wizardstone + mana = acid -> brick pillar?
14 x unstabletele + slime = stable
15 x wizardstone + amb = steam -> brick pillar?
16 x flum + metal powder = levi
17 x flum + unst tele = guiding
18 x toxic/sand/fungusblood = fungus creeping -> fungus patch?
19 toxic/wormblood/fungi = void liquid 1 -> smaller?
20 x purifying + lava = empty -> lava?  xx cauldron air
21 x flum + blood + oil = unstable poly
22 x diamond + random = silver
23 x stable + alcohol = unstable
24 x gold + random = silver
25 x poly + toxic = random
26 brass + liquid fire = shock powder -> sparking block?
27 voidfungus = void -> fungal block mat if cust cauld yes
28 x diamond + random + toxic = void
29 x brass + unstable tele = metal powder
30 x alchol + frog meat = berserk
31 x silver + poly = copper
32 x copper + tele = brass
33 x blood + poison = slime -> poison?
34 x salt + water -> brine
35 x honey + diamond = ambrosia + poison
36 x diamond + silver + wormblood = purifying
37 cooking meat = meat potion -> sausage pan?
38 x brass + diamond = purifying
39 x burn brine = salt
40 x copper + brass + water = silver
41 x silver + copper + blood = diamond

-  wizardstone + fire = lava
-  void + toxic = void

## Pedestal materials

### mat
- wizardstone assumed

### mat if cust cauldon
- wizardstone assumed

### both
- wood, air

### cauldron
- steel is wizardstone


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

## Pixel Scenes

- can be processed concurrently, starting one before another is finished.
- pixel scenes triggered within a pixel scene are (can be?) processed immediately, before the next pixel in the parent scene
- there can be significant delay in drawing child pixel scenes


    Thatrius — Today at 16:46
    Seems like I remember accomplishing this by messing around with materials_that_create_messages from DamageModelComponent
    okay yeah you just add the material to materials_that_create_messages, and then check if mCollisionMessageMaterials[index of material] is > 0 
