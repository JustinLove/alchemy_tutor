dofile_once("data/scripts/director_helpers.lua")
-- all functions below are optional and can be left out

--[[

function OnModPreInit()
	print("Mod - OnModPreInit()") -- First this is called for all mods
end

function OnModInit()
	print("Mod - OnModInit()") -- After that this is called for all mods
end

function OnModPostInit()
	print("Mod - OnModPostInit()") -- Then this is called for all mods
end

]]--

function OnPlayerSpawned( player_entity ) -- This runs when player entity has been created
	GamePrint( "OnPlayerSpawned() - Player entity id: " .. tostring(player_entity) )

	-- 59, 37
	-- 67, 37
	-- 76, 37

	local x = -100
	local y = -200

	LoadPixelScene(
		"mods/alchemy_tutor/files/coalmine_lab.png",
		"mods/alchemy_tutor/files/coalmine_lab_visual.png",
		--"data/biome_impl/coalmine/laboratory.png",
		--"data/biome_impl/coalmine/laboratory_visual.png",
		x, y,
		"", -- background
		true, -- skip_biome_checks
		false, -- skip_edge_textures
		{ ["fff0bbee"] = "air" }, -- color_to_matieral_table
		50 -- z index
	)


	EntityLoad( "data/entities/items/pickup/potion_empty.xml", x+59, y+37 )
	EntityLoad( "mods/alchemy_tutor/files/entities/potion_faster.xml", x+67, y+37 )
	EntityLoad( "data/entities/items/pickup/potion_slime.xml", x+76, y+37 )
end

--[[

function OnWorldInitialized() -- This is called once the game world is initialized. Doesn't ensure any world chunks actually exist. Use OnPlayerSpawned to ensure the chunks around player have been loaded or created.
	GamePrint( "OnWorldInitialized() " .. tostring(GameGetFrameNum()) )
end

function OnWorldPreUpdate() -- This is called every time the game is about to start updating the world
	GamePrint( "Pre-update hook " .. tostring(GameGetFrameNum()) )
end

function OnWorldPostUpdate() -- This is called every time the game has finished updating the world
	GamePrint( "Post-update hook " .. tostring(GameGetFrameNum()) )
end

]]--

function OnMagicNumbersAndWorldSeedInitialized() -- this is the last point where the Mod* API is available. after this materials.xml will be loaded.
	local x = ProceduralRandom(0,0)
	print( "===================================== random " .. tostring(x) )
end


-- This code runs when all mods' filesystems are registered
ModMagicNumbersFileAdd( "mods/alchemy_tutor/files/magic_numbers.xml" ) -- Will override some magic numbers using the specified file
print("Example mod init done")
