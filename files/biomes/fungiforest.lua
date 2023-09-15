dofile_once("mods/alchemy_tutor/files/spawns.lua")

at_biome_banned_materials = { "void_liquid", "blood_worm" }

function at_spawn_mini_lab( x, y )
	at_preclear_for_mini( x, y, 80 )
	LoadPixelScene(
		"mods/alchemy_tutor/files/biome_impl/fungiforest_lab_mini.png",
		"mods/alchemy_tutor/files/biome_impl/fungiforest_lab_mini_visual.png",
		x-100, y-90,
		"mods/alchemy_tutor/files/biome_impl/fungiforest_lab_mini_background.png",
		true )
end

--spawn_heart = at_spawn_mini_lab
