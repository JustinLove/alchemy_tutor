dofile_once("data/scripts/lib/utilities.lua")

local drain_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( drain_id )

local drain_inv = EntityGetFirstComponentIncludingDisabled( drain_id, "MaterialInventoryComponent" )
local drain_sucker = EntityGetFirstComponentIncludingDisabled( drain_id, "MaterialSuckerComponent" )
if not drain_inv or not drain_sucker then
	return
end

local counts = ComponentGetValue2( drain_inv, "count_per_material_type" )

if not counts then
	return
end

for _,container_id in pairs(EntityGetInRadiusWithTag(pos_x, pos_y + 36, 10, "potion")) do
	-- make sure item is not carried in inventory or wand
	if EntityGetRootEntity(container_id) == container_id then
		--print( "found", container_id )
		local matid = GetMaterialInventoryMainMaterial( drain_id )
			local container_sucker = EntityGetFirstComponentIncludingDisabled( container_id, "MaterialSuckerComponent" )
			if container_sucker then
				local container_amount = ComponentGetValue2( container_sucker, "mAmountUsed" )
				local container_capacity = ComponentGetValue2( container_sucker, "barrel_size" )

				local container_space = math.max(0, container_capacity - container_amount)
				if container_space > 0 then
					local amount_drained = counts[ matid+1 ]
					local amount_added = math.min( amount_drained, container_space )
					local matname = CellFactory_GetName(matid)
					AddMaterialInventoryMaterial(container_id, matname, container_amount + amount_added)
					AddMaterialInventoryMaterial(drain_id, matname, amount_drained - amount_added)

					container_amount = ComponentGetValue2( container_sucker, "mAmountUsed" )
					container_space = math.max(0, container_capacity - container_amount)
					ComponentSetValue2( drain_sucker, "barrel_size", container_space )
				end
			end
		return
	end
end

-- no bottles found
EntityKill( drain_id )
