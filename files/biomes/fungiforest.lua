dofile_once("mods/alchemy_tutor/files/spawns.lua")

at_biome_materials = { "void_liquid", "blood_worm" }

spawn_heart = at_spawn_heart

function at_spawn_mini_lab( x, y )
	LoadPixelScene( "mods/alchemy_tutor/files/biome_impl/fungiforest_lab_mini.png", "", x-100, y-90, "", true )
end
