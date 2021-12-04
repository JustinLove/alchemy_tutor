dofile_once("mods/alchemy_tutor/files/alchemy_tutor.lua")
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
	if _G['at_test_player'] then
		GamePrint( "OnPlayerSpawned() - Player entity id: " .. tostring(player_entity) )
		EntitySetTransform( player_entity, at_test_x, at_test_y )
	end
	if _G['at_test_lab'] then
	  EntityLoad( "mods/alchemy_tutor/files/entities/spawn_lab.xml", at_test_x, at_test_y )
	end
end


function OnWorldInitialized() -- This is called once the game world is initialized. Doesn't ensure any world chunks actually exist. Use OnPlayerSpawned to ensure the chunks around player have been loaded or created.
	if _G['at_test_lab'] then
		local world = GameGetWorldStateEntity()
		local world_state = EntityGetFirstComponent( world, "WorldStateComponent" )
		ComponentSetValue( world_state, "time", 0 )
	end
end

--[[
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
ModLuaFileAppend( "data/scripts/biomes/coalmine.lua", "mods/alchemy_tutor/files/coalmine.lua" )
ModLuaFileAppend( "data/scripts/biomes/coalmine_alt.lua", "mods/alchemy_tutor/files/coalmine_alt.lua" )
ModLuaFileAppend( "data/scripts/biomes/excavationsite.lua", "mods/alchemy_tutor/files/excavationsite.lua" )
ModLuaFileAppend( "data/scripts/biomes/snowcave.lua", "mods/alchemy_tutor/files/snowcave.lua" )
ModLuaFileAppend( "data/scripts/biomes/snowcastle.lua", "mods/alchemy_tutor/files/snowcastle.lua" )
ModLuaFileAppend( "data/scripts/biomes/vault.lua", "mods/alchemy_tutor/files/vault.lua" )
ModLuaFileAppend( "data/scripts/biomes/rainforest.lua", "mods/alchemy_tutor/files/rainforest.lua" )
ModLuaFileAppend( "data/scripts/biomes/crypt.lua", "mods/alchemy_tutor/files/crypt.lua" )
ModLuaFileAppend( "data/scripts/biomes/mountain/mountain_left.lua", "mods/alchemy_tutor/files/spawns.lua" )
ModLuaFileAppend( "data/scripts/biomes/mountain/mountain_left_entrance.lua", "mods/alchemy_tutor/files/spawns.lua" )
ModLuaFileAppend( "data/scripts/biomes/mountain/mountain_left_stub.lua", "mods/alchemy_tutor/files/spawns.lua" )
ModLuaFileAppend( "data/scripts/biomes/hills.lua", "mods/alchemy_tutor/files/spawns.lua" )
ModLuaFileAppend( "data/scripts/biomes/hills.lua", "mods/alchemy_tutor/files/stubs.lua" )

ModMagicNumbersFileAdd( "mods/alchemy_tutor/files/magic_numbers.xml" ) -- Will override some magic numbers using the specified file
print("Example mod init done")
