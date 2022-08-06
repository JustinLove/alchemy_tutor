at_remote_lab_chance = ModSettingGet("alchemy_tutor.remote_lab_chance")
if at_remote_lab_chance == nil then
	at_remote_lab_chance = 1
end

at_chest_chance = at_remote_lab_chance / 2
at_remote_lab_chest = "mods/alchemy_tutor/files/entities/remote_lab_chest.xml"
at_hall_of_masters_chest = "mods/alchemy_tutor/files/entities/hall_of_masters_chest.xml"
at_hall_of_masters_location_count = 3 -- hall_of_masters.lua location list

function at_spawn_remote_lab_chest( x, y )
	local master_count = tonumber( GlobalsGetValue( "AT_HALL_OF_MASTERS_COUNT", "0" ) )
	local passed_count = tonumber( GlobalsGetValue( "at_passed_count", 0 ) )
	local r = Random( 1, 100 )
	if r < passed_count and master_count < at_hall_of_masters_location_count then
		EntityLoad( at_hall_of_masters_chest, x, y )
	else
		EntityLoad( at_remote_lab_chest, x, y )
	end
end

function at_spawn_hall_of_masters_chest( x, y )
	EntityLoad( at_hall_of_masters_chest, x, y )
end

function at_spawn_mini_lab( x, y )
	at_spawn_remote_lab_chest( x, y )
end

at_base_spawn_heart = spawn_heart

function at_spawn_heart( x, y )
	-- same seeded call as base spawn heart; we should get the same number
	local r = ProceduralRandom( x, y )

	if 0.3 - at_chest_chance < r and r < 0.3 then
		at_spawn_remote_lab_chest( x, y )
	elseif 0.3 < r and r < 0.3 + at_chest_chance then
		at_spawn_mini_lab( x, y )
	else
		at_base_spawn_heart( x, y )
	end
end

spawn_heart = at_spawn_heart

function at_remove_remote_lab_key()
	spawn_heart = at_base_spawn_heart
end

--at_remove_remote_lab_key()
