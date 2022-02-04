dofile_once("mods/alchemy_tutor/files/alchemy_tutor.lua")

RegisterSpawnFunction( 0xfff1a545, "at_spawn_material")
RegisterSpawnFunction( 0xff528003, "at_spawn_shroom")
RegisterSpawnFunction( 0xff591de8, "at_spawn_meat")
RegisterSpawnFunction( 0xff00f809, "at_spawn_frog")
RegisterSpawnFunction( 0xff05702e, "at_spawn_rock")
RegisterSpawnFunction( 0xff012e85, "at_spawn_other")
RegisterSpawnFunction( 0xffca1d80, "at_spawn_cauldron")
RegisterSpawnFunction( 0xff2e3a2d, "at_spawn_reward")
RegisterSpawnFunction( 0xff057ee1, "at_spawn_steel_pit")
RegisterSpawnFunction( 0xff0691c4, "at_spawn_brick_pit")
RegisterSpawnFunction( 0xff5ce4e5, "at_decorate_scene")
RegisterSpawnFunction( 0xff91a4e2, "at_look_here")

at_lab_chance = ModSettingGet("alchemy_tutor.lab_chance")
if at_lab_chance == nil then
	at_lab_chance = 1
end
--at_lab_chance = 9999999

local at_scene_cauldron = nil
local at_materials = {}
local at_cauldrons = {}
local at_other = {}
local at_reward = {}

function at_decorate_scene( x, y )
	local set = at_pick_lab_set( x, y )
	SetRandomSeed( x, y )
	shuffleTable( at_materials )
	shuffleTable( at_cauldrons )
	shuffleTable( at_other )

	local loc
	local red_herrings = 0
	local first = at_first_time( set )
	if not first then
		local max = #at_materials-#set.materials
		local mean = 1
		if ModSettingGet("alchemy_tutor.formula_progression") then
			max = math.min( at_passed_count, max )
			mean = math.log10( at_passed_count )
		end
		red_herrings = RandomDistribution( 0, max, mean, 2 )
	end
	local in_cauldron = {}
	local present_materials = {}
	local what

	local cauldron = set.cauldron or at_scene_cauldron or at_default_cauldron
	if cauldron.is_physics and set.cauldron_material and set.cauldron_material ~= cauldron.default_material then
		cauldron = at_cauldron
	elseif cauldron.default_material == "steel" and set.cauldron_material == "templebrick_static" then
		cauldron = at_cauldron
	end
	for i,loc in ipairs( at_cauldrons ) do
		what = cauldron.spawn( set, loc.x, loc.y, i )
		if what ~= nil then
			in_cauldron[what] = true
			present_materials[what] = true
			--print( "cauldron " .. what )
		end
	end

	for i,mat in ipairs( set.materials ) do
		what = at_material( mat, 'potion_empty', first )
		loc = table.remove( at_materials )
		if loc then
			if in_cauldron[what] then
				at_container( what, 0.0, loc.x, loc.y )
			else
				at_container( what, set.amounts[i] or 1.0, loc.x, loc.y )
			end
			present_materials[what] = true
			--print( "formula " .. what )
		end
	end

	local entity
	for i = 1, red_herrings do
		loc = table.remove( at_materials )
		if loc then
			entity = at_red_herring( loc.x, loc.y, present_materials )
			if entity ~= nil then
				what = CellFactory_GetName(GetMaterialInventoryMainMaterial( entity ))
				present_materials[what] = true
				--print( "red " .. what )
			end
		end
	end

	loc = table.remove( at_other )
	if loc and set.other then
		set.other( loc.x, loc.y )
	end

	loc = table.remove( at_reward )
	if loc and not set.hide_reward then
		EntityLoad( "mods/alchemy_tutor/files/entities/reward_marker.xml", loc.x + 1, loc.y - 6 )
	end

	at_scene_cauldron = nil
	at_materials = {}
	at_cauldrons = {}
	at_other = {}
	at_reward = {}
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

function at_spawn_reward( x, y )
	table.insert( at_reward, {x = x, y = y} )
end

function at_spawn_steel_pit( x, y )
	at_scene_cauldron = at_steel_pit
end

function at_spawn_brick_pit( x, y )
	at_scene_cauldron = at_brick_pit
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

function at_spawn_meat( x, y )
	EntityLoad( "data/entities/animals/wolf.xml", x, y )
end

function at_spawn_rock(x, y)
	spawn(at_rock,x,y)
end

at_rock =
{
	total_prob = 0,
	{
		prob   		= 0.2,
		min_count	= 1,
		max_count	= 1, 
		entity 	= "data/entities/props/physics_stone_02.xml",
	},
	{
		prob   		= 0.2,
		min_count	= 1,
		max_count	= 1, 
		entity 	= "data/entities/props/physics_stone_03.xml",
	},
}
