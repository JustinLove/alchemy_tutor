--at_test_player = true
--at_test_lab = true
--at_test_clear = true
--at_test_healing = true
--at_test_portal = true
--at_test_masters = true
--at_test_master_success = true
at_test_x = -200
at_test_x = 200
--at_test_y = -100 -- hills
--at_test_y = 2000 -- excavation
--at_test_y = 3500 -- snowcave
--at_test_y = 5500 -- snowcastle
--at_test_y = 7000 -- rainforest
--at_test_y = 9000 -- vault
--at_test_y = 11000 -- crypt
--at_test_x = 10000 -- pyramid
--at_test_y = 0 -- pyramid
--at_test_x = -4000 -- rainforest dark
--at_test_y = 7500 -- rainforest dark
--at_test_x = 12300 -- fungiforest
--at_test_y = 2000 -- fungiforest
--at_test_x = -5317 -- hall of records
--at_test_y = 720 -- hall of records
--at_test_x = -5000 -- hall of records entrance
--at_test_y = 700 -- hall of records entrace
--at_test_x = -5640 -- hall of records ghost
--at_test_y = 1024 -- hall of records ghost
--at_test_x = -5433 -- hall of masters ghost
--at_test_y = 1900 -- hall of masters ghost
--at_test_x = 14334 --+ 35840 -- hall of masters ne gold
--at_test_y = -3880 -- hall of masters ne gold east
--at_test_x = -14848 -- hall of masters sw gold
--at_test_y = 16078 -- hall of masters sw gold
--at_test_x = -1536 -- hall of masters above tree
--at_test_y = -4395 -- hall of masters above tree
--at_test_x = 5117 -- hall of masters west desert chasm
--at_test_y = 6003 -- hall of masters west desert chasm
--at_test_x = 15852 -- hall of masters se corner
--at_test_y = 14406 -- hall of masters se corner
--at_test_x = -15872 -- hall of masters lake
--at_test_y = 4309 -- hall of masters lake
--at_test_x = 16151 -- noitvania upper right
--at_test_y = -4629 -- noitvania upper right

local function clear_entities( player_entity )
	EntityAddComponent( player_entity, "LuaComponent", 
	{
		script_source_file = "mods/alchemy_tutor/files/entities/clear_entities.lua",
		execute_every_n_frame = "20",
	} )
	EntityAddComponent2( player_entity, "UIIconComponent",
	{
		name = "$action_destruction",
		description = "remove enemies",
		icon_sprite_file = "data/ui_gfx/gun_actions/destruction.png",
		display_above_head = false,
		display_in_hud = true,
		is_perk = true,
	})
end

local function damage_player( player_entity )
	local damagemodels = EntityGetComponent( player_entity, "DamageModelComponent" )

	if( damagemodels ~= nil ) then
		for _,damagemodel in ipairs(damagemodels) do
			local hp = ComponentGetValue2( damagemodel, "hp" )

			hp = math.max( 0.04, hp - math.max( hp * 0.1, 0.8 ) )

			ComponentSetValue2( damagemodel, "hp", hp )
		end
	end
end

local function hesitate( player_entity )
	local x,y = EntityGetTransform(player_entity)
	local models = EntityGetComponent( player_entity, "CharacterPlatformingComponent" )
	if( models ~= nil ) then
		for i,model in ipairs(models) do
			ComponentSetValue( model, "pixel_gravity", 0 )
		end
	end
	local effect = EntityCreateNew()
	EntityAddComponent( effect, "GameEffectComponent", 
	{
		custom_effect_id = "hesitation",
		disable_movement = 1,
		frames = "60",
	} )
	EntityAddComponent( effect, "LuaComponent", 
	{
		script_source_file = "mods/alchemy_tutor/files/entities/reset_gravity.lua",
		execute_every_n_frame = -1,
		execute_on_removed = 1,
	} )
	EntityAddChild( player_entity, effect )
end

function at_test_player_spawned( player_entity )
	--dofile_once("mods/alchemy_tutor/files/alchemy_tutor.lua")
	--SetRandomSeed(1,2)
	--at_master_sets(1)
	--at_setup_raw_materials()
	if _G['at_test_player'] or _G['at_test_clear'] then
		clear_entities( player_entity )
	end
	if _G['at_test_healing'] then
		damage_player( player_entity )
	end
	if _G['at_test_player'] then
		print('set player pos')
		EntitySetTransform( player_entity, at_test_x, at_test_y )
	end
	if _G['at_test_lab'] then
		hesitate( player_entity )
	  EntityLoad( "mods/alchemy_tutor/files/entities/spawn_lab.xml", at_test_x, at_test_y )
	end
	if _G['at_test_portal'] then
		local x,y = EntityGetTransform(player_entity)
		EntityLoad( "mods/alchemy_tutor/files/entities/remote_lab_chest.xml", x + 20, y )
		EntityLoad( "data/entities/animals/boss_alchemist/key.xml", x - 20, y )
	end
	if _G['at_test_masters'] then
		local x,y = EntityGetTransform(player_entity)
		EntityLoad( "mods/alchemy_tutor/files/entities/hall_of_masters_chest.xml", x + 20, y )
		EntityLoad( "mods/alchemy_tutor/files/entities/hall_of_masters_chest.xml", x + 60, y )
		EntityLoad( "mods/alchemy_tutor/files/entities/hall_of_masters_chest.xml", x + 100, y )
		EntityLoad( "mods/alchemy_tutor/files/entities/hall_of_masters_chest.xml", x + 140, y )
		EntityLoad( "mods/alchemy_tutor/files/entities/hall_of_masters_chest.xml", x - 20, y )
		EntityLoad( "mods/alchemy_tutor/files/entities/hall_of_masters_chest.xml", x - 60, y )
		EntityLoad( "mods/alchemy_tutor/files/entities/hall_of_masters_chest.xml", x - 100, y )
		EntityLoad( "mods/alchemy_tutor/files/entities/hall_of_masters_chest.xml", x - 140, y )
	end
	if _G['at_test_master_success'] then
		dofile_once("mods/alchemy_tutor/files/alchemy_tutor.lua")
		local x = 420
		local y = -105
		for i = 1,6 do
			at_master_test_success_check( x + i*70, y, {
				target = 'copper',
				reward = 'power',
				lab_id = 'TEST',
				level = i,
			})
		end
	end
end

function at_test_world_initialized()
	if _G['at_test_lab'] or _G['at_test_portal'] or _G['at_test_masters'] then
		local world = GameGetWorldStateEntity()
		local world_state = EntityGetFirstComponent( world, "WorldStateComponent" )
		ComponentSetValue( world_state, "time", 0 )
	end
end

function at_test_lab_spawns()
	if _G['at_test_lab'] then
		ModLuaFileAppend( "data/scripts/biomes/mountain/mountain_left.lua", "mods/alchemy_tutor/files/spawns.lua" )
		ModLuaFileAppend( "data/scripts/biomes/mountain/mountain_left_entrance.lua", "mods/alchemy_tutor/files/spawns.lua" )
		ModLuaFileAppend( "data/scripts/biomes/mountain/mountain_left_stub.lua", "mods/alchemy_tutor/files/spawns.lua" )
	end
end
