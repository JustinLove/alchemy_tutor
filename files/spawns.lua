dofile_once("mods/alchemy_tutor/files/alchemy_tutor.lua")

RegisterSpawnFunction( 0xfff1a545, "at_spawn_material")
RegisterSpawnFunction( 0xff528003, "at_spawn_shroom")
RegisterSpawnFunction( 0xff012e85, "at_spawn_other")
RegisterSpawnFunction( 0xffca1d80, "at_spawn_cauldron")
RegisterSpawnFunction( 0xff5ce4e5, "at_init_scene")

local at_materials = {}
local at_cauldrons = {}
local at_other = {}
local at_shrooms = {}

function at_init_scene( x, y )
	local set = at_pick_lab_set()
	SetRandomSeed( x, y )
	at_materials = {set.material1, set.material2, "", ""}
	shuffleTable( at_materials )
	at_cauldrons = {set, set}
	at_other = {set.other}
	shuffleTable( at_other )
end

function at_spawn_material( x, y )
	local material = table.remove( at_materials )
	if material then
		at_container( material, x, y )
	end
end

function at_spawn_cauldron( x, y )
	local conf = table.remove( at_cauldrons )
	if conf then
		at_cauldron( conf, x, y )
	end
end

function at_spawn_shroom( x, y )
	if #at_shrooms < 1 then
		SetRandomSeed( x, y )
		at_shrooms = {1, 2, 3, 4, 5}
		shuffleTable( at_shrooms )
	end
	local shroom = table.remove( at_shrooms )
	at_mushroom( shroom, x, y )
end

function at_spawn_other( x, y )
	local other = table.remove( at_other )
	if other then
		other( x, y )
	end
end
