function drawMenu() {
	draw_rectangle_color(x,y,x+w,y+h,$000000,$000000,$000000,$000000,false)
	draw_text_color(x+(w/2)-(string_width("New")/2),y+(h/2)-44,"New",$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,1)
	draw_text_color(x+(w/2)-(string_width("Save")/2),y+(h/2)-28,"Save",$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,1)
	draw_text_color(x+(w/2)-(string_width("Load")/2),y+(h/2)-12,"Load",$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,1)
	draw_text_color(x+(w/2)-(string_width("Options")/2),y+(h/2)+4,"Options",$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,1)
	draw_text_color(x+(w/2)-(string_width("Exit")/2),y+(h/2)+20,"Exit",$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,1)


}
