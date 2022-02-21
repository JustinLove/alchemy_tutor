function stop_music( x, y )
	GameTriggerMusicFadeOutAndDequeueAll( 3.0 )
end

function collapse_lab( x, y )
	GamePrintImportant( "Exit" )
	EntityLoad("data/entities/misc/workshop_collapse.xml", x, y )

	GameTriggerMusicFadeOutAndDequeueAll( 2.0 )
	GamePlaySound( "data/audio/Desktop/misc.bank", "misc/temple_collapse", x, y )
end

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local p = EntityGetInRadiusWithTag( x, y, 150, "player_unit" )

if ( #p == 0 ) then
	--stop_music( x, y )
	--collapse_lab( x, y )
	EntityKill( entity_id )
end
