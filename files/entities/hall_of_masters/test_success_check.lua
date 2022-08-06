dofile_once('mods/alchemy_tutor/files/alchemy_tutor.lua')

local function spawn_success( x, y )
	EntityLoad( "mods/alchemy_tutor/files/entities/hall_of_masters/success_effect.xml", x, y )
	EntityLoad("data/entities/particles/image_emitters/magical_symbol.xml", x, y)
	GamePlaySound( "data/audio/Desktop/projectiles.snd", "player_projectiles/crumbling_earth/create", x, y)
end

local function spawn_great_chest( x, y )
	EntityLoad( "data/entities/items/pickup/chest_random_super.xml", x, y)
	spawn_success( x, y )
end

local function spawn_grand_material( x, y )
	if #at_grand_materials < 1 then
		at_setup_grand_alchemy()
	end
	SetRandomSeed( x, y )
	local r = Random(1, #at_grand_materials)
	at_container( at_grand_materials[r], 1.0, x, y )
	spawn_success( x, y )
end

local function spawn_gold( x, y )
	EntityLoad( "mods/alchemy_tutor/files/entities/hall_of_masters/wealth.xml", x, y )
	spawn_success( x, y )
end

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

local target = ""
local reward = ""
local targetid = 0
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
		end
	end
end

for _,id in pairs(EntityGetInRadiusWithTag(pos_x, pos_y, 20, "item_pickup")) do
	-- make sure item is not carried in inventory or wand
	if EntityGetRootEntity(id) == id and EntityGetComponent( id, "PotionComponent" ) then
		local matid = GetMaterialInventoryMainMaterial( id )
		if matid == targetid then
			local inv = EntityGetFirstComponentIncludingDisabled( id, "MaterialInventoryComponent" )
			if inv then
				local counts = ComponentGetValue2( inv, "count_per_material_type" )
				--print( tostring( counts ) )
				if counts then
					--at_print_table( counts )
					local amount = counts[ matid+1 ]
					--print( matid, amount )
					local bar = 500
					if at_get_material_type( target) == "powder" then
						bar = 750
					end
					if amount > bar then
						if reward == 'treasure' then
							spawn_great_chest( pos_x, pos_y )
						elseif reward == 'knowledge' then
							spawn_grand_material( pos_x, pos_y )
						elseif reward == 'wealth' then
							spawn_gold( pos_x, pos_y )
						else
							spawn_great_chest( pos_x, pos_y )
						end
						EntityKill( entity_id )
						local rewards = EntityGetInRadiusWithTag( pos_x, pos_y, 500, "at_reward" )
						for _,checker_id in pairs(rewards) do
							EntityKill( checker_id )
						end
						return
					end
				end
			end
		end
	end
end
