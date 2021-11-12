function createMiniMap() {

	



		x=window_get_width()-World.size
		y=+World.size
		vertex_format_begin()
		vertex_format_add_position()
		vertex_format_add_colour()
		vertexFormat=vertex_format_end()
		vertexBuffer=vertex_create_buffer()
		vertex_begin(vertexBuffer, vertexFormat)	
		vertexBuffer = vertex_create_buffer()
		vertex_begin(vertexBuffer, vertexFormat)
		//var d1,d2,d3
		for(var w=0; w<=World.size; w++){	
			for(var h=0; h<=World.size; h++){
			
				vertex_position(vertexBuffer,w,h)	vertex_colour(vertexBuffer,World.value[w,h],1)
			}
		}

		vertex_end(vertexBuffer)
		vertex_freeze(vertexBuffer)



}
