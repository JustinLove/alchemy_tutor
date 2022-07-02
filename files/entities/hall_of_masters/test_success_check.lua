dofile_once('mods/alchemy_tutor/files/alchemy_tutor.lua')

local function spawn_reward( x, y )
	EntityLoad( "data/entities/items/pickup/chest_random_super.xml", x, y)
	EntityLoad("data/entities/particles/image_emitters/magical_symbol.xml", x, y)
	GamePlaySound( "data/audio/Desktop/projectiles.snd", "player_projectiles/crumbling_earth/create", x, y)
end

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

local target = ""
local targetid = 0
local var = EntityGetFirstComponent( entity_id, "VariableStorageComponent" )
if var then
	target = ComponentGetValue2( var, "value_string" )
	print( tostring(target) )
	if target then
		targetid = CellFactory_GetType( target )
		print( targetid )
	end
end

for _,id in pairs(EntityGetInRadiusWithTag(pos_x, pos_y, 40, "item_pickup")) do
	-- make sure item is not carried in inventory or wand
	if EntityGetRootEntity(id) == id and EntityGetComponent( id, "PotionComponent" ) then
		local matid = GetMaterialInventoryMainMaterial( id )
		if matid == targetid then
			local inv = EntityGetFirstComponentIncludingDisabled( id, "MaterialInventoryComponent" )
			if inv then
				print( "got inventory" )
				local counts = ComponentGetValue2( inv, "count_per_material_type" )
				--print( tostring( counts ) )
				if counts then
					--at_print_table( counts )
					local amount = counts[ matid+1 ]
					print( matid, amount )
					local bar = 500
					if at_get_material_type( target) == "powder" then
						bar = 750
					end
					if amount > bar then
						spawn_reward( pos_x, pos_y )
						EntityKill( entity_id )
						return
					end
				end
			end
		end
		return
	end
end
