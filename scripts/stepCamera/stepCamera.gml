function stepCamera() {
	var ww=window_get_width()
	var wh=window_get_height()
	if(Game.fastTravel==true){
		var xDist=abs(min(0,(x*spe)-ww))
		var yDist=abs(min(0,(y*spe)-wh))

		//view and camera needs to be set BEFORE you change the x and y to avoide gfx glitches.
		view_xport[0]=xDist
		view_yport[0]=yDist
		view_wport[0]=ww-xDist
		view_hport[0]=wh-yDist
		camera_set_view_size(view_camera[0],max(0,ww-xDist),max(0,wh-yDist));
		camera_set_view_pos(view_camera[0],max(0,(x*spe)-ww),max(0,(y*spe)-wh))
		view_xport[1]=xDist
		view_yport[1]=0
		view_wport[1]=ww-xDist
		view_hport[1]=yDist
		camera_set_view_size(view_camera[1], max(0,ww-xDist),min(wh,yDist));
		camera_set_view_pos(view_camera[1],max(0,(x*spe)-ww),(sSize-yDist))
		view_xport[2]=0
		view_yport[2]=yDist
		view_wport[2]=xDist
		view_hport[2]=max(0,wh-yDist)
		camera_set_view_size(view_camera[2],min(ww,xDist), max(0,wh-yDist));
		camera_set_view_pos(view_camera[2],(sSize-xDist),max(0,(y*spe)-wh))
		view_xport[3]=0
		view_yport[3]=0
		view_wport[3]=xDist
		view_hport[3]=yDist
		camera_set_view_size(view_camera[3],min(ww,xDist),min(wh,yDist));
		camera_set_view_pos(view_camera[3],(sSize-xDist),(sSize-yDist))
	}
	else{

	camera_set_view_pos(view_camera[0],x*spe,y*spe)
	}


	if(keyboard_check(ord("D")) || keyboard_check(ord("A"))){
		x+=(keyboard_check(ord("D"))-keyboard_check(ord("A")))

	}

	if(Game.fastTravel==true){
			if(x<0){x=size}
			if(x>size){x-=size}	
		}

	if(keyboard_check(ord("S")) || keyboard_check(ord("W"))){
		y+=(keyboard_check(ord("S"))-keyboard_check(ord("W")))

	}
		if(Game.fastTravel==true){
			if(y<0){y=size}
			if(y>size){y-=size}	
		}


}
