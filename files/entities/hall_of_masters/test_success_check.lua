dofile_once('mods/alchemy_tutor/files/alchemy_tutor.lua')
dofile_once("data/scripts/director_helpers.lua")
dofile_once( "data/scripts/gun/gun_actions.lua" )

local wands =
{
	{ -- 1
		total_prob = 0,
		-- this is air, so nothing spawns at 0.6
		{
			prob   		= 0,
			min_count	= 0,
			max_count	= 0,
			entity 	= ""
		},
		-- add skullflys after this step
		{
			prob   		= 4,
			min_count	= 1,
			max_count	= 1,
			entity 	= "data/entities/items/wand_level_03.xml"
		},
		{
			prob   		= 4,
			min_count	= 1,
			max_count	= 1,
			entity 	= "data/entities/items/wand_level_03_better.xml"
		},
		{
			prob   		= 3,
			min_count	= 1,
			max_count	= 1,
			entity 	= "data/entities/items/wand_unshuffle_02.xml"
		},
		{
			prob   		= 2,
			min_count	= 1,
			max_count	= 1,
			entity 	= "data/entities/items/wand_unshuffle_03.xml"
		},
	},
	{ -- 2
		total_prob = 0,
		-- this is air, so nothing spawns at 0.6
		{
			prob   		= 0,
			min_count	= 0,
			max_count	= 0,
			entity 	= ""
		},
		-- add skullflys after this step
		{
			prob   		= 3,
			min_count	= 1,
			max_count	= 1,
			entity 	= "data/entities/items/wand_level_04.xml"
		},
		{
			prob   		= 3,
			min_count	= 1,
			max_count	= 1,
			entity 	= "data/entities/items/wand_level_04_better.xml"
		},
		{
			prob   		= 3,
			min_count	= 1,
			max_count	= 1,
			entity 	= "data/entities/items/wand_unshuffle_03.xml"
		},
		{
			prob   		= 2,
			min_count	= 1,
			max_count	= 1,
			entity 	= "data/entities/items/wand_unshuffle_04.xml"
		},
	},
	{ -- 3
		total_prob = 0,
		-- this is air, so nothing spawns at 0.6
		{
			prob   		= 0,
			min_count	= 0,
			max_count	= 0,
			entity 	= ""
		},
		-- add skullflys after this step
		{
			prob   		= 2,
			min_count	= 1,
			max_count	= 1,
			entity 	= "data/entities/items/wand_level_05.xml"
		},
		{
			prob   		= 2,
			min_count	= 1,
			max_count	= 1,
			entity 	= "data/entities/items/wand_level_05_better.xml"
		},
		{
			prob   		= 3,
			min_count	= 1,
			max_count	= 1,
			entity 	= "data/entities/items/wand_unshuffle_04.xml"
		},
		{
			prob   		= 2,
			min_count	= 1,
			max_count	= 1,
			entity 	= "data/entities/items/wand_unshuffle_05.xml"
		},
	},
	{ -- 4
		total_prob = 0,
		-- this is air, so nothing spawns at 0.6
		{
			prob   		= 0,
			min_count	= 0,
			max_count	= 0,
			entity 	= ""
		},
		-- add skullflys after this step
		{
			prob   		= 1,
			min_count	= 1,
			max_count	= 1,
			entity 	= "data/entities/items/wand_level_06.xml"
		},
		{
			prob   		= 1,
			min_count	= 1,
			max_count	= 1,
			entity 	= "data/entities/items/wand_level_06_better.xml"
		},
		{
			prob   		= 3,
			min_count	= 1,
			max_count	= 1,
			entity 	= "data/entities/items/wand_unshuffle_05.xml"
		},
		{
			prob   		= 2,
			min_count	= 1,
			max_count	= 1,
			entity 	= "data/entities/items/wand_unshuffle_06.xml"
		},
	},
}

