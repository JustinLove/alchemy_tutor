at_lab_chance = ModSettingGet("alchemy_tutor.lab_chance")
if at_lab_chance == nil then
	at_lab_chance = 1
end
--at_lab_chance = 9999999

at_chest_chance = math.floor(math.sqrt(at_lab_chance) * 10)
at_remote_lab_chest = "mods/alchemy_tutor/files/entities/remote_lab_chest.xml"

function at_spawn_remote_lab_key( x, y )
end

at_base_spawn_heart = spawn_heart

function spawn_heart( x, y )
	-- same seeded call as base spawn heart; we should get the same number
	local r = ProceduralRandom( x, y )

	if 0.3 - at_chest_chance < r and r < 0.3 + at_chest_chance then
		EntityLoad( at_remote_lab_chest, x, y )
	else
		at_base_spawn_heart( x, y )
	end
end

function at_remove_remote_lab_key()
	spawn_heart = at_base_spawn_heart
end

--at_remove_remote_lab_key()
