dofile_once("mods/alchemy_tutor/files/alchemy_tutor.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

local formula
local set

local s = EntityGetComponent( entity_id, "VariableStorageComponent" )

if ( s ~= nil ) then
	for i,v in ipairs( s ) do
		local name = ComponentGetValue2( v, "name" )

		if ( name == "formula" ) then
			formula = ComponentGetValue2( v, "value_string" )
			break
		end
	end
end

if formula and formula ~= '' then
	if at_has_flag( formula ) or _G['at_test_records'] then
		set = at_find_formula_by_name( formula )

		if set then
			at_log('placeholder success', set.name )

			local what = at_spawn_record_completion( x, y, set )
			at_record_pedestal_fill( x, y, what )

			EntityKill( entity_id )
		end
	end
end
