-- see also biome_scripts location count
local lab_locations = {
	{ -- nw sky, above lake cloudscape
		x = -14848,
		y = -9216,
	},
	{ -- ne gold
		x = 13824,
		y = -4096,
		biome = 'gold',
	},
	{ -- ne sky niche
		x = 12800,
		y = -6656,
	},
	{ -- lake
		x = -16384,
		y = 4096,
		biome = 'water',
	},
	{ -- ne sky between work and chest
		x = 6656,
		y = -6656,
		biome_modifier = 'hot',
	},
	{ -- sw gold
		x = -15360,
		y = 15872,
		biome = 'gold',
	},
	{ -- ne sky niche
		x = 14848,
		y = -6656,
	},
}

function at_spawn_hall_of_masters( x, y )
	local width, height = 512, 512
	LoadPixelScene(
		"mods/alchemy_tutor/files/biome_impl/spliced/hall_of_masters/0.plz",
		"", -- visual
		x, y,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{
		}, -- color_to_matieral_table
		50 -- z index
	)
	LoadPixelScene(
		"mods/alchemy_tutor/files/biome_impl/spliced/hall_of_masters/1.plz",
		"", -- visual
		x + 84, y + height,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{
		}, -- color_to_matieral_table
		50 -- z index
	)
	LoadPixelScene(
		"mods/alchemy_tutor/files/biome_impl/spliced/hall_of_masters/2.plz",
		"", -- visual
		x + 166, y + height*2,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{
		}, -- color_to_matieral_table
		50 -- z index
	)
	LoadPixelScene(
		"mods/alchemy_tutor/files/biome_impl/spliced/hall_of_masters/3.plz",
		"", -- visual
		x + width, y + 189,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{
		}, -- color_to_matieral_table
		50 -- z index
	)
	LoadPixelScene(
		"mods/alchemy_tutor/files/biome_impl/spliced/hall_of_masters/4.plz",
		"", -- visual
		x + width, y + height,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{
		}, -- color_to_matieral_table
		50 -- z index
	)
	LoadPixelScene(
		"mods/alchemy_tutor/files/biome_impl/spliced/hall_of_masters/5.plz",
		"", -- visual
		x + width, y + height*2,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{
		}, -- color_to_matieral_table
		50 -- z index
	)
	local biome = at_get_lab_biome_bulk( x, y )
	if biome ~= nil then
		LoadPixelScene(
			"mods/alchemy_tutor/files/entities/hall_of_masters/hall_of_masters_bulk_access.png",
			"", -- visual
			x + 864, y + 702,
			"", -- background
			true, -- skip_biome_checks
			false, -- skip_edge_textures
			{
			}, -- color_to_matieral_table
			50 -- z index
		)
	end
end

local entrance_x = 267
local entrance_y = 287

function at_get_lab_location()
	local index = (tonumber( GlobalsGetValue( "AT_HALL_OF_MASTERS_COUNT", "0" ) ) % #lab_locations + 1)

	local x = lab_locations[index].x
	local y = lab_locations[index].y
	return x, y
end

function at_get_entrance_location()
	local x, y = at_get_lab_location()
	x = x + entrance_x
	y = y + entrance_y
	return x, y
end

function at_get_lab_biome_bulk( x, y )
	for _,loc in ipairs(lab_locations) do
		if loc.x == x and loc.y == y then
			return loc.biome
		end
	end
end

function at_get_lab_biome_modifier( x, y )
	for _,loc in ipairs(lab_locations) do
		if loc.x == x and loc.y == y then
			return loc.biome_modifier
		end
	end
end

function at_remember_return_location( teleport_back_x, teleport_back_y )
	--print( "teleported from: " .. tostring(teleport_back_x) .. ", " .. tostring(teleport_back_y) )
	-- - 50
	GlobalsSetValue( "AT_TELEPORT_REMOTE_LAB_POS_X", tostring( teleport_back_x ) )
	GlobalsSetValue( "AT_TELEPORT_REMOTE_LAB_POS_Y", tostring( teleport_back_y ) )
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
