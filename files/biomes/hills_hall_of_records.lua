dofile_once("mods/alchemy_tutor/files/alchemy_tutor.lua")

RegisterSpawnFunction( 0xff1f1002, "at_mark_floor1" )
RegisterSpawnFunction( 0xff2f1002, "at_mark_floor2" )
RegisterSpawnFunction( 0xff3f1002, "at_mark_floor3" )
RegisterSpawnFunction( 0xff4f1002, "at_mark_floor4" )
RegisterSpawnFunction( 0xff5f1002, "at_mark_floor5" )
RegisterSpawnFunction( 0xff6f1002, "at_mark_floor6" )
RegisterSpawnFunction( 0xff1ef700, "at_record_left" )
RegisterSpawnFunction( 0xff218470, "at_record_right" )
RegisterSpawnFunction( 0xff840270, "at_spawn_ghost_crystal" )

local at_left
local at_right
local at_pedestal_offset = 20 
local at_pedestal_spacing = 36

function at_record_left( x, y )
	at_left = math.floor((x - at_pedestal_offset)/at_pedestal_spacing)
	--print('left', at_left)
end

function at_record_right( x, y )
	at_right = math.floor((x - at_pedestal_offset)/at_pedestal_spacing)
	--print('right', at_right)
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

function at_mark_floor5( x, y )
	at_mark_floor( x, y, 5 )
end

function at_mark_floor6( x, y )
	at_mark_floor( x, y, 6 )
end

at_rendevous = {}
local at_hall_of_records_width = 14

function at_mark_floor( x, y, floor )
	SetRandomSeed( x, y )
	if x % at_pedestal_spacing == at_pedestal_offset then
		local col = 0
		if at_left then
			col = (x - at_pedestal_offset)/at_pedestal_spacing - at_left
		elseif at_right then
			col = (x - at_pedestal_offset)/at_pedestal_spacing + at_hall_of_records_width - at_right
		end
		local record = (at_hall_of_records_width - col + 1) + (floor - 1)*at_hall_of_records_width
		--print( col, floor, x, y-48, record )
		at_rendevous[tostring(x)..','..tostring(y-48)] = record
		if record <= #at_formula_list then
			if at_formulas['toxicclean'] == nil then
				at_setup()
			end
			local set = at_formula_list[record]
			if not set then
				return
			end
			local material = 'templebrick_static'
			if set.cauldron and not set.cauldron.is_physics then
			  material = set.cauldron.default_material
			end
			if set.cauldron_material and set.cauldron_material ~= 'air' then
				material = set.cauldron_material
			end
			local what = 'air'
			if HasFlagPersistent( "at_formula_" .. set.name ) or _G['at_test_records'] then
				if set.record_spawn then
					at_log( 'record', tostring(set.name), 'spawn' )
					set.record_spawn( x + 8, y - 48 )
				else
					what = at_pick_record_exemplar( set ) or 'air'
				end
			end
			at_record_pedestals( x, y, material, what )
			if _G['at_test_records'] then
				local eid = EntityCreateNew()
				EntitySetTransform( eid, x, y )
				at_add_label( eid, 16, 16 + (record%2)*16, tostring(record) .. " " .. set.name )
			end
		end
	elseif Random(1, 200) == 1 then
		at_random_raw( x, y - 4)
	end
end

function at_add_label( eid, x, y, label )
	EntityAddComponent( eid, "SpriteComponent", { 
		_tags="shop_cost,enabled_in_world",
		image_file="data/fonts/font_pixel_white.xml", 
		is_text_sprite="1", 
		offset_x=x,
		offset_y=y,
		has_special_scale="1",
		special_scale_x="0.5",
		special_scale_y="0.5",
		update_transform="1" ,
		update_transform_rotation="0",
		text=tostring(label),
		} )
end

function at_spawn_ghost_crystal( x, y )

	EntityLoad( "mods/alchemy_tutor/files/entities/hall_of_records/ghost_deflector_crystal.xml", x, y + 2 )
	at_ghost_deflector_base( x, y + 5 )
	--EntityLoad( "data/entities/buildings/physics_worm_deflector_base.xml", x, y + 5 )
	--EntityLoad( "data/entities/buildings/snowcrystal.xml", x + 30, y + 5 )

	EntityLoad( "mods/alchemy_tutor/files/entities/hall_of_records/hall_of_records_enter.xml", x, y + 5 )
end
