function announce( x, y )
	GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/new_biome/create", x, y)
	GamePrintImportant( GameTextGet( "$log_entered", tostring( "Hall of Masters" ) ), "" )
end

function start_music( x, y )
	--GameTriggerMusicFadeOutAndDequeueAll( 3.0 )
	--GameTriggerMusicEvent( "music/temple/enter", false, x, y )
	--GameTriggerMusicEvent( "music/mountain/enter", false, x, y )
	GamePlaySound( "data/audio/Desktop/music.bank", "music/temple/enter", x, y)
end

function check_for_exit( x, y )
	EntityLoad( "mods/alchemy_tutor/files/entities/remote_lab_exit.xml", x, y )
end

function collision_trigger()
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )

	announce( pos_x, pos_x )
	--start_music( pos_x, pos_y )
	check_for_exit( pos_x, pos_y )
end

