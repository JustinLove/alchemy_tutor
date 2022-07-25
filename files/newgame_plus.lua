at_base_do_newgame_plus = do_newgame_plus
function do_newgame_plus()
	GlobalsSetValue( "AT_REMOTE_LAB_COUNT", "0" )
	GlobalsSetValue( "AT_HALL_OF_MASTERS_COUNT", "0" )
	at_base_do_newgame_plus()
end
