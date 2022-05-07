function collision_trigger()
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )

	GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/new_biome/create", x, y)
	GamePrintImportant( GameTextGet( "$log_entered", GameTextGet( "$at_hall_of_records" ) ), "" )
end

