at_base_spawn_ghost_crystal_records = at_spawn_ghost_crystal_records
function at_spawn_ghost_crystal_records( x, y )
	at_base_spawn_ghost_crystal_records( x, y )
	EntityLoad( "mods/alchemy_tutor/files/entities/hall_of_masters_chest.xml", x + 60, y + 30 )
end
