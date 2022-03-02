dofile_once('mods/alchemy_tutor/files/entities/remote_lab/remote_lab.lua')

function collision_trigger()
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )

	at_remote_lab_exit( pos_x, pos_y )
	EntityKill( entity_id )
end

