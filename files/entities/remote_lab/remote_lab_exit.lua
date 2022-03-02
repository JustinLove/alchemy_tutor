dofile_once('mods/alchemy_tutor/files/entities/remote_lab/remote_lab.lua')

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local id = "1"
local radius = 350

local var = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )

if ( var ~= nil ) then
	id = ComponentGetValue2( var, "value_string" )
end

local range = EntityGetFirstComponentIncludingDisabled( entity_id, "ParticleEmitterComponent" )

if ( range ~= nil ) then
	radius = ComponentGetValue2( range, "area_circle_radius" )
end

local p = EntityGetInRadiusWithTag( x, y, radius, "player_unit" )

if #p > 0 then
	GlobalsSetValue( "AT_REMOTE_LAB_PLAYERS_" .. id, "10" )
else
	local t = tonumber( GlobalsGetValue( "AT_REMOTE_LAB_PLAYERS_" .. id ) )
	if t > 0 then
		GlobalsSetValue( "AT_REMOTE_LAB_PLAYERS_" .. id, tostring( t - 1) )
	end
end

--print( 'here', id, #p )

local total = 0
for i = 1,2 do
	id = tostring(i)
	total = total + tonumber( GlobalsGetValue( "AT_REMOTE_LAB_PLAYERS_" .. id, "9" ) )
end

--print( 'total', total ) 

if ( total == 0 ) then
	at_remote_lab_exit( x, y )
	EntityKill( entity_id )
end
