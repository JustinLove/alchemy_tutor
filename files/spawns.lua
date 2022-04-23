if at_remove_remote_lab_key then
	at_remove_remote_lab_key()
end

dofile_once("mods/alchemy_tutor/files/alchemy_tutor.lua")
dofile_once("mods/alchemy_tutor/files/smallfolk.lua")

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
RegisterSpawnFunction( 0xff5ce4e5, "at_spawn_scene")
RegisterSpawnFunction( 0xff91a4e2, "at_look_here")

RegisterSpawnFunction( 0xffac41e7, "at_spawn_records" )
RegisterSpawnFunction( 0xff1f1002, "at_mark_floor1" )
RegisterSpawnFunction( 0xff2f1002, "at_mark_floor2" )
RegisterSpawnFunction( 0xff3f1002, "at_mark_floor3" )
RegisterSpawnFunction( 0xff4f1002, "at_mark_floor4" )
RegisterSpawnFunction( 0xff1ef700, "at_record_left" )
RegisterSpawnFunction( 0xff218470, "at_record_right" )

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

function at_spawn_scene( x, y )
	local cauldron = at_scene_cauldron or at_default_cauldron
	local text = smallfolk.dumps({
		sc = cauldron and cauldron.name,
		sb = at_biome_banned_materials,
		m = at_materials,
		c = at_cauldrons,
		o = at_other,
		r = at_reward,
	})

	local dc = EntityLoad( "mods/alchemy_tutor/files/entities/decorate_scene.xml", x, y )
	if dc then
		at_log( 'scene pixel', tostring(dc), x, y )
		local var = EntityGetFirstComponent( dc, "VariableStorageComponent" )
		if var then
			ComponentSetValue2( var, "value_string", text )
		end
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
	local id = EntityLoad( "mods/alchemy_tutor/files/entities/reward_marker.xml", x + 1, y - 6 )
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

local at_left
local at_right
local at_floor = 0

function at_record_left( x, y )
	print('left')
	at_left = math.floor(x/48)
end

function at_record_right( x, y )
	print('right')
	at_right = math.floor(x/48)
end

function at_mark_floor1( x, y )
	at_mark_floor( x, y, 1 )
end

function at_mark_floor2( x, y )
	at_mark_floor( x, y, 2 )
end

function at_mark_floor3( x, y )
	at_mark_floor( x, y, 3 )
end

function at_mark_floor4( x, y )
	at_mark_floor( x, y, 4 )
end

at_rendevous = {}
local at_hall_of_records_width = 12

function at_mark_floor( x, y, floor )
	if x % 48 == 0 then
		local col = 0
		if at_left then
			col = x/48 - at_left
		elseif at_right then
			col = x/48 + 12 - at_right
		end
		local record = col + (floor - 1)*at_hall_of_records_width
		at_rendevous[tostring(x)..','..tostring(y-48)] = record
		if record <= #at_formula_list then
			at_record_pedestals( x, y )
		end
	end
end

function at_spawn_records( x, y )
	local record = at_rendevous[tostring(x)..','..tostring(y)]
	print('spawn', x, y, record )
	if at_formulas['toxicclean'] == nil then
		at_setup()
	end
	local formula = at_formula_list[record]
	if not formula then
		return
	end
	--if not HasFlagPersistent( "at_formula_" .. formula.name ) then
		--at_log( 'not achieved', tostring(formula.name), tostring(formula.output) )
		--return
	--end
	local what = at_pick_record_exemplar( formula ) or 'air'
	local loc = at_materials[2]
	at_log( 'record', tostring(formula.name), tostring(what))
	if what == nil or what == "" then
		what = potion_empty
	end
	local eid = at_container( what, 1.0, loc.x, loc.y )
	EntityAddComponent( eid, "SpriteComponent", { 
		_tags="shop_cost,enabled_in_world",
		image_file="data/fonts/font_pixel_white.xml", 
		is_text_sprite="1", 
		offset_x="16",
		offset_y="32", 
		has_special_scale="1",
		special_scale_x="0.5",
		special_scale_y="0.5",
		update_transform="1" ,
		update_transform_rotation="0",
		text=tostring(formula.name),
		} )
	at_materials = {}
end

function at_preclear_for_mini( x, y, radius )
	local entities = EntityGetInRadius( x, y, radius )
	PhysicsRemoveJoints( x - 70, y - 70, x + 70, y + 20 )
	for i = 1,#entities do
		local id = entities[i]
		--print( id, tostring( EntityGetParent( id ) ), EntityGetFilename( id ), EntityGetTags( id ) )
		if EntityGetParent( id ) ~= 0 then
		elseif EntityHasTag( id, "prop" ) or EntityHasTag( id, "enemy" ) or EntityHasTag( id, "homing_target" ) then
			EntityKill( id )
		end
	end
end
