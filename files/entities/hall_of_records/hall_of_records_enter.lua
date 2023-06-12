function collision_trigger()
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )

	GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/new_biome/create", x, y)
	local text = GameTextGet( "$at_hall_of_records" )
	if text == '' then
		text = 'Alchemy Tutor translations are broken, please report current mod list'
	end
	GamePrintImportant( GameTextGet( "$log_entered", text ), "" )
end

