if at_remove_remote_lab_key then
	at_remove_remote_lab_key()
end

dofile_once("mods/alchemy_tutor/files/alchemy_tutor.lua")
dofile_once("mods/alchemy_tutor/files/smallfolk.lua")

RegisterSpawnFunction( 0xfff1a545, "at_spawn_material")
RegisterSpawnFunction( 0xff528003, "at_spawn_shroom")
RegisterSpawnFunction( 0xff591de8, "at_spawn_meat")
RegisterSpawnFunction( 0xff00f809, "at_spawn_frog")
RegisterSpawnFunction( 0xff05702e, "at_spawn_rock")
RegisterSpawnFunction( 0xffe3974c, "at_spawn_empty")
RegisterSpawnFunction( 0xff012e85, "at_spawn_other")
RegisterSpawnFunction( 0xffca1d80, "at_spawn_cauldron")
RegisterSpawnFunction( 0xff2e3a2d, "at_spawn_reward")
RegisterSpawnFunction( 0xff057ee1, "at_spawn_steel_pit")
RegisterSpawnFunction( 0xff0691c4, "at_spawn_brick_pit")
RegisterSpawnFunction( 0xff5ce4e5, "at_spawn_scene")
RegisterSpawnFunction( 0xff91a4e2, "at_look_here")

RegisterSpawnFunction( 0xff3a57e1, "at_spawn_master_1")
RegisterSpawnFunction( 0xff3a57e2, "at_spawn_master_2")
RegisterSpawnFunction( 0xff3a57e3, "at_spawn_master_3")
RegisterSpawnFunction( 0xff3a57e4, "at_spawn_master_4")
RegisterSpawnFunction( 0xff3a57e5, "at_spawn_master_5")
RegisterSpawnFunction( 0xff3a57e6, "at_spawn_master_6")
RegisterSpawnFunction( 0xff0c79c7, "at_spawn_output")
RegisterSpawnFunction( 0xffe411e9, "at_spawn_eye")
RegisterSpawnFunction( 0xffb18b12, "at_spawn_big_bin")
RegisterSpawnFunction( 0xff3edb12, "at_spawn_med_bin")

at_lab_chance = ModSettingGet("alchemy_tutor.lab_chance")
if at_lab_chance == nil then
	at_lab_chance = 1
end
--at_lab_chance = 9999999

local at_scene_cauldron = nil
local at_materials = {}
local at_cauldrons = {}
local at_large_bins = {}
local at_other = {}
local at_reward = {}

function at_spawn_scene( x, y )
	local cauldron = at_scene_cauldron or at_default_cauldron
	local text = smallfolk.dumps({
		sc = cauldron and cauldron.name,
		sb = at_biome_banned_materials,
		m = at_materials,
		c = at_cauldrons,
		o = at_other,
		r = at_reward,
	})

	local dc = EntityLoad( "mods/alchemy_tutor/files/entities/decorate_scene.xml", x, y )
	if dc then
		at_log( 'scene pixel', tostring(dc), x, y )
		local var = EntityGetFirstComponent( dc, "VariableStorageComponent" )
		if var then
			ComponentSetValue2( var, "value_string", text )
		end
	end

	at_scene_cauldron = nil
	at_materials = {}
	at_cauldrons = {}
	at_large_bins = {}
	at_other = {}
	at_reward = {}
end

function at_spawn_master_1( x, y )
	at_spawn_master_n( 1, x, y )
end

function at_spawn_master_2( x, y )
	at_spawn_master_n( 2, x, y )
end

function at_spawn_master_3( x, y )
	at_spawn_master_n( 3, x, y )
end

function at_spawn_master_4( x, y )
	at_spawn_master_n( 4, x, y )
end

function at_spawn_master_5( x, y )
	at_spawn_master_n( 5, x, y )
end

function at_spawn_master_6( x, y )
	at_spawn_master_n( 6, x, y )
end

