--dofile_once("data/scripts/lib/utilities.lua")

function suspended_container_filled()
	local entity_id = GetUpdatedEntityID()
	local x,y = EntityGetTransform(entity_id)
	local comp_emit = EntityGetFirstComponent( entity_id, "ParticleEmitterComponent" )
	if comp_emit ~= nil then
		ComponentSetValue( comp_emit, "is_emitting", 0 )
	end
	local comp_mat = EntityGetFirstComponent( entity_id, "MaterialAreaCheckerComponent" )
	if comp_mat ~= nil then
		ComponentSetValue2( comp_mat, "update_every_x_frame", ComponentGetValue2( comp_mat, "update_every_x_frame" ) - 1000 )
	end
end

suspended_container_filled()
