dofile_once("mods/alchemy_tutor/files/spawns.lua")

at_default_cauldron = at_steel_pit

at_base_spawn_potion_altar = spawn_potion_altar

function spawn_potion_altar(x, y)
	local r = ProceduralRandom( x, y )
	
	if (r > 0.65) then
		at_base_spawn_potion_altar( x, y )
	elseif (r > 0.65 - at_chest_chance) then
		EntityLoad( at_remote_lab_chest, x, y )
	elseif (r > 0.65 - at_chest_chance*2) then
		at_spawn_mini_lab( x, y )
	end
end

function at_spawn_mini_lab( x, y )
	at_preclear_for_mini( x, y, 60 )
	LoadPixelScene( "mods/alchemy_tutor/files/biome_impl/liquidcave_lab_mini.png", "", x-90, y-60, "", true )
end

--spawn_potion_altar = at_spawn_mini_lab
