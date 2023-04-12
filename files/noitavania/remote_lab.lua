local remote_lab_x = -16896
local remote_lab_y = 23040
local remote_lab_copies_across = 4

function at_get_lab_location()
	local iteration = tonumber( GlobalsGetValue( "AT_REMOTE_LAB_COUNT", "0" ) )

	local x = remote_lab_x + ( ( iteration % remote_lab_copies_across ) * 1024 )
	local y = remote_lab_y + ( math.floor( iteration / remote_lab_copies_across ) * 512 )
	return x, y
end
