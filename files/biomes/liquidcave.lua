at_base_spawn_potion_altar = spawn_potion_altar

function spawn_potion_altar(x, y)
	local r = ProceduralRandom( x, y )
	
	if (r > 0.65) then
		at_base_spawn_potion_altar( x, y )
	elseif (r > 0.65 - at_chest_chance) then
		EntityLoad( at_remote_lab_chest, x, y )
	end
end
