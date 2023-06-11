dofile_once("mods/alchemy_tutor/files/alchemy_tutor.lua")

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
	--at_master_sets()
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
