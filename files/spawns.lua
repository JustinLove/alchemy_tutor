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
RegisterSpawnFunction( 0xfff12e00, "at_spawn_cauldron_fire")
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
RegisterSpawnFunction( 0xff0c79c1, "at_spawn_output_1")
RegisterSpawnFunction( 0xff0c79c2, "at_spawn_output_2")
RegisterSpawnFunction( 0xffe411e9, "at_spawn_eye")
RegisterSpawnFunction( 0xffb18b13, "at_spawn_big_bin_3")
RegisterSpawnFunction( 0xffb18b14, "at_spawn_big_bin_4")
RegisterSpawnFunction( 0xff3edb13, "at_spawn_med_bin_3")
RegisterSpawnFunction( 0xff3edb14, "at_spawn_med_bin_4")
RegisterSpawnFunction( 0xff3edb15, "at_spawn_med_bin_5")
RegisterSpawnFunction( 0xff3edb16, "at_spawn_med_bin_6")
RegisterSpawnFunction( 0xffe27e21, "at_spawn_enter_entrance")
RegisterSpawnFunction( 0xffe27e22, "at_spawn_enter_top")
RegisterSpawnFunction( 0xffe27e23, "at_spawn_enter_bottom")
RegisterSpawnFunction( 0xff3251c0, "at_spawn_music")
RegisterSpawnFunction( 0xffacce55, "at_spawn_records_access")
RegisterSpawnFunction( 0xffacce5e, "at_spawn_east_access")
RegisterSpawnFunction( 0xffacce53, "at_spawn_west_access")
RegisterSpawnFunction( 0xff840271, "at_spawn_ghost_crystal_lab" )
RegisterSpawnFunction( 0xff118475, "at_spawn_lamp" )
RegisterSpawnFunction( 0xffba2e15, "at_spawn_props" )

local at_base_init = _G.init

if not at_base_init then
	RegisterSpawnFunction( 0xffffeedd, "init" )
end

function init( x, y, w, h )
	if at_base_init then
		at_base_init( x, y, w, h )
	end

	local ng_level = tonumber( SessionNumbersGetValue("NEW_GAME_PLUS_COUNT") ) or 0
	if not at_biome_map or (ng_level > 0 and at_biome_map_ng_level == 0) then
		virtual_biome_init()
	end

	local _,mx = at_check_parallel_pos( x )
	local bx = mx / 512
	local by = y / 512
	if at_biome_map[bx] and at_biome_map[bx][by] then
		at_biome_map[bx][by]( x, y )
	end
end

at_lab_chance = ModSettingGet("alchemy_tutor.lab_chance")
if at_lab_chance == nil then
	at_lab_chance = 1
end
--at_lab_chance = 9999999
local chancef = math.min(at_lab_chance / 10, 0.95)
at_lab_chance_factor = chancef / (1 - chancef)

function at_add_biome_pixel_scene(pixel_scene_name, vanilla_weight, scene)
	if not _G[pixel_scene_name] then
		print('pixel scenes not found to modify', pixel_scene_name)
		return
	end
	local pixel_scenes = _G[pixel_scene_name]
	--at_total_prob(pixel_scenes, pixel_scene_name)
	scene.prob = vanilla_weight * at_lab_chance_factor
	scene.is_unique = 0
	table.insert(pixel_scenes, scene)
end

function at_total_prob(tab, label)
	local sum = 0
	for _,scene in ipairs(tab) do
		sum = sum + scene.prob
	end
	print(label, sum)
end

local at_scene_cauldron = nil
local at_materials = {}
local at_cauldrons = {}
local at_other = {}
local at_reward = {}

local at_block = {
	{
		reward = {}
	},
	{
		reward = {}
	},
	{
		large_bins = {},
		medium_bins = {},
	},
	{
		large_bins = {},
		medium_bins = {},
	},
	{
		medium_bins = {},
	},
	{
		medium_bins = {},
	},
}

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
		c = at_block[n].medium_bins or {},
		l = at_block[n].large_bins or {},
		o = at_other,
		r = at_block[n].reward or {},
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
	at_other = {}
	at_reward = {}
	at_block[n].large_bins = {}
	at_block[n].medium_bins = {}
	at_block[n].reward = {}
end

function at_spawn_output_1( x, y )
	table.insert( at_block[1].reward, {x = x, y = y} )
end

function at_spawn_output_2( x, y )
	table.insert( at_block[2].reward, {x = x, y = y} )
end

function at_spawn_eye( x, y )
	if not ModSettingGet("alchemy_tutor.no_freebies") then
		EntityLoad( "data/entities/items/pickup/evil_eye.xml", x, y )
	end
end

function at_spawn_enter_entrance( x, y )
	EntityLoad( "mods/alchemy_tutor/files/entities/hall_of_masters/hall_of_masters_enter_entrance.xml", x, y )
end

function at_spawn_enter_top( x, y )
	EntityLoad( "mods/alchemy_tutor/files/entities/hall_of_masters/hall_of_masters_enter_top.xml", x, y )
end

function at_spawn_enter_bottom( x, y )
	EntityLoad( "mods/alchemy_tutor/files/entities/hall_of_masters/hall_of_masters_enter_bottom.xml", x, y )
end

function at_spawn_music( x, y )
	EntityLoad( "mods/alchemy_tutor/files/entities/hall_of_masters/hall_of_masters_music.xml", x, y )
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

