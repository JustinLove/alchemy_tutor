dofile_once("data/scripts/lib/utilities.lua")

local drain_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( drain_id )

local drain_inv = EntityGetFirstComponentIncludingDisabled( drain_id, "MaterialInventoryComponent" )
local drain_sucker = EntityGetFirstComponentIncludingDisabled( drain_id, "MaterialSuckerComponent" )
if not drain_inv or not drain_sucker then
	return
end

local drain_counts = ComponentGetValue2( drain_inv, "count_per_material_type" )

if not drain_counts then
	return
end

for _,container_id in pairs(EntityGetInRadiusWithTag(pos_x, pos_y + 36, 10, "potion")) do
	-- make sure item is not carried in inventory or wand
	if EntityGetRootEntity(container_id) == container_id then
		--print( "found", container_id )
		local matid = GetMaterialInventoryMainMaterial( drain_id )
		local container_sucker = EntityGetFirstComponentIncludingDisabled( container_id, "MaterialSuckerComponent" )
		local container_inv = EntityGetFirstComponentIncludingDisabled( container_id, "MaterialInventoryComponent" )
		local container_counts = ComponentGetValue2( container_inv, "count_per_material_type" )

		if container_sucker and container_inv and container_counts then
			local container_amount = ComponentGetValue2( container_sucker, "mAmountUsed" )
			local container_capacity = ComponentGetValue2( container_sucker, "barrel_size" )

			local container_space = math.max(0, container_capacity - container_amount)
			if container_space > 0 then
				local amount_drained = drain_counts[ matid+1 ]
				local amount_container = container_counts[ matid+1 ]
				local amount_added = math.min( amount_drained, container_space )
				local matname = CellFactory_GetName(matid)
				--print( matname, amount_drained, amount_added )
				AddMaterialInventoryMaterial(container_id, matname, amount_container + amount_added)
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
