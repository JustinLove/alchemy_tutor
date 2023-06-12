dofile_once("mods/alchemy_tutor/files/entities/hall_of_masters/hall_of_masters.lua")

local announced = false
function collision_trigger()
	if announced then
		return
	end
	announced = true

	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )


	GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/new_biome/create", pos_x, pos_y )
	local pw,_ = at_check_parallel_pos( pos_x )
	print(pw)
	local biome_name = GameTextGet( "$at_hall_of_masters" )
	if biome_name == '' then
		biome_name = 'Alchemy Tutor translations are broken, please report current mod list'
	end
	if pw < 0 then
		biome_name = GameTextGet( "$biome_west", biome_name )
	end
	if pw > 0 then
		biome_name = GameTextGet( "$biome_east", biome_name )
	end

	GamePrintImportant( GameTextGet( "$log_entered", biome_name ), "" )
end

