dofile_once("mods/alchemy_tutor/files/spawns.lua")
dofile_once("mods/alchemy_tutor/files/alchemy_tutor.lua")

RegisterSpawnFunction( 0xffa9d024, "spawn_return_portal" )
RegisterSpawnFunction( 0xff01DEAD, "spawn_areacheck1" )
RegisterSpawnFunction( 0xff02DEAD, "spawn_areacheck2" )
RegisterSpawnFunction( 0xffff5a0a, "spawn_music_trigger" )
RegisterSpawnFunction( 0xff03deaf, "spawn_fish" )
RegisterSpawnFunction( 0xff357320, "spawn_enter_trigger" )
RegisterSpawnFunction( 0xffd35720, "spawn_demolition" )
RegisterSpawnFunction( 0xffe4173a, "spawn_exitway" )
RegisterSpawnFunction( 0xffc128ff, "spawn_rubble" )
RegisterSpawnFunction( 0xffa7a707, "spawn_lamp_long" )
RegisterSpawnFunction( 0xff80FF5A, "spawn_vines" )


g_rubble =
{
	total_prob = 0,
	-- add skullflys after this step
	{
		prob   		= 2.0,
		min_count	= 1,
		max_count	= 1,
		entity 	= ""
	},
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1,
		entity 	= "data/entities/props/physics_temple_rubble_01.xml"
	},
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1,
		entity 	= "data/entities/props/physics_temple_rubble_02.xml"
	},
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1, 
		entity 	= "data/entities/props/physics_temple_rubble_03.xml"
	},
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1,
		entity 	= "data/entities/props/physics_temple_rubble_04.xml"
	},
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1,
		entity 	= "data/entities/props/physics_temple_rubble_05.xml"
	},
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1,
		entity 	= "data/entities/props/physics_temple_rubble_06.xml"
	},
}

g_vines =
{
	total_prob = 0,
	{
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,
		entity 	= ""
	},
	{
		prob   		= 0.4,
		min_count	= 1,
		max_count	= 1,
		entity 	= "data/entities/verlet_chains/vines/verlet_vine.xml"
	},
	{
		prob   		= 0.3,
		min_count	= 1,
		max_count	= 1,
		entity 	= "data/entities/verlet_chains/vines/verlet_vine_long.xml"
	},
	{
		prob   		= 0.2,
		min_count	= 1,
		max_count	= 1,
		entity 	= "data/entities/verlet_chains/vines/verlet_vine_short.xml"
	},
	{
		prob   		= 0.2,
		min_count	= 1,
		max_count	= 1,
		entity 	= "data/entities/verlet_chains/vines/verlet_vine_shorter.xml"
	},
}

g_lamp =
{
	total_prob = 0,
	{
		prob   		= 1.0,
		min_count	= 1,
		max_count	= 1,
		entity 	= ""
	},
	{
		prob   		= 1.0,
		min_count	= 1,
		max_count	= 1,
		entity 	= "data/entities/props/physics/temple_lantern.xml"
	},
}

function spawn_rubble(x, y)
	spawn(g_rubble,x,y,5,0)
end

function spawn_vines(x, y)
	spawn(g_vines,x+5,y+5)
end

function spawn_lamp(x, y)
	spawn(g_lamp,x,y,0,10)
end

function spawn_lamp_long(x, y)
	spawn(g_lamp,x,y,0,15)
end

function spawn_return_portal( x, y )
	local portal = EntityLoad( "mods/alchemy_tutor/files/entities/remote_lab/remote_lab_return.xml", x, y )

	local teleport_comp = EntityGetFirstComponentIncludingDisabled( portal, "TeleportComponent" )

	local teleport_back_x = 0
	local teleport_back_y = 0

	-- get the defaults from teleport_comp(s)
	if( teleport_comp ~= nil ) then
		teleport_back_x, teleport_back_y = ComponentGetValue2( teleport_comp, "target" )
		--print( "teleport std pos:" .. teleport_back_x .. ", " .. teleport_back_y )

		teleport_back_x = tonumber( GlobalsGetValue( "AT_TELEPORT_REMOTE_LAB_POS_X", teleport_back_x ) )
		teleport_back_y = tonumber( GlobalsGetValue( "AT_TELEPORT_REMOTE_LAB_POS_Y", teleport_back_y ) )

		--print( "teleport stored pos:" .. teleport_back_x .. ", " .. teleport_back_y )

		ComponentSetValue2( teleport_comp, "target", teleport_back_x, teleport_back_y )
	end
end

function spawn_enter_trigger( x, y )
	EntityLoad( "mods/alchemy_tutor/files/entities/remote_lab/remote_lab_enter.xml", x, y )

	GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/new_biome/create", x, y)
	local text = GameTextGet( "$at_remote_lab" )
	if text == '' then
		text = 'Alchemy Tutor translations are broken, please report current mod list'
	end
	GamePrintImportant( GameTextGet( "$log_entered", text ), "" )
end

function spawn_demolition( x, y )
	EntityLoad( "mods/alchemy_tutor/files/entities/remote_lab/remote_lab_demolition.xml", x, y )
end

function spawn_exitway( x, y )
	EntityLoad( "mods/alchemy_tutor/files/entities/remote_lab/remote_lab_exitway.xml", x, y )
end

function spawn_areacheck( x, y, id, radius )
	GlobalsSetValue( "AT_REMOTE_LAB_PLAYERS_" .. id, "7" )

	local entity_id = EntityLoad( "mods/alchemy_tutor/files/entities/remote_lab/remote_lab_exit.xml", x, y )

	local var = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )

	if ( var ~= nil ) then
		ComponentSetValue2( var, "value_string", id )
	end

	local range = EntityGetFirstComponentIncludingDisabled( entity_id, "ParticleEmitterComponent" )

	if ( range ~= nil ) then
		ComponentSetValue2( range, "area_circle_radius", radius, radius )
	end
end

function spawn_areacheck1( x, y )
	spawn_areacheck( x, y, '1', 175 )
end

function spawn_areacheck2( x, y )
	spawn_areacheck( x, y, '2', 250 )
end

function spawn_music_trigger( x, y )
	GameTriggerMusicFadeOutAndDequeueAll( 3.0 )
end

function spawn_fish(x, y)
	local f = tonumber( GlobalsGetValue( "at_passed_count", 0 ) )

	for i=1,f do
		local id = EntityLoad( "data/entities/animals/fish.xml", x, y )
	end
end

function spawn_unique_enemy2()
end

function spawn_shopitem( x, y )
end
