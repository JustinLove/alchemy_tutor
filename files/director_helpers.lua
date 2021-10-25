
local at_load_random_pixel_scene = load_random_pixel_scene

function load_random_pixel_scene( what, x, y )
	print( tostring(x) .. "," .. tostring(y) )
	at_load_random_pixel_scene( what, x, y )
end
