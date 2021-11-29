dofile_once("mods/alchemy_tutor/files/alchemy_tutor.lua")

RegisterSpawnFunction( 0xfff1a545, "at_spawn_material")
RegisterSpawnFunction( 0xff528003, "at_spawn_shroom")
RegisterSpawnFunction( 0xff00f809, "at_spawn_frog")
RegisterSpawnFunction( 0xff012e85, "at_spawn_other")
RegisterSpawnFunction( 0xffca1d80, "at_spawn_cauldron")
RegisterSpawnFunction( 0xff5ce4e5, "at_decorate_scene")
RegisterSpawnFunction( 0xff91a4e2, "at_look_here")

local at_setting_lab_chance = ModSettingGet("alchemy_tutor.lab_chance")
if at_setting_lab_chance == nil then
	at_setting_lab_chance = 0.5
end
at_lab_chance = 10 * (at_setting_lab_chance ^ 3.3)
--at_lab_chance = 9999999

local at_materials = {}
local at_cauldrons = {}
local at_other = {}

function at_decorate_scene( x, y )
	local set = at_pick_lab_set( x, y )
	SetRandomSeed( x, y )
	shuffleTable( at_materials )
	shuffleTable( at_cauldrons )
	shuffleTable( at_other )

	local loc

	loc = table.remove( at_materials )
	if loc then
		at_container( set.material1, loc.x, loc.y )
	end
	loc = table.remove( at_materials )
	if loc then
		at_container( set.material2, loc.x, loc.y )
	end
	loc = table.remove( at_materials )
	if loc then
		at_container( "red_herring", loc.x, loc.y )
	end

	loc = table.remove( at_cauldrons )
	if loc then
		at_cauldron( set, loc.x, loc.y )
	end
	loc = table.remove( at_cauldrons )
	if loc then
		at_cauldron( set, loc.x, loc.y )
	end

	loc = table.remove( at_other )
	if loc and set.other then
		set.other( loc.x, loc.y )
	end

	at_materials = {}
	at_cauldrons = {}
	at_other = {}
end

function at_look_here( x, y )
	local cx, cy = GameGetCameraPos()
	local player_entity = EntityGetClosestWithTag( cx, cy, "player_unit")
	if( player_entity ~= 0 ) then
		EntitySetTransform( player_entity, x, y )
	else
		GameSetCameraPos( x, y )
	end
end

function at_spawn_material( x, y )
	table.insert( at_materials, {x = x, y = y} )
end

function at_spawn_cauldron( x, y )
	table.insert( at_cauldrons, {x = x, y = y} )
end

function at_spawn_other( x, y )
	table.insert( at_other, {x = x, y = y} )
end

local at_shrooms = {}

function at_spawn_shroom( x, y )
	if #at_shrooms < 1 then
		SetRandomSeed( x, y )
		at_shrooms = {1, 2, 3, 4, 5}
		shuffleTable( at_shrooms )
	end
	local shroom = table.remove( at_shrooms )
	at_mushroom( shroom, x, y )
end

local at_frogs = {}

function at_spawn_frog( x, y )
	if #at_frogs < 1 then
		SetRandomSeed( x, y )
		at_frogs = {
			"data/entities/animals/frog.xml",
			"data/entities/animals/frog.xml",
			"data/entities/animals/frog.xml",
			"data/entities/animals/frog_big.xml",
		}
		shuffleTable( at_frogs )
	end
	local frog = table.remove( at_frogs )
	EntityLoad( frog, x, y )
end
