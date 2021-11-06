dofile_once("mods/alchemy_tutor/files/alchemy_tutor.lua")

RegisterSpawnFunction( 0xffc80010, "spawn_material")
RegisterSpawnFunction( 0xffc80011, "spawn_material")
RegisterSpawnFunction( 0xffc80012, "spawn_material")
RegisterSpawnFunction( 0xffc80013, "spawn_material")
RegisterSpawnFunction( 0xffc80020, "spawn_shroom")
RegisterSpawnFunction( 0xffc80021, "spawn_shroom")
RegisterSpawnFunction( 0xffc80030, "spawn_cauldron")
RegisterSpawnFunction( 0xffc80031, "spawn_cauldron")
RegisterSpawnFunction( 0xffc80053, "init_scene")

local at_materials = {}
local at_cauldrons = {}
local at_shrooms = {}

function init_scene( x, y )
	local set = pick_lab_set()
	SetRandomSeed( x, y )
	at_materials = {set.material1, set.material2, "", ""}
	shuffleTable( at_materials )
	at_cauldrons = {set, set}
	at_shrooms = {1, 2, 3, 4, 5}
	shuffleTable( at_shrooms )
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
	local shroom = table.remove( at_shrooms )
	if shroom then
		mushroom( shroom, x, y )
	end
end
