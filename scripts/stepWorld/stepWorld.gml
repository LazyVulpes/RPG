function stepWorld() {
	if(Game.fastTravel==true){
		if(mouse_check_button_released(mb_left)){
			if(instance_exists(Terrain)){
				instance_destroy(Terrain)
			}
			with(newInstance(Terrain)){createTerrain()}
		
		
			Game.fastTravel=false
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
		}
	}


}
