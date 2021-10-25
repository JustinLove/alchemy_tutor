
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

- x way to garanteed spawn a scene for testing

- append to biome file pixel scenes
- define material trigger and script
- setup spawn lists
- select recepies

- portrait version?
- other biome versions?
- background?
