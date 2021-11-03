dofile_once("mods/alchemy_tutor/files/alchemy_tutor.lua")

RegisterSpawnFunction( 0xffc80010, "pixel_test")

function pixel_test( x, y )
	decorate_lab_set( x - 76, y - 37, false, pick_lab_set() )
end
