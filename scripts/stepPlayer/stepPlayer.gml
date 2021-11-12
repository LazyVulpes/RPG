function stepPlayer() {
	if(Game.fastTravel==true){
		if(x<0){x=World.sSize}
		if(x>World.sSize){x-=World.sSize}	
	}
	if(Game.fastTravel==true){
		if(y<0){y=World.sSize}
		if(y>World.sSize){y-=World.sSize}	
	}



}
