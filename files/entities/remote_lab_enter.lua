function start_music( x, y )
	--GameTriggerMusicFadeOutAndDequeueAll( 3.0 )
	--GameTriggerMusicEvent( "music/temple/enter", false, x, y )
	--GameTriggerMusicEvent( "music/mountain/enter", false, x, y )
	GamePlaySound( "data/audio/Desktop/music.bank", "music/temple/enter", x, y)
end

function collision_trigger()
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )

	--start_music( pos_x, pos_y )
end

