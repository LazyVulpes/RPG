function drawMiniMap() {
	if(surface_exists(Game.surface[0])){
		var v,c
		c=c_black
		v[0]  = 0
		v[1]  = World.size
		v[2]  = Camera.x
		v[3]  = Camera.y
		v[4]  = World.edge
		v[5]  = window_get_width()/64
		v[6]  = window_get_height()/64
		v[7]  = v[2]-v[5]
		v[8]  = v[3]-v[6]
		v[9]  = v[7]+v[4]
		v[10] = v[8]+v[4]
		v[11] = v[7]-v[4]
		v[12] = v[8]-v[4]
		v[13] = max(0,v[11])
		v[14] = max(0,v[12])
		v[15] = min(v[1],v[9])
		v[16] = min(v[1],v[10])
		v[17] = min(v[1],v[1]+v[11])
		v[18] = min(v[1],v[1]+v[12])
		v[19] = min(v[1],max(0,v[9]-v[1]))
		v[20] = min(v[1],max(0,v[10]-v[1]))
		v[21] = v[15]-v[13]
		v[22] = v[16]-v[14]
		v[23] = abs(min(0,v[11]))//this value can be calculated without abs
		v[24] = abs(min(0,v[12]))//this value can be calculated without abs
		draw_surface_part(Game.surface[0],v[13],v[14],v[21],v[22],x+v[23],y+v[24]) //black
		draw_surface_part(Game.surface[0],v[0],v[0],v[19],v[20],x+v[21],y+v[22]) //white
		draw_surface_part(Game.surface[0],v[17],v[18],v[23],v[24],x,y) //grey
		draw_surface_part(Game.surface[0],v[13],v[18],v[21],v[24],x+v[23],y) //green
		draw_surface_part(Game.surface[0],v[17],v[14],v[23],v[22],x,y+v[24])//blue
		draw_surface_part(Game.surface[0],v[13],v[0],v[21],v[20],x+v[23],y+v[22])//red
		draw_surface_part(Game.surface[0],v[0],v[14],v[19],v[22],x+v[21],y+v[24])//yellow
		draw_surface_part(Game.surface[0],v[17],v[0],v[23],v[20],x,y+v[22])//teal
		draw_surface_part(Game.surface[0],v[0],v[18],v[19],v[24],x+v[21],y)//orange
		draw_rectangle_color(x+v[4]-v[5],y+v[4]-v[6],x+v[4]+v[5],y+v[4]+v[6],c,c,c,c,true)
	
	}else{
		x=window_get_width()-World.center
		y=0
		Game.surface[0]=surface_create(World.size,World.size)
		surface_set_target(Game.surface[0])
		vertex_submit(vertexBuffer, pr_pointlist,-1)
		draw_point_color(Player.x/32,Player.y/32,c_red)
		surface_reset_target()
	}


}
