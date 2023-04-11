pushd ..\..\
noita_dev.exe -splice_pixel_scene mods/alchemy_tutor/files/biome_impl/spliced/hall_of_records.png -x -6144 -y 512 -debug 1
move data\biome_impl\spliced\hall_of_records.xml mods\alchemy_tutor\files\biome_impl\spliced\hall_of_records_generated.xml
move data\biome_impl\spliced\hall_of_records\* mods\alchemy_tutor\files\biome_impl\spliced\hall_of_records\
rem move data\biome_impl\spliced\hall_of_records\* mods\alchemy_tutor\data\biome_impl\spliced\hall_of_records\

noita_dev.exe -splice_pixel_scene mods/alchemy_tutor/files/biome_impl/spliced/hall_of_records.png -x -9215 -y 6144 -debug 1
move data\biome_impl\spliced\hall_of_records.xml mods\alchemy_tutor\files\noitavania\hall_of_records_generated.xml
del data\biome_impl\spliced\hall_of_records\*
popd
