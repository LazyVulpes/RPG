function step() {
	with(Camera){stepCamera()}
	with(Player){stepPlayer()}
	with(TerrainPicker){stepTerrainPicker()}
	with(World){stepWorld()}
	if(instance_exists(Menu)){with(Menu){stepMenu()}}

	if(keyboard_check_released(ord("M"))){
		if(fastTravel){
			fastTravel=false
			view_visible[1]=false
			view_visible[2]=false
			view_visible[3]=false
			view_xport[0]=0
			view_yport[0]=0
			view_wport[0]=window_get_width()
			view_hport[0]=window_get_height()
			camera_set_view_size(view_camera[0],window_get_width(),window_get_height());
			Camera.x=0
			Camera.y=0
			Player.x=0
			Player.y=0
		
		}else{
			fastTravel=true
			Camera.x=(Terrain.x)+((window_get_width()/2)/32)
			Camera.y=(Terrain.y)+((window_get_height()/2)/32)
			Player.x=(Terrain.x*32)
			Player.y=(Terrain.y*32)
			view_visible[1]=true
			view_visible[2]=true
			view_visible[3]=true
			surface_free(Game.surface[0])
		}
	}

	if(keyboard_check_released(vk_escape)){
	if(instance_exists(Menu)){
	instance_destroy(Menu)
	}else{
	with(newInstance(Menu)){createMenu()}
	}

	}


}
