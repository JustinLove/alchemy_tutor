dofile_once("data/scripts/lib/utilities.lua")

local function spawn_reward( x, y )
	EntityLoad( "data/entities/items/pickup/chest_random.xml", x, y)
	EntityLoad("data/entities/particles/image_emitters/magical_symbol.xml", x, y)
	GamePlaySound( "data/audio/Desktop/projectiles.snd", "player_projectiles/crumbling_earth/create", x, y)
end

function material_area_checker_success( pos_x, pos_y )
	local entity_id = GetUpdatedEntityID()
	local x,y = EntityGetTransform(entity_id)

	local s = EntityGetComponent( entity_id, "VariableStorageComponent" )

	local formula
	if ( s ~= nil ) then
		for i,v in ipairs( s ) do
			local name = ComponentGetValue2( v, "name" )

			if ( name == "formula" ) then
				local formula = ComponentGetValue2( v, "value_string" )
				if formula and formula ~= '' then
					local key = "at_formula_" .. formula
					if not HasFlagPersistent( key ) then
						AddFlagPersistent( key )
						local at_passed_count = tonumber( GlobalsGetValue( "at_passed_count" ) )
						GlobalsSetValue( "at_passed_count", tostring(at_passed_count + 1) )
					end
				end
			end
		end
	end

	local cauldrons = EntityGetInRadiusWithTag( x, y, 200, "cauldron_checker" )

	for i,v in ipairs( cauldrons ) do
		if EntityGetFirstComponent( v, "PhysicsBody2Component" ) or EntityGetFirstComponent( v, "PhysicsBodyComponent" ) then
			local mat = EntityGetFirstComponent( v, "MaterialAreaCheckerComponent" )
			if mat then
				EntityRemoveComponent( v, mat )
			end

			local dam = EntityGetFirstComponent( v, "DamageModelComponent" )
			if dam then
				EntityRemoveComponent( v, dam )
			end
		else
			EntityKill( v )
		end
	end

	local rewards = EntityGetInRadiusWithTag( x, y, 500, "at_reward" )
	if #rewards == 0 then
		spawn_reward( x, y - 40 )
		return
	end

	local best_distance = 250000
	local best_reward = rewards[1]
	for i,v in ipairs( rewards ) do
		local rx,ry = EntityGetTransform(v)
		local d = get_distance2( x, y, rx, ry )
		if d < best_distance then
			best_distance = d
			best_reward = v
		end
	end
	EntityKill( best_reward )
	local rx,ry = EntityGetTransform( best_reward )
	spawn_reward( rx, ry )
end

function damage_received( damage, message, entity_thats_responsible, is_fatal, projectile_thats_responsible )
	--print( damage, message, tostring(is_fatal) )
	material_area_checker_success()
end

material_area_checker_failed = material_area_checker_success
electricity_receiver_switched = material_area_checker_success
