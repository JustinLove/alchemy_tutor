pushd ..\..\
noita_dev.exe -splice_pixel_scene mods/alchemy_tutor/files/biome_impl/spliced/hall_of_masters.png -x 13824 -y -4096 -debug 1
rem move data\biome_impl\spliced\* mods\alchemy_tutor\files\biome_impl\spliced\
rem move data\biome_impl\spliced\* mods\alchemy_tutor\data\biome_impl\spliced\
rem move data\biome_impl\spliced\hall_of_masters\* mods\alchemy_tutor\data\biome_impl\spliced\hall_of_masters\
del data\biome_impl\spliced\hall_of_masters.xml
move data\biome_impl\spliced\hall_of_masters\* mods\alchemy_tutor\files\biome_impl\spliced\hall_of_masters\
popd
