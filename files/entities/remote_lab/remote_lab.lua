function at_spawn_remote_lab( x, y )
	LoadPixelScene(
		"mods/alchemy_tutor/files/biome_impl/spliced/remote_lab/0.plz",
		"mods/alchemy_tutor/files/biome_impl/spliced/remote_lab/0_visual.plz",
		x + 232, y + 1,
		"mods/alchemy_tutor/files/biome_impl/spliced/remote_lab/0_background.png",
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{
		}, -- color_to_matieral_table
		50 -- z index
	)
	LoadPixelScene(
		"mods/alchemy_tutor/files/biome_impl/spliced/remote_lab/1.plz",
		"mods/alchemy_tutor/files/biome_impl/spliced/remote_lab/1_visual.plz",
		x + 512, y + 80,
		"mods/alchemy_tutor/files/biome_impl/spliced/remote_lab/1_background.png",
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{
		}, -- color_to_matieral_table
		50 -- z index
	)
end

-- 19,45; off bottom of biome map
local remote_lab_x = 8704
local remote_lab_y = 23040
local remote_lab_copies_across = 8
local entrance_x = 330
local entrance_y = 77

function at_get_lab_location()
	local iteration = tonumber( GlobalsGetValue( "AT_REMOTE_LAB_COUNT", "0" ) )

	local x = remote_lab_x + ( ( iteration % remote_lab_copies_across ) * 1024 )
	local y = remote_lab_y + ( math.floor( iteration / remote_lab_copies_across ) * 512 )
	return x, y
end

function at_get_entrance_location()
	local x, y = at_get_lab_location()
	x = x + entrance_x
	y = y + entrance_y
	return x, y
end

function at_remember_return_location( teleport_back_x, teleport_back_y )
	--print( "teleported from: " .. tostring(teleport_back_x) .. ", " .. tostring(teleport_back_y) )
	-- - 50
	GlobalsSetValue( "AT_TELEPORT_REMOTE_LAB_POS_X", tostring( teleport_back_x ) )
	GlobalsSetValue( "AT_TELEPORT_REMOTE_LAB_POS_Y", tostring( teleport_back_y ) )
end

function at_spawn_emergency_return( x, y )
	local portal = EntityLoad("mods/alchemy_tutor/files/entities/remote_lab/remote_lab_emergency_return.xml", x, y - 20 )
	local hole = EntityLoad( "mods/alchemy_tutor/files/entities/hall_of_masters/teleport_hole.xml", x, y - 20 )
end

function at_stop_music( x, y )
	GameTriggerMusicFadeOutAndDequeueAll( 1.0 )
end

function at_collapse_lab( x, y )
	at_cleanup_actors( x, y )

	--GamePrintImportant( "Exit" )

	EntityLoad("data/entities/misc/workshop_collapse.xml", x, y )

	GameTriggerMusicFadeOutAndDequeueAll( 2.0 )
	GamePlaySound( "data/audio/Desktop/misc.bank", "misc/temple_collapse", x, y )
end

function at_cleanup_backstage( x, y )
	local backstage = EntityGetInRadiusWithTag( x, y, 400, "at_backstage" )
	for i,v in ipairs( backstage ) do
		if EntityHasTag( v, "music_energy_000" ) then
			local audio = EntityGetFirstComponent( v, "AudioLoopComponent" )
			EntityAddComponent( v, "LifetimeComponent", 
			{
				lifetime = 180,
			} )
			EntityAddComponent( v, "LuaComponent", 
			{
				script_source_file = "mods/alchemy_tutor/files/entities/remote_lab/music_fade.lua",
				execute_every_n_frame = 10
			} )
		else
			EntityKill( v )
		end
	end
end

function at_cleanup_actors( x, y )
	local cauldrons = EntityGetInRadiusWithTag( x, y, 200, "cauldron_checker" )

	for i,v in ipairs( cauldrons ) do
		if EntityGetFirstComponent( v, "PhysicsBody2Component" ) or EntityGetFirstComponent( v, "PhysicsBodyComponent" ) then
			local mat = EntityGetFirstComponent( v, "MaterialAreaCheckerComponent" )
			if mat then
				EntityRemoveComponent( v, mat )
			end

			local dam = EntityGetFirstComponent( v, "DamageModelComponent" )
			if dam then
				EntityRemoveComponent( v, dam )
			end
		else
			EntityKill( v )
		end
	end

	local rewards = EntityGetInRadiusWithTag( x, y, 500, "at_reward" )
	for i,v in ipairs( rewards ) do
		EntityKill( v )
	end
end

function at_remote_lab_exit( x, y )
	at_cleanup_backstage( x, y )
	--at_stop_music( x, y )
end
