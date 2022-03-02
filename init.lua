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

local first_run = true

function OnPlayerSpawned( player_entity ) -- This runs when player entity has been created
	if not first_run then
		return
	end
	if _G['at_test_player'] or _G['at_test_clear'] then
		clear_entities( player_entity )
	end
	if _G['at_test_healing'] then
		damage_player( player_entity )
	end
	if _G['at_test_player'] then
		EntitySetTransform( player_entity, at_test_x, at_test_y )
	end
	if _G['at_test_lab'] then
		hesitate( player_entity )
	  EntityLoad( "mods/alchemy_tutor/files/entities/spawn_lab.xml", at_test_x, at_test_y )
	end
	if _G['at_test_portal'] then
		local x,y = EntityGetTransform(player_entity)
		EntityLoad( "mods/alchemy_tutor/files/entities/remote_lab_chest.xml", x + 20, y )
	end
	first_run = false;
end


function OnWorldInitialized() -- This is called once the game world is initialized. Doesn't ensure any world chunks actually exist. Use OnPlayerSpawned to ensure the chunks around player have been loaded or created.

	if _G['at_test_lab'] or _G['at_test_portal'] then
		local world = GameGetWorldStateEntity()
		local world_state = EntityGetFirstComponent( world, "WorldStateComponent" )
		ComponentSetValue( world_state, "time", 0 )
	end
end

-- This code runs when all mods' filesystems are registered

ModMaterialsFileAdd("mods/alchemy_tutor/files/materials.xml")

ModLuaFileAppend( "data/scripts/newgame_plus.lua", "mods/alchemy_tutor/files/newgame_plus.lua" )

ModLuaFileAppend( "data/scripts/biomes/coalmine.lua", "mods/alchemy_tutor/files/biomes/coalmine.lua" )
ModLuaFileAppend( "data/scripts/biomes/coalmine_alt.lua", "mods/alchemy_tutor/files/biomes/coalmine_alt.lua" )
ModLuaFileAppend( "data/scripts/biomes/excavationsite.lua", "mods/alchemy_tutor/files/biomes/excavationsite.lua" )
ModLuaFileAppend( "data/scripts/biomes/snowcave.lua", "mods/alchemy_tutor/files/biomes/snowcave.lua" )
ModLuaFileAppend( "data/scripts/biomes/snowcastle.lua", "mods/alchemy_tutor/files/biomes/snowcastle.lua" )
ModLuaFileAppend( "data/scripts/biomes/vault.lua", "mods/alchemy_tutor/files/biomes/vault.lua" )
ModLuaFileAppend( "data/scripts/biomes/rainforest.lua", "mods/alchemy_tutor/files/biomes/rainforest.lua" )
ModLuaFileAppend( "data/scripts/biomes/rainforest_dark.lua", "mods/alchemy_tutor/files/biomes/rainforest_dark.lua" )
ModLuaFileAppend( "data/scripts/biomes/crypt.lua", "mods/alchemy_tutor/files/biomes/crypt.lua" )
ModLuaFileAppend( "data/scripts/biomes/pyramid.lua", "mods/alchemy_tutor/files/biomes/crypt.lua" )

-- liquidcave doesn't seem to have heart/chest spawns
ModLuaFileAppend( "data/scripts/biomes/liquidcave.lua", "mods/alchemy_tutor/files/biomes/liquidcave.lua" )

ModLuaFileAppend( "data/scripts/biomes/mountain/mountain_left.lua", "mods/alchemy_tutor/files/spawns.lua" )
ModLuaFileAppend( "data/scripts/biomes/mountain/mountain_left_entrance.lua", "mods/alchemy_tutor/files/spawns.lua" )
ModLuaFileAppend( "data/scripts/biomes/mountain/mountain_left_stub.lua", "mods/alchemy_tutor/files/spawns.lua" )
ModLuaFileAppend( "data/scripts/biomes/hills.lua", "mods/alchemy_tutor/files/biomes/hills_remote_lab.lua" )

ModLuaFileAppend( "data/scripts/biome_scripts.lua", "mods/alchemy_tutor/files/biome_scripts.lua" )

if ModIsEnabled( 'alchemical_reactions_expansion' ) then
	ModLuaFileAppend( "mods/alchemy_tutor/files/props.lua", "mods/alchemy_tutor/files/alchemical_reactions_expansion/props.lua" )
	ModLuaFileAppend( "mods/alchemy_tutor/files/formula_list.lua", "mods/alchemy_tutor/files/alchemical_reactions_expansion/formula_list.lua" )
end
