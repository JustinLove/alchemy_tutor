local effect_id = GetUpdatedEntityID()
local entity_id = EntityGetParent( effect_id )
local models = EntityGetComponent( entity_id, "CharacterPlatformingComponent" )
if( models ~= nil ) then
	for i,model in ipairs(models) do
		ComponentSetValue( model, "pixel_gravity", 350 )
	end
end