function at_spawn_records_access( x, y )
	local pw,_ = at_check_parallel_pos( x )
	-- not currently putting records in parallel worlds
	local lab_x, lab_y = at_lab_origin( x, y, 0, 0 )
	local loc = at_get_lab( lab_x, lab_y )
	if pw == 0 and loc and loc.west_access == 'records_access' then
		LoadPixelScene(
			"mods/alchemy_tutor/files/biome_impl/hall_of_masters/hall_of_masters_records_access.png",
			"", -- visual
			x, y,
			"mods/alchemy_tutor/files/biome_impl/hall_of_masters/hall_of_masters_records_access_background.png",
			true, -- skip_biome_checks
			false, -- skip_edge_textures
			{
			}, -- color_to_matieral_table
			49 -- z index
		)
	end
end

function at_spawn_east_access( x, y )
	local lab_x, lab_y = at_lab_origin( x, y, 1, 0 )
	local loc = at_get_lab( lab_x, lab_y )
	if loc and loc.east_access == 'east_access' then
		LoadPixelScene(
			"mods/alchemy_tutor/files/biome_impl/hall_of_masters/hall_of_masters_east_access.png",
			"", -- visual
			x, y-23,
			"mods/alchemy_tutor/files/biome_impl/hall_of_masters/hall_of_masters_east_access_background.png",
			true, -- skip_biome_checks
			false, -- skip_edge_textures
			{
			}, -- color_to_matieral_table
			49 -- z index
		)
	end
	if loc and loc.east_access == 'sky_access' then
		LoadPixelScene(
			"mods/alchemy_tutor/files/biome_impl/hall_of_masters/hall_of_masters_sky_access.png",
			"", -- visual
			x, y-23,
			"mods/alchemy_tutor/files/biome_impl/hall_of_masters/hall_of_masters_sky_access_background.png",
			true, -- skip_biome_checks
			false, -- skip_edge_textures
			{
			}, -- color_to_matieral_table
			49 -- z index
		)
	end
end

function at_spawn_west_access( x, y )
	local lab_x, lab_y = at_lab_origin( x, y, 0, 0 )
	local loc = at_get_lab( lab_x, lab_y )
	if loc and loc.west_access == 'west_access' then
		LoadPixelScene(
			"mods/alchemy_tutor/files/biome_impl/hall_of_masters/hall_of_masters_west_access.png",
			"", -- visual
			x - 480, y - 200,
			"mods/alchemy_tutor/files/biome_impl/hall_of_masters/hall_of_masters_west_access_background.png",
			true, -- skip_biome_checks
			false, -- skip_edge_textures
			{
			}, -- color_to_matieral_table
			49 -- z index
		)
	end
end

function at_spawn_ghost_crystal_lab( x, y )
	local lab_x, lab_y = at_lab_origin( x, y, 0, 1 )
	local loc = at_get_lab( lab_x, lab_y )
	if loc and loc.west_alcove == 'ghost_deflector_crystal' then
		EntityLoad( "mods/alchemy_tutor/files/entities/hall_of_records/ghost_deflector_crystal.xml", x, y + 2 )
		at_ghost_deflector_base( x, y + 5 )
	end
end

function at_spawn_lamp( x, y )
	EntityLoad( "mods/alchemy_tutor/files/entities/hall_of_masters/lamp.xml", x, y + 2 )
end

at_barrels =
{
	total_prob = 0,
	{
		prob   		= 0.2,
		min_count	= 0,
		max_count	= 0,
		offset_y 	= 0,    
		entity 	= ""
	},
	{
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/physics_box_harmless.xml"
	},
	{
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/physics_barrel_water.xml"
	},
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1,
		offset_y 	= 0,    
		entity 	= "data/entities/props/physics_barrel_radioactive.xml"
	},
	{
		prob   		= 0.3,
		min_count	= 1,
		max_count	= 1,
		offset_y 	= 0,    
		entity 	= "data/entities/props/physics_barrel_oil.xml"
	},
}

function at_spawn_props(x, y)
	spawn(at_barrels,x,y-3,0,0)
end

function at_spawn_material( x, y )
	at_log( 'material pixel', x, y )
	table.insert( at_materials, {x = x, y = y} )
end

function at_spawn_cauldron( x, y )
	at_log( 'cauldron pixel', x, y )
	table.insert( at_cauldrons, {x = x, y = y} )
end

function at_spawn_cauldron_fire( x, y )
	EntityLoad( "mods/alchemy_tutor/files/entities/cauldron_fire.xml", x, y )
end

function at_spawn_big_bin_3( x, y )
	table.insert( at_block[3].large_bins, {x = x, y = y} )
end

function at_spawn_big_bin_4( x, y )
	table.insert( at_block[4].large_bins, {x = x, y = y} )
end

function at_spawn_med_bin_3( x, y )
	table.insert( at_block[3].medium_bins, {x = x, y = y} )
end

function at_spawn_med_bin_4( x, y )
	table.insert( at_block[4].medium_bins, {x = x, y = y} )
end

function at_spawn_med_bin_5( x, y )
	table.insert( at_block[5].medium_bins, {x = x, y = y} )
end

function at_spawn_med_bin_6( x, y )
	table.insert( at_block[6].medium_bins, {x = x, y = y} )
end

function at_spawn_other( x, y )
	table.insert( at_other, {x = x, y = y} )
end

function at_spawn_reward( x, y )
	at_log( 'reward pixel', x, y )
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
