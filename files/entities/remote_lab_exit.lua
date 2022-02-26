dofile_once('mods/alchemy_tutor/files/remote_lab.lua')

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

GlobalsSetValue( "AT_REMOTE_LAB_PLAYERS_" .. id, tostring( #p ) )

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