function at_spawn_master_n( n, x, y )
	local cauldron = at_scene_cauldron or at_default_cauldron
	local text = smallfolk.dumps({
		sc = cauldron and cauldron.name,
		sb = at_biome_banned_materials,
		m = at_materials,
		c = at_cauldrons,
		l = at_large_bins,
		o = at_other,
		r = at_reward,
		n = n,
	})

	local dc = EntityLoad( "mods/alchemy_tutor/files/entities/decorate_scene.xml", x, y )
	if dc then
		at_log( 'master pixel', tostring(dc), x, y )
		local lua = EntityGetFirstComponent( dc, "LuaComponent" )
		if lua then
			ComponentSetValue2( lua, "script_source_file", "mods/alchemy_tutor/files/entities/decorate_hall_of_masters.lua" )
		end
		local var = EntityGetFirstComponent( dc, "VariableStorageComponent" )
		if var then
			ComponentSetValue2( var, "value_string", text )
		end
	end

	at_scene_cauldron = nil
	at_materials = {}
	at_cauldrons = {}
	at_large_bins = {}
	at_other = {}
	at_reward = {}
end

function at_spawn_output( x, y )
	table.insert( at_reward, {x = x, y = y} )
end

function at_spawn_eye( x, y )
	EntityLoad( "data/entities/items/pickup/evil_eye.xml", x, y )
end

function at_look_here( x, y )
	local cx, cy = GameGetCameraPos()
	local player_entity = EntityGetClosestWithTag( cx, cy, "player_unit")
	if( player_entity ~= 0 ) then
		EntitySetTransform( player_entity, x, y )
	else
		GameSetCameraPos( x, y )
	end
end

function at_spawn_material( x, y )
	table.insert( at_materials, {x = x, y = y} )
end

function at_spawn_cauldron( x, y )
	table.insert( at_cauldrons, {x = x, y = y} )
end

function at_spawn_big_bin( x, y )
	table.insert( at_large_bins, {x = x, y = y} )
end

function at_spawn_med_bin( x, y )
	table.insert( at_cauldrons, {x = x, y = y} )
end

function at_spawn_other( x, y )
	table.insert( at_other, {x = x, y = y} )
end

function at_spawn_reward( x, y )
	local id = EntityLoad( "mods/alchemy_tutor/files/entities/reward_marker.xml", x + 1, y - 6 )
	table.insert( at_reward, {x = x, y = y} )
end

function at_spawn_steel_pit( x, y )
	at_scene_cauldron = at_steel_pit
end

function at_spawn_brick_pit( x, y )
	at_scene_cauldron = at_brick_pit
end

local at_shrooms = {}

function at_spawn_shroom( x, y )
	if #at_shrooms < 1 then
		SetRandomSeed( x, y )
		at_shrooms = {1, 2, 3, 4, 5}
		shuffleTable( at_shrooms )
	end
	local shroom = table.remove( at_shrooms )
	at_mushroom( shroom, x, y )
end

local at_frogs = {}

function at_spawn_frog( x, y )
	if #at_frogs < 1 then
		SetRandomSeed( x, y )
		at_frogs = {
			"data/entities/animals/frog.xml",
			"data/entities/animals/frog.xml",
			"data/entities/animals/frog.xml",
			"data/entities/animals/frog_big.xml",
		}
		shuffleTable( at_frogs )
	end
	local frog = table.remove( at_frogs )
	EntityLoad( frog, x, y )
end

function at_spawn_meat( x, y )
	EntityLoad( "data/entities/animals/wolf.xml", x, y )
end

function at_spawn_rock(x, y)
	spawn(at_rock,x,y)
end

function at_spawn_empty(x, y)
	SetRandomSeed( x, y )
	if Random(1,100) < 50 then
		at_powder_empty(x, y)
	else
		at_potion_empty(x, y)
	end
end

at_rock =
{
	total_prob = 0,
	{
		prob   		= 0.2,
		min_count	= 1,
		max_count	= 1, 
		entity 	= "data/entities/props/physics_stone_02.xml",
	},
	{
		prob   		= 0.2,
		min_count	= 1,
		max_count	= 1, 
		entity 	= "data/entities/props/physics_stone_03.xml",
	},
}

function at_preclear_for_mini( x, y, radius )
	local entities = EntityGetInRadius( x, y, radius )
	PhysicsRemoveJoints( x - 70, y - 70, x + 70, y + 20 )
	for i = 1,#entities do
		local id = entities[i]
		--print( id, tostring( EntityGetParent( id ) ), EntityGetFilename( id ), EntityGetTags( id ) )
		if EntityGetParent( id ) ~= 0 then
		elseif EntityHasTag( id, "prop" ) or EntityHasTag( id, "enemy" ) or EntityHasTag( id, "homing_target" ) then
			EntityKill( id )
		end
	end
end
