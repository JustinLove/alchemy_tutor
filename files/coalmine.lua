dofile_once("mods/alchemy_tutor/files/alchemy_tutor.lua")

local at_load_pixel_scene2 = load_pixel_scene2
function load_pixel_scene2( x, y )
	SetRandomSeed( x, y )
	if( Random( 1, 100 ) <= 10 ) then
		spawn_lab( x, y )
	else
		at_load_pixel_scene2( x, y )
	end
end
