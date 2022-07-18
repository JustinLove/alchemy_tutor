pushd ..\..\
noita_dev.exe -splice_pixel_scene mods/alchemy_tutor/files/biome_impl/spliced/hall_of_masters.png -x -15360 -y 15872 -debug 1
rem move data\biome_impl\spliced\* mods\alchemy_tutor\files\biome_impl\spliced\
move data\biome_impl\spliced\hall_of_masters.xml mods\alchemy_tutor\data\biome_impl\spliced\hall_of_masters_sw_gold.xml
del /Q data\biome_impl\spliced\hall_of_masters\*
popd
