local at_base_spawn_potion_altar = spawn_potion_altar

dofile_once("mods/alchemy_tutor/files/remote_lab_spawns.lua")

function spawn_potion_altar(x, y)
	local r = ProceduralRandom( x, y )
	
	if (r > 0.20) then
		at_base_spawn_potion_altar( x, y )
	else
		at_spawn_meditation_altar( x, y )
	end
end
