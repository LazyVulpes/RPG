if (surface_get_width(application_surface)!=window_get_width() || surface_get_height(application_surface)!=window_get_height()){
		if(window_get_width()>0 && window_get_height()>0){
		camera_set_view_size(view_camera[0],window_get_width(),window_get_height())
		surface_resize(application_surface,window_get_width(),window_get_height())
		}
}


