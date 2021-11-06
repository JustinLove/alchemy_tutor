dofile_once("mods/alchemy_tutor/files/alchemy_tutor.lua")

RegisterSpawnFunction( 0xfff1a545, "spawn_material")
RegisterSpawnFunction( 0xff528003, "spawn_shroom")
RegisterSpawnFunction( 0xff012e85, "spawn_other")
RegisterSpawnFunction( 0xffca1d80, "spawn_cauldron")
RegisterSpawnFunction( 0xff5ce4e5, "init_scene")

local at_materials = {}
local at_cauldrons = {}
local at_other = {}
local at_shrooms = {}

function init_scene( x, y )
	local set = pick_lab_set()
	SetRandomSeed( x, y )
	at_materials = {set.material1, set.material2, "", ""}
	shuffleTable( at_materials )
	at_cauldrons = {set, set}
	at_other = {set.other}
	shuffleTable( at_other )
end

function spawn_material( x, y )
	local material = table.remove( at_materials )
	if material then
		spawn_container( material, x, y )
	end
end

function spawn_cauldron( x, y )
	local conf = table.remove( at_cauldrons )
	if conf then
		cauldron( conf, x, y )
	end
end

function spawn_shroom( x, y )
	if #at_shrooms < 1 then
		SetRandomSeed( x, y )
		at_shrooms = {1, 2, 3, 4, 5}
		shuffleTable( at_shrooms )
	end
	local shroom = table.remove( at_shrooms )
	mushroom( shroom, x, y )
end

function spawn_other( x, y )
	local other = table.remove( at_other )
	if other then
		other( x, y )
	end
end
