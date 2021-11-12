function create() {
	randomize()
	seed=random_get_seed()
	room_speed=60
	fastTravel=false
	show_debug_overlay(true);


	for(var s=0; s<4; s++){
		surface[s]=surface_create(1,1)
		surface_free(surface[s])
	}


	with(newInstance(World)){createWorld()}
	with(newInstance(Camera)){createCamera()}
	with(newInstance(MiniMap)){createMiniMap()}
	with(newInstance(TerrainPicker)){createTerrainPicker()}
	with(newInstance(Terrain)){createTerrain()}
	with(newInstance(Player)){createPlayer()}




}
