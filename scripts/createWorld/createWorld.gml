function createWorld() {

	sprite=sprite_get_texture(sprite_add("worldSprites.png",0,0,0,0,0),0)
	seed=Game.seed
	size=512
	sSize=size*32
	center=size*0.5
	edge=center*0.5
	var pi2=pi*2
	var r=size/pi2
	var v1,v2,v3,v4,v5,v6,v7,v8,v9,v10,landNoise,heightNoise,heatNoise,riverNoise,moistNoise
	cGrass=$008A00
	cDeepSea=$DD0000
	cShallowSea=$FF6600
	cIce=$FFFFFF
	cSand=$7ed8ea
	cStone=$BBBBBB
	cIceWater=$FFE0C6
	cThundra=$a8c193
	cForrest=$006600
	cJungle=$004D00
	cPine=$355435
	cSwamp=$4c826d
	cSavanah=$43abad
	for(var w=0; w<=size; w++){	
		for(var h=0; h<=size; h++){	
			v1[w,h] = r+r*sin(pi2*h/size)
			v2[w,h] = r+r*cos(pi2*w/size)
			v3[w,h] = r+r*sin(pi2*w/size)
			v4[w,h] = r+r*cos(pi2*h/size)
			v5[w,h] = 1-point_distance(w,h,center,center)/center
			v6[w,h] = 1-point_distance(w,h,0,0)/center
			v7[w,h] = 1-point_distance(w,h,size,0)/center
			v8[w,h] = 1-point_distance(w,h,0,size)/center
			v9[w,h] = 1-point_distance(w,h,size,size)/center
			v10[w,h] = max(v5[w,h],v6[w,h],v7[w,h],v8[w,h],v9[w,h])*1.5
		}
	}
	simplex_set_seed(seed)
	for(var w=0; w<=size; w++){	
		for(var h=0; h<=size; h++){	
			landNoise[w,h]=simplex_calculate_4d(v1[w,h],v2[w,h],v3[w,h],v4[w,h],0,1,4,0.4,0.006)
		}
	}
	simplex_set_seed(seed+1)
	for(var w=0; w<=size; w++){	
		for(var h=0; h<=size; h++){	
			heightNoise[w,h]=simplex_calculate_4d(v1[w,h],v2[w,h],v3[w,h],v4[w,h],0,1,4,0.5,0.02)
		}
	}
	for(var w=0; w<=size; w++){	
		for(var h=0; h<=size; h++){	
			heatNoise[w,h]=clamp((.5+(heightNoise[w,h])*.5)*v10[w,h],0,1)
			riverNoise[w,h]=((1-heightNoise[w,h])+heightNoise[h,w]+(landNoise[h,w]*2))/4
			moistNoise[w,h]=(heightNoise[w,h]+landNoise[w,h]+(1-heatNoise[w,h])+(1-riverNoise[w,h]))*0.25
		}
	}

#region map generation
	for(var w=0; w<=size; w++){	
		for(var h=0; h<=size; h++){	
				//continent
				if (landNoise[w,h]>=0){
					if (landNoise[w,h]<0.45){ 
						//tropical continent 
						if (heatNoise[w,h]>=0){
							if (heatNoise[w,h]<0.4){ 
								//tropical continent lake
								if (heightNoise[w,h]>=0){
									if (heightNoise[w,h]<0.3){ 
										value[w,h]=cShallowSea
									}
								}
								//tropical continent lake shore
								if (heightNoise[w,h]>=0.3){
									if (heightNoise[w,h]<0.32){ 
											//tropical continent lake shore jungle
										if (moistNoise[w,h]>=0){
											if (moistNoise[w,h]<0.5){ 
												value[w,h]=cJungle
											}
										}
									
										//tropical continent lake shore sand
									
										if (moistNoise[w,h]>=0.5){
											if (moistNoise[w,h]<=1){ 
												value[w,h]=cGrass
											}
										}
									}
								}
							
							
								//tropical continent ground
								if (heightNoise[w,h]>=0.32){
									if (heightNoise[w,h]<0.55){ 
									
									
										if (riverNoise[w,h]>=0){
											if (riverNoise[w,h]<0.5){ 
												//tropical continent ground jungle
												if (moistNoise[w,h]>=0){
													if (moistNoise[w,h]<0.51){ 
														value[w,h]=cJungle
													}
												}
											
												//tropical continent ground savanah
									
												if (moistNoise[w,h]>=0.51){
													if (moistNoise[w,h]<=0.55){ 
														value[w,h]=cSavanah
													}
												}
									
												//tropical continent ground sand
									
												if (moistNoise[w,h]>=0.55){
													if (moistNoise[w,h]<=1){ 
														value[w,h]=cSand
													}
												}
											}
										}
										//tropical continent river
										if (riverNoise[w,h]>=0.5){
											if (riverNoise[w,h]<0.51){ 
												value[w,h]=cShallowSea
											}
										}
										//tropical continent river bank
										if (riverNoise[w,h]>=0.51){
											if (riverNoise[w,h]<=1){ 
												//tropical continent ground jungle
												if (moistNoise[w,h]>=0){
													if (moistNoise[w,h]<0.51){ 
														value[w,h]=cJungle
													}
												}
											
												//tropical continent ground savanah
									
												if (moistNoise[w,h]>=0.51){
													if (moistNoise[w,h]<=0.55){ 
														value[w,h]=cSavanah
													}
												}
									
												//tropical continent ground sand
									
												if (moistNoise[w,h]>=0.55){
													if (moistNoise[w,h]<=1){ 
														value[w,h]=cSand
													}
												}
											}
										}
									
									
										
									}
								}
								//tropical continent mountain
								if (heightNoise[w,h]>=0.55){
									if (heightNoise[w,h]<0.6){ 
									
									
									
									
										//temperate continent river
										if (riverNoise[w,h]>=0){
											if (riverNoise[w,h]<0.5){ 
												//tropical continent mountain jungle
												if (moistNoise[w,h]>=0){
													if (moistNoise[w,h]<0.55){ 
														value[w,h]=cForrest
													}
												}
									
										//tropical continent mountain stone
										if (moistNoise[w,h]>=0.55){
											if (moistNoise[w,h]<=1){ 
												value[w,h]=cStone
												}
											}
										}
										}
										//tropical continent mountain river
										if (riverNoise[w,h]>=0.5){
											if (riverNoise[w,h]<0.51){ 
												value[w,h]=cShallowSea
											}
										}
										//temperate continent river
										if (riverNoise[w,h]>=0.51){
											if (riverNoise[w,h]<=1){ 
												//tropical continent mountain jungle
										if (moistNoise[w,h]>=0){
											if (moistNoise[w,h]<0.55){ 
												value[w,h]=cForrest
											}
										}
									
											//tropical continent mountain stone
									
											if (moistNoise[w,h]>=0.55){
												if (moistNoise[w,h]<=1){ 
													value[w,h]=cStone
												}
											}
											}
										}
									}
								}
								//tropical continent mountain
								if (heightNoise[w,h]>=0.6){
									if (heightNoise[w,h]<0.69){ 
										if (riverNoise[w,h]>=0){
											if (riverNoise[w,h]<0.5){ 
												value[w,h]=cStone
											}
										}
										if (riverNoise[w,h]>=0.5){
											if (riverNoise[w,h]<0.51){ 
												value[w,h]=cShallowSea
											}
										}
										if (riverNoise[w,h]>=0.51){
											if (riverNoise[w,h]<=1){ 
												value[w,h]=cStone
											}
										}
									
									}
								}
								//tropical continent mountain top
								if (heightNoise[w,h]>=0.69){
									if (heightNoise[w,h]<=1){ 
										value[w,h]=cIce
									}
								}
							}
						}
						//temperate continent 
						if (heatNoise[w,h]>=0.4){
							if (heatNoise[w,h]<0.75){ 
							
						//temperate continent swamp
								if (heightNoise[w,h]>=0){
									if (heightNoise[w,h]<0.25){ 
										value[w,h]=cSwamp
									}
								}
							
							//temperate continent ground
								if (heightNoise[w,h]>=0.25){
									if (heightNoise[w,h]<0.55){ 
										//temperate continent ground river
										if (riverNoise[w,h]>=0){
											if (riverNoise[w,h]<0.5){ 
									
												//temperate continent ground forrest
												if (moistNoise[w,h]>=0){
													if (moistNoise[w,h]<0.435){ 
														value[w,h]=cForrest
													}
												}
									
												//temperate continent ground grass
												if (moistNoise[w,h]>=0.435){
													if (moistNoise[w,h]<0.452){ 
														value[w,h]=cGrass
													}
												}
		
												//temperate continent river
												if (moistNoise[w,h]>=0.452){
													if (moistNoise[w,h]<0.458){ 
														value[w,h]=cShallowSea
													}
												}
												//temperate continent ground grass
												if (moistNoise[w,h]>=0.458){
													if (moistNoise[w,h]<0.485){ 
														value[w,h]=cGrass
													}
												}
									
												//temperate continent ground forrest
												if (moistNoise[w,h]>=0.485){
													if (moistNoise[w,h]<=1){ 
														value[w,h]=cForrest
													}
												}
											}
										}
										//temperate continent river
										if (riverNoise[w,h]>=0.5){
											if (riverNoise[w,h]<0.51){ 
												value[w,h]=cShallowSea
											}
										}
										if (riverNoise[w,h]>=0.51){
											if (riverNoise[w,h]<=1){ 
														//temperate continent ground forrest
												if (moistNoise[w,h]>=0){
													if (moistNoise[w,h]<0.435){ 
														value[w,h]=cForrest
													}
												}
									
												//temperate continent ground grass
												if (moistNoise[w,h]>=0.435){
													if (moistNoise[w,h]<0.452){ 
														value[w,h]=cGrass
													}
												}
												//temperate continent river
												if (moistNoise[w,h]>=0.452){
													if (moistNoise[w,h]<0.458){ 
														value[w,h]=cShallowSea
													}
												}
												//temperate continent ground grass
												if (moistNoise[w,h]>=0.458){
													if (moistNoise[w,h]<0.485){ 
														value[w,h]=cGrass
													}
												}
									
												//temperate continent ground forrest
												if (moistNoise[w,h]>=0.485){
													if (moistNoise[w,h]<=1){ 
														value[w,h]=cForrest
													}
												}
											}
										}
									}
								}
							//temperate continent mountain
							if (heightNoise[w,h]>=0.55){
									if (heightNoise[w,h]<0.6){ 
									
										//temperate continent mountain river
										if (riverNoise[w,h]>=0){
											if (riverNoise[w,h]<0.5){ 
												//temperate continent mountain forrest
											if (moistNoise[w,h]>=0){
													if (moistNoise[w,h]<0.42){ 
														value[w,h]=cPine
													}
												}
									
												//temperate continent mountain
												if (moistNoise[w,h]>=0.42){
													if (moistNoise[w,h]<0.47){ 
														value[w,h]=cStone
													}
												}
									
												//temperate continent mountain forrest
												if (moistNoise[w,h]>=0.47){
													if (moistNoise[w,h]<=1){ 
														value[w,h]=cPine
													}
												}
											}
										}
										//temperate continent mountain river water
										if (riverNoise[w,h]>=0.5){
											if (riverNoise[w,h]<0.51){ 
												value[w,h]=cShallowSea
											}
										}
										//temperate continent mountain river
										if (riverNoise[w,h]>=0.51){
											if (riverNoise[w,h]<=1){ 
												//temperate continent mountain forrest
											if (moistNoise[w,h]>=0){
													if (moistNoise[w,h]<0.42){ 
														value[w,h]=cPine
													}
												}
									
												//temperate continent mountain
												if (moistNoise[w,h]>=0.42){
													if (moistNoise[w,h]<0.47){ 
														value[w,h]=cStone
													}
												}
									
												//temperate continent mountain forrest
												if (moistNoise[w,h]>=0.47){
													if (moistNoise[w,h]<=1){ 
														value[w,h]=cPine
													}
												}
											}
										}
									
								
									}
						
								}
								if (heightNoise[w,h]>=0.6){
								if (heightNoise[w,h]<0.65){ 
									//temperate continent mountain river water
										if (riverNoise[w,h]>=0){
											if (riverNoise[w,h]<0.51){ 
												value[w,h]=cStone
											}
										}
										//temperate continent mountain river water
										if (riverNoise[w,h]>=0.5){
											if (riverNoise[w,h]<0.51){ 
												value[w,h]=cShallowSea
											}
										}
										//temperate continent mountain river water
										if (riverNoise[w,h]>=0.51){
											if (riverNoise[w,h]<=1){ 
												value[w,h]=cStone
											}
										}
						
								}
							}
							}
							//temperate continent mountain top
							if (heightNoise[w,h]>=0.65){
								if (heightNoise[w,h]<=1){ 
									value[w,h]=cIce
								}
							}
						}
						//arctic continent thundra
						if (heatNoise[w,h]>=0.75){
							if (heatNoise[w,h]<0.95){ 
								//arctic continent thundra lake
								if (heightNoise[w,h]>=0){
									if (heightNoise[w,h]<0.3){ 
										value[w,h]=cIceWater
									}
								}
							//arctic continent thundra ground
								if (heightNoise[w,h]>=0.3){
									if (heightNoise[w,h]<0.55){ 
										//temperate continent mountain river water
										if (riverNoise[w,h]>=0){
											if (riverNoise[w,h]<0.5){ 
									
										//temperate continent ground pine
										if (moistNoise[w,h]>=0){
											if (moistNoise[w,h]<0.22){ 
												value[w,h]=cThundra
											}
										}
									
										//temperate continent river
												if (moistNoise[w,h]>=0.22){
													if (moistNoise[w,h]<0.23){ 
														value[w,h]=cIceWater
													}
												}
									
										//temperate continent ground pine
										if (moistNoise[w,h]>=0.23){
											if (moistNoise[w,h]<0.4){ 
												value[w,h]=cThundra
											}
										}
									
									
										//temperate continent ground thundra
										if (moistNoise[w,h]>=0.4){
											if (moistNoise[w,h]<=1){ 
												value[w,h]=cPine
											}
										}
											}
										}
										if (riverNoise[w,h]>=0.5){
											if (riverNoise[w,h]<0.51){ 
												value[w,h]=cIceWater
											}
											}
											if (riverNoise[w,h]>=0.51){
											if (riverNoise[w,h]<=1){
												//temperate continent ground pine
										//temperate continent ground pine
										if (moistNoise[w,h]>=0){
											if (moistNoise[w,h]<0.22){ 
												value[w,h]=cThundra
											}
										}
									
										//temperate continent river
												if (moistNoise[w,h]>=0.22){
													if (moistNoise[w,h]<0.23){ 
														value[w,h]=cIceWater
													}
												}
									
										//temperate continent ground pine
										if (moistNoise[w,h]>=0.23){
											if (moistNoise[w,h]<0.4){ 
												value[w,h]=cThundra
											}
										}
									
										//temperate continent ground thundra
										if (moistNoise[w,h]>=0.4){
											if (moistNoise[w,h]<=1){ 
												value[w,h]=cPine
											}
										}
												}}
									}
								}
							
							//temperate continent mountain
							if (heightNoise[w,h]>=0.55){
									if (heightNoise[w,h]<0.65){ 
										if (riverNoise[w,h]>=0){
											if (riverNoise[w,h]<=0.5){
												value[w,h]=cStone
											}}
											if (riverNoise[w,h]>=0.5){
											if (riverNoise[w,h]<0.51){
												value[w,h]=cIceWater
											}}
											if (riverNoise[w,h]>=0.51){
											if (riverNoise[w,h]<=1){
												value[w,h]=cStone
											}}
									
									}
								}
							}
							//temperate continent mountain top
							if (heightNoise[w,h]>=0.65){
								if (heightNoise[w,h]<=1){ 
									value[w,h]=cIce
								}
						
							}
						}
						//arctic continent ice
						if (heatNoise[w,h]>=0.95){
							if (heatNoise[w,h]<=1){ 
								value[w,h]=cIce
							}
						}
					}
				}
				//shallow Ocean 
				if (landNoise[w,h]>=0.45){
					if (landNoise[w,h]<0.47){ 
						//temeprate shallow ocean
						if (heatNoise[w,h]>=0){
							if (heatNoise[w,h]<0.85){ 	
							
								//temeprate shallow ocean water
								if (heightNoise[w,h]>=0){
									if (heightNoise[w,h]<0.60){ 	
										value[w,h]=cShallowSea
									}
								}
								//temeprate shallow ocean mountain
								if (heightNoise[w,h]>=0.60){
									if (heightNoise[w,h]<0.75){ 	
										value[w,h]=cStone
									}
								}
							
								//temeprate shallow ocean mountain top
								if (heightNoise[w,h]>=0.75){
									if (heightNoise[w,h]<=1){ 	
										value[w,h]=cIce
									}
								}
						
									
				
						
						
							}
						}
					
						//arctic shallow ocean ice water
						if (heatNoise[w,h]>=0.85){
							if (heatNoise[w,h]<=1){ 
								//temeprate shallow ocean water
								if (heightNoise[w,h]>=0){
									if (heightNoise[w,h]<0.60){ 	
										value[w,h]=cIceWater
									}
								}
								//arctic shallow ocean mountain
								if (heightNoise[w,h]>=0.60){
									if (heightNoise[w,h]<0.75){ 	
										value[w,h]=cIce
									}
								}
							
								//arctic shallow ocean mountain top
								if (heightNoise[w,h]>=0.75){
									if (heightNoise[w,h]<=1){ 	
										value[w,h]=cIce
									}
								}
							}
						}
					
					}
				}
				//deep ocean
				if (landNoise[w,h]>=0.47){
					if (landNoise[w,h]<=1){
						//tropical deep ocean 
						if (heatNoise[w,h]>=0){
							if (heatNoise[w,h]<0.4){ 
								//tropical deep ocean water
								if (heightNoise[w,h]>=0){
									if (heightNoise[w,h]<=0.65){ 
										value[w,h]=cDeepSea
									}
								}
								//tropical deep ocean island shallow water
								if (heightNoise[w,h]>=0.65){
									if (heightNoise[w,h]<0.7){ 
										value[w,h]=cShallowSea	
									}
								}
								//tropical deep ocean island
								if (heightNoise[w,h]>=0.7){
									if (heightNoise[w,h]<=1){ 
										if (riverNoise[w,h]>=0){
											if (riverNoise[w,h]<0.5){ 
												//tropical continent ground jungle
												if (moistNoise[w,h]>=0){
													if (moistNoise[w,h]<0.51){ 
														value[w,h]=cJungle
													}
												}
											
												//tropical continent ground savanah
									
												if (moistNoise[w,h]>=0.51){
													if (moistNoise[w,h]<=0.55){ 
														value[w,h]=cSavanah
													}
												}
									
												//tropical continent ground sand
									
												if (moistNoise[w,h]>=0.55){
													if (moistNoise[w,h]<=1){ 
														value[w,h]=cSand
													}
												}
											}
										}
										//tropical continent river bank
										if (riverNoise[w,h]>=0){
											if (riverNoise[w,h]<=0.5){ 
												//tropical continent ground jungle
												if (moistNoise[w,h]>=0){
													if (moistNoise[w,h]<0.51){ 
														value[w,h]=cSand
													}
												}
											
												//tropical continent ground savanah
									
												if (moistNoise[w,h]>=0.51){
													if (moistNoise[w,h]<=0.55){ 
														value[w,h]=cSavanah
													}
												}
									
												//tropical continent ground sand
									
												if (moistNoise[w,h]>=0.55){
													if (moistNoise[w,h]<=1){ 
														value[w,h]=cJungle
													}
												}
											}
										}
										//tropical continent river
										if (riverNoise[w,h]>=0.5){
											if (riverNoise[w,h]<0.51){ 
												value[w,h]=cShallowSea
											}
										}
										//tropical continent river bank
										if (riverNoise[w,h]>=0.51){
											if (riverNoise[w,h]<=1){ 
												//tropical continent ground jungle
												if (moistNoise[w,h]>=0){
													if (moistNoise[w,h]<0.51){ 
														value[w,h]=cSand
													}
												}
											
												//tropical continent ground savanah
									
												if (moistNoise[w,h]>=0.51){
													if (moistNoise[w,h]<=0.55){ 
														value[w,h]=cSavanah
													}
												}
									
												//tropical continent ground sand
									
												if (moistNoise[w,h]>=0.55){
													if (moistNoise[w,h]<=1){ 
														value[w,h]=cJungle
													}
												}
											}
										}
									}
								}
							}
						}
						//temperate deep ocean
						if (heatNoise[w,h]>=0.4){
							if (heatNoise[w,h]<0.75){ 					
								value[w,h]=cDeepSea
							}
						}
						//arctic deep ocean
						if (heatNoise[w,h]>=0.75){
							if (heatNoise[w,h]<0.95){ 					
							
							
							
							
								//tropical deep ocean water
								if (heightNoise[w,h]>=0){
									if (heightNoise[w,h]<=0.65){ 
										value[w,h]=cDeepSea
									}
								}
								//tropical deep ocean island shallow water
								if (heightNoise[w,h]>=0.65){
									if (heightNoise[w,h]<0.7){ 
										value[w,h]=cShallowSea	
									}
								}
								//tropical deep ocean island
								if (heightNoise[w,h]>=0.7){
									if (heightNoise[w,h]<=1){ 
									
								//temperate continent mountain river water
										if (riverNoise[w,h]>=0){
											if (riverNoise[w,h]<0.5){ 
									
										//temperate continent ground pine
										if (moistNoise[w,h]>=0){
											if (moistNoise[w,h]<0.22){ 
												value[w,h]=cThundra
											}
										}
									
										//temperate continent river
												if (moistNoise[w,h]>=0.22){
													if (moistNoise[w,h]<0.23){ 
														value[w,h]=cIceWater
													}
												}
									
										//temperate continent ground pine
										if (moistNoise[w,h]>=0.23){
											if (moistNoise[w,h]<0.4){ 
												value[w,h]=cThundra
											}
										}
									
									
										//temperate continent ground thundra
										if (moistNoise[w,h]>=0.4){
											if (moistNoise[w,h]<=1){ 
												value[w,h]=cPine
											}
										}
											}
										}
										if (riverNoise[w,h]>=0.5){
											if (riverNoise[w,h]<0.51){ 
												value[w,h]=cIceWater
											}
											}
											if (riverNoise[w,h]>=0.51){
											if (riverNoise[w,h]<=1){
												//temperate continent ground pine
										//temperate continent ground pine
										if (moistNoise[w,h]>=0){
											if (moistNoise[w,h]<0.22){ 
												value[w,h]=cThundra
											}
										}
									
										//temperate continent river
												if (moistNoise[w,h]>=0.22){
													if (moistNoise[w,h]<0.23){ 
														value[w,h]=cIceWater
													}
												}
									
										//temperate continent ground pine
										if (moistNoise[w,h]>=0.23){
											if (moistNoise[w,h]<0.4){ 
												value[w,h]=cThundra
											}
										}
									
										//temperate continent ground thundra
										if (moistNoise[w,h]>=0.4){
											if (moistNoise[w,h]<=1){ 
												value[w,h]=cPine
											}
										}
												}}
									}
								}
							
							
							
							}
						}
						//frozen deep ocean
						if (heatNoise[w,h]>=0.95){
							if (heatNoise[w,h]<=1){ 
								if (heightNoise[w,h]>=0){
									if (heightNoise[w,h]<0.7){ 
										value[w,h]=cIceWater
									}
								}
								if (heightNoise[w,h]>=0.7){
									if (heightNoise[w,h]<=1){ 
										//temperate deep ocean island
										if (heightNoise[w,h]>=0.7){
											if (heightNoise[w,h]<=1){ 
												//temperate continent ground river
												if (riverNoise[w,h]>=0){
													if (riverNoise[w,h]<0.5){ 
									
												
																value[w,h]=cIce
													
													}
												}
												//temperate continent river
												if (riverNoise[w,h]>=0.5){
													if (riverNoise[w,h]<0.51){ 
														value[w,h]=cIceWater
													}
												}
												if (riverNoise[w,h]>=0.51){
													if (riverNoise[w,h]<=1){ 
													value[w,h]=cIce
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
		}
	}
#endregion

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

	for(var w=0; w<=size; w++){
		for(var h=0; h<=size; h++){
			//randomize()
			vx=w*32
			vy=h*32
		
			if(value[w,h]==cDeepSea)	{tx=choose(t[0],t[1],t[2],t[3],t[4],t[5],t[6],t[7],t[8],t[9],t[10],t[11],t[12],t[13],t[14],t[15])			ty=t[0] }
			if(value[w,h]==cShallowSea)	{tx=choose(t[0],t[1],t[2],t[3],t[4],t[5],t[6],t[7],t[8],t[9],t[10],t[11],t[12],t[13],t[14],t[15])			ty=t[1] }
			if(value[w,h]==cGrass)		{tx=choose(t[0],t[1],t[2],t[3],t[4],t[5],t[6],t[7],t[8],t[9],t[10],t[11],t[12],t[13],t[14],t[15])			ty=t[2] }
			if(value[w,h]==cIce)		{tx=choose(t[0],t[1],t[2],t[3],t[4],t[5],t[6],t[7],t[8],t[9],t[10],t[11],t[12],t[13],t[14],t[15])			ty=t[3] }
			if(value[w,h]==cSand)		{tx=choose(t[0],t[1],t[2],t[3],t[4],t[5],t[6],t[7],t[8],t[9],t[10],t[11],t[12],t[13],t[14],t[15])			ty=t[4] }
			if(value[w,h]==cStone)		{tx=choose(t[0],t[1],t[2],t[3],t[4],t[5],t[6],t[7],t[8],t[9],t[10],t[11],t[12],t[13],t[14],t[15])			ty=t[5] }
			if(value[w,h]==cIceWater)	{tx=choose(t[0],t[1],t[2],t[3],t[4],t[5],t[6],t[7],t[8],t[9],t[10],t[11],t[12],t[13],t[14],t[15])			ty=t[6] }
			if(value[w,h]==cThundra)	{tx=choose(t[0],t[1],t[2],t[3],t[4],t[5],t[6],t[7],t[8],t[9],t[10],t[11],t[12],t[13],t[14],t[15])			ty=t[7] }
			if(value[w,h]==cForrest)	{tx=choose(t[0],t[1],t[2],t[3],t[4],t[5],t[6],t[7],t[8],t[9],t[10],t[11],t[12],t[13],t[14],t[15])			ty=t[8] }
			if(value[w,h]==cJungle)		{tx=choose(t[0],t[1],t[2],t[3],t[4],t[5],t[6],t[7],t[8],t[9],t[10],t[11],t[12],t[13],t[14],t[15])			ty=t[9] }
			if(value[w,h]==cPine)		{tx=choose(t[0],t[1],t[2],t[3],t[4],t[5],t[6],t[7],t[8],t[9],t[10],t[11],t[12],t[13],t[14],t[15])			ty=t[10] }
			if(value[w,h]==cSwamp)		{tx=choose(t[0],t[1],t[2],t[3],t[4],t[5],t[6],t[7],t[8],t[9],t[10],t[11],t[12],t[13],t[14],t[15])			ty=t[11] }
			if(value[w,h]==cSavanah)	{tx=choose(t[0],t[1],t[2],t[3],t[4],t[5],t[6],t[7],t[8],t[9],t[10],t[11],t[12],t[13],t[14],t[15])			ty=t[12] }
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
