pushd ..\..\

noita_dev.exe -splice_pixel_scene mods/alchemy_tutor/files/biome_impl/spliced/hall_of_records.png -x -9215 -y 6144
powershell -Command "(gc -Raw data\biome_impl\spliced\hall_of_records.xml) -replace 'data/', 'mods/alchemy_tutor/files/' -replace '(?s)\s+<Pixel[^>]+5\.plz[^>]+>\s+</PixelScene>', '' | Out-File -encoding ASCII data\biome_impl\spliced\hall_of_records.xml
move data\biome_impl\spliced\hall_of_records.xml mods\alchemy_tutor\files\noitavania\hall_of_records.xml

noita_dev.exe -splice_pixel_scene mods/alchemy_tutor/files/biome_impl/spliced/hall_of_records.png -x -6656 -y 16384
powershell -Command "(gc -Raw data\biome_impl\spliced\hall_of_records.xml) -replace 'data/', 'mods/alchemy_tutor/files/' -replace '(?s)\s+<Pixel[^>]+5\.plz[^>]+>\s+</PixelScene>', '' | Out-File -encoding ASCII data\biome_impl\spliced\hall_of_records.xml
move data\biome_impl\spliced\hall_of_records.xml mods\alchemy_tutor\files\newgame_plus\hall_of_records.xml

noita_dev.exe -splice_pixel_scene mods/alchemy_tutor/files/biome_impl/spliced/hall_of_records.png -x -6144 -y 512
powershell -Command "(gc -Raw data\biome_impl\spliced\hall_of_records.xml) -replace 'data/', 'mods/alchemy_tutor/files/' -replace '(?s)\s+<Pixel[^>]+5\.plz[^>]+>\s+</PixelScene>', '' | Out-File -encoding ASCII data\biome_impl\spliced\hall_of_records.xml
move data\biome_impl\spliced\hall_of_records.xml mods\alchemy_tutor\files\biome_impl\spliced\hall_of_records.xml
move data\biome_impl\spliced\hall_of_records\* mods\alchemy_tutor\files\biome_impl\spliced\hall_of_records\
rem move data\biome_impl\spliced\hall_of_records\* mods\alchemy_tutor\data\biome_impl\spliced\hall_of_records\

popd