local function make_random_card( x, y, level )
	-- this does NOT call SetRandomSeed() on purpouse.
	-- SetRandomSeed( x, y )

	local item = ""
	local valid = false

	while ( valid == false ) do
		local itemno = Random( 1, #actions )
		local thisitem = actions[itemno]
		item = string.lower(thisitem.id)

		if ( thisitem.spawn_requires_flag ~= nil ) then
			local flag_name = thisitem.spawn_requires_flag
			local flag_status = HasFlagPersistent( flag_name )

			if flag_status then
				valid = true
			end

			-- 
			if( thisitem.spawn_probability == "0" ) then 
				valid = false
			end

		else
			valid = true
		end
	end

	if ( string.len(item) > 0 ) then
		local card_entity = CreateItemActionEntity( item, x, y )
		return card_entity
	else
		print( "No valid action entity found!" )
	end
end

local function spawn_success( x, y )
	EntityLoad( "mods/alchemy_tutor/files/entities/hall_of_masters/success_effect.xml", x, y )
	EntityLoad("data/entities/particles/image_emitters/magical_symbol.xml", x, y)
	GamePlaySound( "data/audio/Desktop/projectiles.snd", "player_projectiles/crumbling_earth/create", x, y)
end

local function spawn_great_chest( x, y, level )
	local chests = level
	while chests > 0 do
		if chests >= 2 then
			EntityLoad( "data/entities/items/pickup/chest_random_super.xml", x + chests, y)
			chests = chests - 2
		elseif chests >= 1 then
			EntityLoad( "data/entities/items/pickup/chest_random.xml", x + chests, y)
			chests = chests - 1
		end
	end
	spawn_success( x, y )
	GamePrintImportant( "$at_log_reward_treasure" )
end

local function spawn_grand_material( x, y, level )
	if #at_grand_materials < 1 then
		at_setup_grand_alchemy()
	end
	SetRandomSeed( x, y )
	local r = Random(1, #at_grand_materials)
	at_container( at_grand_materials[r], 0.05 * level, x, y )
	spawn_success( x, y )
	GamePrintImportant( "$at_log_reward_knowledge" )
end

local function spawn_gold( x, y )
	EntityLoad( "mods/alchemy_tutor/files/entities/hall_of_masters/wealth.xml", x, y )
	EntityLoad("data/entities/particles/image_emitters/chest_effect_bad.xml", x, y)
	GamePrintImportant( "$at_log_reward_wealth" )
end

local function spawn_wand( x, y, level )
	spawn( wands[level], x - 5, y - 5, 0, 0 )
	spawn_success( x, y )
	GamePrintImportant( "$at_log_reward_power" )
end

local function spawn_spells( x, y, level )
	SetRandomSeed( x, y )
	local amount = level * 3
	for i=1,amount do
		make_random_card( x + (i - (amount / 2)) * 8, y - 9 + Random(-10,10) )
	end
	spawn_success( x, y )
	GamePrintImportant( "$at_log_reward_magic" )
end

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

local target = ""
local reward = ""
local lab_id = ""
local level = 2
local targetid = 0
local goldid = 0
local vars = EntityGetComponent( entity_id, "VariableStorageComponent" )
if vars then
	for i = 1,#vars do
		var = vars[i]
		local name = ComponentGetValue2( var, "name" )
		if ( name == "target" ) then
			target = ComponentGetValue2( var, "value_string" )
			--print( tostring(target) )
			if target then
				targetid = CellFactory_GetType( target )
				--print( targetid )
			end
		elseif ( name == "reward" ) then
			reward = ComponentGetValue2( var, "value_string" )
			--print( tostring(reward) )
		elseif ( name == "lab_id" ) then
			lab_id = ComponentGetValue2( var, "value_string" )
			--print( tostring(lab_id) )
		elseif ( name == "level" ) then
			level = ComponentGetValue2( var, "value_int" )
			--print( type(level) )
		end
	end
end

goldid = CellFactory_GetType( 'gold' )

for _,id in pairs(EntityGetInRadiusWithTag(pos_x, pos_y, 23, "item_pickup")) do
	-- make sure item is not carried in inventory or wand
	if EntityGetRootEntity(id) == id and EntityGetComponent( id, "PotionComponent" ) then
		local matid = GetMaterialInventoryMainMaterial( id )
		--print('mat', matid)
		if matid == targetid or matid == goldid then
			local inv = EntityGetFirstComponentIncludingDisabled( id, "MaterialInventoryComponent" )
			if inv then
				local counts = ComponentGetValue2( inv, "count_per_material_type" )
				--print( tostring( counts ) )
				if counts then
					--at_print_table( counts )
					local amount = counts[ matid+1 ]
					--print( matid, amount )
					local bar = 500
					if amount > bar then
						EntityKill( entity_id )
						local rewards = EntityGetInRadiusWithTag( pos_x, pos_y, 500, "at_reward" )
						for _,checker_id in pairs(rewards) do
							EntityKill( checker_id )
						end
						GameAddFlagRun('AT_MASTER_VISITED_' .. lab_id)
						if matid == goldid then
							spawn_gold( pos_x, pos_y )
						elseif reward == 'treasure' then
							spawn_great_chest( pos_x, pos_y, level )
						elseif reward == 'knowledge' then
							spawn_grand_material( pos_x, pos_y, level )
						elseif reward == 'power' then
							spawn_wand( pos_x, pos_y, level )
						elseif reward == 'magic' then
							spawn_spells( pos_x, pos_y, level )
						else
							spawn_great_chest( pos_x, pos_y, level )
						end
						return
					end
				end
			end
		end
	end
end
