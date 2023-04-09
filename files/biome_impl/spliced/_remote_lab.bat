pushd ..\..\
noita_dev.exe -splice_pixel_scene mods/alchemy_tutor/files/biome_impl/spliced/remote_lab.png -x 0 -y 0 -debug 1
del data\biome_impl\spliced\remote_lab.xml
rem move data\biome_impl\spliced\remote_lab.xml mods\alchemy_tutor\files\biome_impl\spliced\
move data\biome_impl\spliced\remote_lab\* mods\alchemy_tutor\files\biome_impl\spliced\remote_lab\
popd
