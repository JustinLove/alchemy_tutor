function start_music( x, y )
	EntityLoad( "mods/alchemy_tutor/files/entities/remote_lab/remote_lab_music.xml", x, y )
end

function collision_trigger()
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )

	start_music( pos_x, pos_y )
end

