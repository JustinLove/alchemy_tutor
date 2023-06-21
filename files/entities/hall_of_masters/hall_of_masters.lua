dofile_once( 'mods/alchemy_tutor/files/entities/hall_of_masters/hall_of_masters_locations.lua' )


local function next_lab()
	for _,loc in ipairs(at_lab_locations) do
		if not GameHasFlagRun( 'AT_MASTER_VISITED_' .. loc.id ) then
			return loc
		end
	end

	local index = (tonumber( GlobalsGetValue( "AT_HALL_OF_MASTERS_COUNT", "0" ) ) % #at_lab_locations + 1)
	return at_lab_locations[index]
end

function at_spawn_hall_of_masters_0( x, y )
	LoadPixelScene(
		"mods/alchemy_tutor/files/biome_impl/spliced/hall_of_masters/0.plz",
		"", -- visual
		x + 105, y + 113,
		"mods/alchemy_tutor/files/biome_impl/spliced/hall_of_masters/0_background.png",
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{
		}, -- color_to_matieral_table
		50 -- z index
	)
end

function at_spawn_hall_of_masters_1( x, y )
	LoadPixelScene(
		"mods/alchemy_tutor/files/biome_impl/spliced/hall_of_masters/1.plz",
		"", -- visual
		x + 96, y,
		"mods/alchemy_tutor/files/biome_impl/spliced/hall_of_masters/1_background.png",
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{
		}, -- color_to_matieral_table
		50 -- z index
	)
end

function at_spawn_hall_of_masters_2( x, y )
	LoadPixelScene(
		"mods/alchemy_tutor/files/biome_impl/spliced/hall_of_masters/2.plz",
		"", -- visual
		x + 187, y,
		"mods/alchemy_tutor/files/biome_impl/spliced/hall_of_masters/2_background.png",
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{
		}, -- color_to_matieral_table
		50 -- z index
	)
end

function at_spawn_hall_of_masters_3( x, y )
	LoadPixelScene(
		"mods/alchemy_tutor/files/biome_impl/spliced/hall_of_masters/3.plz",
		"", -- visual
		x, y + 113,
		"mods/alchemy_tutor/files/biome_impl/spliced/hall_of_masters/3_background.png",
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{
		}, -- color_to_matieral_table
		50 -- z index
	)
end

function at_spawn_hall_of_masters_4( x, y )
	LoadPixelScene(
		"mods/alchemy_tutor/files/biome_impl/spliced/hall_of_masters/4.plz",
		"", -- visual
		x, y,
		"mods/alchemy_tutor/files/biome_impl/spliced/hall_of_masters/4_background.png",
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{
		}, -- color_to_matieral_table
		50 -- z index
	)

	local lx = x - 512
	local ly = y - 512
	local lab = at_get_lab( lx, ly )
	if lab and lab.biome ~= nil then
		LoadPixelScene(
			"mods/alchemy_tutor/files/biome_impl/hall_of_masters/hall_of_masters_bulk_access.png",
			"", -- visual
			lx + 821, ly + 795,
			"", -- background
			true, -- skip_biome_checks
			false, -- skip_edge_textures
			{
			}, -- color_to_matieral_table
			50 -- z index
		)
	end
end

function at_spawn_hall_of_masters_5( x, y )
	LoadPixelScene(
		"mods/alchemy_tutor/files/biome_impl/spliced/hall_of_masters/5.plz",
		"", -- visual
		x, y,
		"mods/alchemy_tutor/files/biome_impl/spliced/hall_of_masters/5_background.png",
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{
		}, -- color_to_matieral_table
		50 -- z index
	)
end

function at_spawn_hall_of_masters( x, y )
	local width, height = 512, 512
	at_spawn_hall_of_masters_0( x, y )
	at_spawn_hall_of_masters_1( x, y + height )
	at_spawn_hall_of_masters_2( x, y + height*2 )
	at_spawn_hall_of_masters_3( x + width, y )
	at_spawn_hall_of_masters_4( x + width, y + height)
	at_spawn_hall_of_masters_5( x + width, y + height*2 )
end

at_biome_map = {}

-- from noita utilities.lua
function at_check_parallel_pos( x )
	local pw = GetParallelWorldPosition( x, 0 )

	local mapwidth = BiomeMapGetSize() * 512
	local half = mapwidth * 0.5

	local mx = ( ( x + half ) % mapwidth ) - half

	return pw,mx
end

local function virtual_biome_place( bx, by, f )
	if not at_biome_map[bx] then
		at_biome_map[bx] = {}
	end
	at_biome_map[bx][by] = f
end

local function virtual_biome_place_labs( labs )
	for i = 1,#labs do
		local lab = labs[i]
		local bx = lab.x / 512
		local by = lab.y / 512
		virtual_biome_place( bx, by, at_spawn_hall_of_masters_0 )
		virtual_biome_place( bx, by + 1, at_spawn_hall_of_masters_1 )
		virtual_biome_place( bx, by + 2, at_spawn_hall_of_masters_2 )
		virtual_biome_place( bx + 1, by, at_spawn_hall_of_masters_3 )
		virtual_biome_place( bx + 1, by + 1, at_spawn_hall_of_masters_4 )
		virtual_biome_place( bx + 1, by + 2, at_spawn_hall_of_masters_5 )
	end
end

if ModSettingGet("alchemy_tutor.fixed_pixel_scenes") then
	virtual_biome_place_labs( at_lab_locations )
	virtual_biome_place_labs( at_special_lab_locations )
end

function at_get_lab_location()
	local lab = next_lab()
	return lab.x, lab.y
end

function at_next_lab_visited()
	local lab = next_lab()
	GameAddFlagRun('AT_MASTER_VISITED_' .. lab.id)
end

function at_get_entrance_location()
	local x, y = at_get_lab_location()
	x = x + at_hom_entrance_x
	y = y + at_hom_entrance_y
	return x, y
end

function at_get_lab_biome_bulk( x, y )
	local loc = at_get_lab( x, y )
	if loc then
		return loc.biome
	end
end

function at_get_lab_local_materials( x, y )
	local loc = at_get_lab( x, y )
	if loc then
		return loc.local_materials or {}
	end
	return {}
end

function at_get_lab_biome_modifier( x, y )
	local loc = at_get_lab( x, y )
	if loc then
		return loc.biome_modifier
	end
end

function at_get_lab_id( x, y )
	local loc = at_get_lab( x, y )
	if loc then
		return loc.id
	end
end

function at_get_lab_level( x, y )
	local pw = at_check_parallel_pos( x )
	pw = math.abs(pw)
	local loc = at_get_lab( x, y )
	local level = 2
	if loc then
		level = loc.level
	end
	return math.min(5, level + pw)
end

function at_remember_return_location( teleport_back_x, teleport_back_y )
	--print( "teleported from: " .. tostring(teleport_back_x) .. ", " .. tostring(teleport_back_y) )
	-- - 50
	GlobalsSetValue( "AT_TELEPORT_REMOTE_LAB_POS_X", tostring( teleport_back_x ) )
	GlobalsSetValue( "AT_TELEPORT_REMOTE_LAB_POS_Y", tostring( teleport_back_y ) )
end

function at_spawn_return_portal( x, y )
	local portal
	local portals = EntityGetInRadiusWithTag( x, y, 5, "at_remote_lab_portal" )

	if #portals > 0 then
		portal = portals[1]
	else
		portal = EntityLoad( "mods/alchemy_tutor/files/entities/remote_lab/remote_lab_return.xml", x, y )
	end

	local teleport_comp = EntityGetFirstComponentIncludingDisabled( portal, "TeleportComponent" )

	local teleport_back_x = 0
	local teleport_back_y = 0

	-- get the defaults from teleport_comp(s)
	if( teleport_comp ~= nil ) then
		teleport_back_x, teleport_back_y = ComponentGetValue2( teleport_comp, "target" )
		--print( "teleport std pos:" .. teleport_back_x .. ", " .. teleport_back_y )

		teleport_back_x = tonumber( GlobalsGetValue( "AT_TELEPORT_REMOTE_LAB_POS_X", teleport_back_x ) )
		teleport_back_y = tonumber( GlobalsGetValue( "AT_TELEPORT_REMOTE_LAB_POS_Y", teleport_back_y ) )

		--print( "teleport stored pos:" .. teleport_back_x .. ", " .. teleport_back_y )

		ComponentSetValue2( teleport_comp, "target", teleport_back_x, teleport_back_y )
	end
end

function at_stop_music( x, y )
	GameTriggerMusicFadeOutAndDequeueAll( 1.0 )
end

function at_cleanup_backstage( x, y )
	local backstage = EntityGetInRadiusWithTag( x, y, 400, "at_backstage" )
	for i,v in ipairs( backstage ) do
		if EntityHasTag( v, "music_energy_000" ) then
			local audio = EntityGetFirstComponent( v, "AudioLoopComponent" )
			EntityAddComponent( v, "LifetimeComponent", 
			{
				lifetime = 180,
			} )
			EntityAddComponent( v, "LuaComponent", 
			{
				script_source_file = "mods/alchemy_tutor/files/entities/remote_lab/music_fade.lua",
				execute_every_n_frame = 10
			} )
		else
			EntityKill( v )
		end
	end
end

function at_cleanup_actors( x, y )
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
	for i,v in ipairs( rewards ) do
		EntityKill( v )
	end
end

function at_remote_lab_exit( x, y )
	at_cleanup_backstage( x, y )
	--at_stop_music( x, y )
end
