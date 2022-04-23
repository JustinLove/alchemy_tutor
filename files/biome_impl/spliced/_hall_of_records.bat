pushd ..\..\
noita_dev.exe -splice_pixel_scene mods/alchemy_tutor/files/biome_impl/spliced/hall_of_records.png -x -6144 -y 512 -debug 1
rem move data\biome_impl\spliced\* mods\alchemy_tutor\files\biome_impl\spliced\
rem move data\biome_impl\spliced\* mods\alchemy_tutor\data\biome_impl\spliced\
del data\biome_impl\spliced\hall_of_records.xml
move data\biome_impl\spliced\hall_of_records\* mods\alchemy_tutor\files\biome_impl\spliced\hall_of_records\
rem move data\biome_impl\spliced\hall_of_records\* mods\alchemy_tutor\data\biome_impl\spliced\hall_of_records\
popd
