function createTerrain() {
	x=TerrainPicker.x/32
	y=TerrainPicker.y/32
	seed=Game.seed+(1+x)*(1+y)
	terrainType=World.value[TerrainPicker.x/32,TerrainPicker.y/32]
	sprite=World.sprite
	vertex_format_begin()
	vertex_format_add_position()
	vertex_format_add_normal()
	vertex_format_add_color()
	vertex_format_add_texcoord()
	vertexFormat = vertex_format_end()	
			
	vertexBuffer = vertex_create_buffer()
	vertex_begin(vertexBuffer, vertexFormat)
	var vx,vy,tx,ty,txx,tyy,t
	t[0]=0
	t[1]=32/512
	t[2]=64/512
	t[3]=96/512
	t[4]=128/512
	t[5]=160/512
	t[6]=192/512
	t[7]=224/512
	t[8]=256/512
	t[9]=288/512
	t[10]=320/512
	t[11]=352/512
	t[12]=384/512
	t[13]=416/512
	t[14]=448/512
	t[15]=480/512

	for(var w=0; w<=128; w++){
		for(var h=0; h<=128; h++){
			vx=w*32
			vy=h*32
			if(terrainType==World.cDeepSea)		{tx=choose(t[0],t[1],t[2],t[3],t[4],t[5],t[6],t[7],t[8],t[9],t[10],t[11],t[12],t[13],t[14],t[15])			ty=t[0] }
			if(terrainType==World.cShallowSea)	{tx=choose(t[0],t[1],t[2],t[3],t[4],t[5],t[6],t[7],t[8],t[9],t[10],t[11],t[12],t[13],t[14],t[15])			ty=t[1] }
			if(terrainType==World.cGrass)		{tx=choose(t[0],t[1],t[2],t[3],t[4],t[5],t[6],t[7],t[8],t[9],t[10],t[11],t[12],t[13],t[14],t[15])			ty=t[2] }
			if(terrainType==World.cIce)			{tx=choose(t[0],t[1],t[2],t[3],t[4],t[5],t[6],t[7],t[8],t[9],t[10],t[11],t[12],t[13],t[14],t[15])			ty=t[3] }
			if(terrainType==World.cSand)		{tx=choose(t[0],t[1],t[2],t[3],t[4],t[5],t[6],t[7],t[8],t[9],t[10],t[11],t[12],t[13],t[14],t[15])			ty=t[4] }
			if(terrainType==World.cStone)		{tx=choose(t[0],t[1],t[2],t[3],t[4],t[5],t[6],t[7],t[8],t[9],t[10],t[11],t[12],t[13],t[14],t[15])			ty=t[5] }
			if(terrainType==World.cIceWater)	{tx=choose(t[0],t[1],t[2],t[3],t[4],t[5],t[6],t[7],t[8],t[9],t[10],t[11],t[12],t[13],t[14],t[15])			ty=t[6] }
			if(terrainType==World.cThundra)		{tx=choose(t[0],t[1],t[2],t[3],t[4],t[5],t[6],t[7],t[8],t[9],t[10],t[11],t[12],t[13],t[14],t[15])			ty=t[7] }
			if(terrainType==World.cForrest)		{tx=choose(t[0],t[1],t[2],t[3],t[4],t[5],t[6],t[7],t[8],t[9],t[10],t[11],t[12],t[13],t[14],t[15])			ty=t[8] }
			if(terrainType==World.cJungle)		{tx=choose(t[0],t[1],t[2],t[3],t[4],t[5],t[6],t[7],t[8],t[9],t[10],t[11],t[12],t[13],t[14],t[15])			ty=t[9] }
			if(terrainType==World.cPine)		{tx=choose(t[0],t[1],t[2],t[3],t[4],t[5],t[6],t[7],t[8],t[9],t[10],t[11],t[12],t[13],t[14],t[15])			ty=t[10] }
			if(terrainType==World.cSwamp)		{tx=choose(t[0],t[1],t[2],t[3],t[4],t[5],t[6],t[7],t[8],t[9],t[10],t[11],t[12],t[13],t[14],t[15])			ty=t[11] }
			if(terrainType==World.cSavanah)	{tx=choose(t[0],t[1],t[2],t[3],t[4],t[5],t[6],t[7],t[8],t[9],t[10],t[11],t[12],t[13],t[14],t[15])			ty=t[12] }
			txx=tx+(32/512)
			tyy=ty+(32/512)
		
			vertex_position(vertexBuffer , vx, vy)			vertex_normal(vertexBuffer , 0, 0, -1)		vertex_color(vertexBuffer, $FFFFFF, 1)	vertex_texcoord(vertexBuffer, tx, ty)
			vertex_position(vertexBuffer , vx+32, vy)		vertex_normal(vertexBuffer , 0, 0, -1)		vertex_color(vertexBuffer, $FFFFFF, 1)	vertex_texcoord(vertexBuffer, txx, ty)
			vertex_position(vertexBuffer , vx, vy+32)		vertex_normal(vertexBuffer , 0, 0, -1)		vertex_color(vertexBuffer, $FFFFFF, 1)	vertex_texcoord(vertexBuffer, tx, tyy)
	
			vertex_position(vertexBuffer , vx, vy+32)		vertex_normal(vertexBuffer , 0, 0, -1)		vertex_color(vertexBuffer, $FFFFFF, 1)	vertex_texcoord(vertexBuffer, tx, tyy)
			vertex_position(vertexBuffer , vx+32, vy)		vertex_normal(vertexBuffer , 0, 0, -1)		vertex_color(vertexBuffer, $FFFFFF, 1)	vertex_texcoord(vertexBuffer, txx, ty)
			vertex_position(vertexBuffer , vx+32, vy+32)	vertex_normal(vertexBuffer , 0, 0, -1)		vertex_color(vertexBuffer, $FFFFFF, 1)	vertex_texcoord(vertexBuffer, txx,tyy)	
		}
	}

	vertex_end(vertexBuffer)
	vertex_freeze(vertexBuffer)


}
