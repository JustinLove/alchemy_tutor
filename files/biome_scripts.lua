dofile_once( 'mods/alchemy_tutor/files/entities/hall_of_masters/hall_of_masters_locations.lua' )

at_remote_lab_chance = ModSettingGet("alchemy_tutor.remote_lab_chance")
if at_remote_lab_chance == nil then
	at_remote_lab_chance = 1
end
-- remote labs are isolated, couldn't do anything without materials
if ModSettingGet("alchemy_tutor.no_freebies") then
	at_remote_lab_chance = 0
end

at_chest_chance = at_remote_lab_chance / 2
at_remote_lab_chest = "mods/alchemy_tutor/files/entities/remote_lab_chest.xml"
at_hall_of_masters_chest = "mods/alchemy_tutor/files/entities/hall_of_masters_chest.xml"
if ModSettingGet("alchemy_tutor.fixed_pixel_scenes") then
	at_hall_of_masters_location_count = #at_lab_locations
else
	at_hall_of_masters_location_count = 0
end

function at_spawn_remote_lab_chest( x, y )
	local master_count = tonumber( GlobalsGetValue( "AT_HALL_OF_MASTERS_COUNT", "0" ) )
	local passed_count = tonumber( GlobalsGetValue( "at_passed_count", 0 ) )
	local r = Random( 1, 100 )
	if r < 20 and r < passed_count and master_count < at_hall_of_masters_location_count then
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

local can_spawn_remote_lab_key = true
at_base_spawn_heart = spawn_heart

function at_spawn_heart_or_remote_lab( x, y )
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

function at_spawn_heart( x, y )
	if can_spawn_remote_lab_key then
		at_spawn_heart_or_remote_lab( x, y )
	else
		at_base_spawn_heart( x, y )
	end
end

spawn_heart = at_spawn_heart

function at_remove_remote_lab_key()
	can_spawn_remote_lab_key = false
end

--at_remove_remote_lab_key()
