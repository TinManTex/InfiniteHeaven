local this = {}	
	
this.presets = {	
hair={	
	{ 0, 255,2,255,0,1, },
	{ 1, 1,4,255,0,2, },
	{ 2, 0,2,255,0,2, },
	{ 3, 2,2,255,0,2, },
	{ 4, 0,0,255,0,1, },
	{ 5, 255,0,2,0,2, },
	{ 6, 0,3,0,0,2, },
	{ 7, 0,2,4,0,2, },
	{ 8, 0,2,255,0,0, },
	{ 9,2,6,255,0,2, },
	{ 10, 0,0,255,0,2, },
	{ 11,0,5,255,0,2, },
	{ 12, 2,4,0,0,1, },
	{ 13, 1,3,3,0,2, },
	{ 14, 0,4,2,0,2, },
	{ 15, 2,0,255,1,2, },
	{ 16, 255,10,0,2,1, },
	{ 17, 1,1,0,1,2, },
	{ 18, 255,10,3,2,2, },
	{ 19, 0,0,0,2,2, },
	{ 20, 255,2,1,2,3, },
	{ 21, 255,3,255,0,2, },
	{ 22, 0,4,0,0,3, },
	{ 23, 255,0,0,0,1, },
	{ 24, 0,4,255,0,2, },
	{ 25, 1,2,1,2,2, },
	{ 26, 0,4,255,0,2, },
	{ 27, 0,0,3,0,1, },
	
},	
head={	
	{ 0, 5,5,6,4,5,5,5, },
	{ 1, 0,0,7,10,6,6,5, },
	{ 2, 0,0,8,5,10,7,9, },
	{ 3, 0,0,5,10,8,10,8, },
	{ 4, 10,8,4,0,0,2,0, },
	{ 5, 5,5,0,2,4,8,4, },
	{ 6, 5,0,6,0,0,3,1, },
	{ 7, 4,3,0,2,0,10,0, },
	{ 8, 1,0,0,10,0,10,0, },
	{ 9, 0,5,10,7,10,5,6, },
	{ 10, 4,0,7,6,9,7,4, },
	{ 11, 4,0,0,5,0,3,4, },
	{ 12, 0,0,4,8,0,10,1, },
	{ 13, 0,0,1,5,7,10,8, },
	{ 14, 1,2,8,7,0,8,4, },
	{ 15, 10,9,8,0,0,5,5, },
	{ 16, 10,0,10,4,10,4,7, },
	{ 17, 1,0,10,4,9,10,10, },
	{ 18, 0,5,6,0,5,6,0, },
	{ 19, 8,5,7,0,10,8,6, },
	{ 20, 0,6,7,3,10,5,3, },
	{ 21, 5,9,6,5,4,7,5, },
	{ 22, 8,0,5,1,8,4,4, },
	{ 23, 6,2,0,2,1,10,8, },
	{ 24, 10,10,10,10,3,0,3, },
	{ 25, 1,0,6,10,0,0,3, },
	{ 26, 0,0,10,10,0,10,10, },
	{ 27, 6,0,1,10,0,10,4, },
	
},	
eye={	
	{ 0, 5,5,4,10,8,4,3,0,0,0,0, },
	{ 1, 0,1,4,5,5,6,10,2,1,2,1, },
	{ 2, 2,0,5,8,10,1,0,2,1,2,1, },
	{ 3, 2,6,3,6,6,3,10,5,0,5,0, },
	{ 4, 1,5,5,8,10,1,0,5,0,5,0, },
	{ 5, 5,1,4,4,10,4,5,2,1,2,1, },
	{ 6, 4,8,6,10,1,4,4,2,1,2,1, },
	{ 7, 2,3,2,7,0,3,10,2,1,2,1, },
	{ 8, 7,3,0,5,6,0,5,0,0,0,0, },
	{ 9, 3,4,0,9,2,4,0,2,1,2,0, },
	{ 10, 0,0,4,10,4,1,0,2,1,2,1, },
	{ 11, 0,0,3,0,5,0,0,2,1,2,1, },
	{ 12, 4,0,0,0,8,2,0,5,0,5,0, },
	{ 13, 5,10,7,3,1,0,10,2,1,2,1, },
	{ 14, 6,6,6,7,4,0,3,2,1,2,1, },
	{ 15, 3,8,8,5,0,7,0,2,0,2,0, },
	{ 16, 1,10,0,0,0,9,10,5,0,7,0, },
	{ 17 ,2,10,8,0,10,10,10,2,1,2,1, },
	{ 18, 1,5,5,7,0,2,0,2,1,2,1, },
	{ 19, 0,9,9,10,3,0,0,5,0,5,0, },
	{ 20, 1,10,3,10,0,3,0,3,1,3,1, },
	{ 21, 3,4,5,7,6,9,5,2,1,2,1, },
	{ 22, 4,10,2,10,0,2,10,2,0,2,0, },
	{ 23, 4,10,10,0,0,8,0,5,1,5,1, },
	{ 24, 5,5,0,6,7,3,0,2,0,2,0, },
	{ 25, 3,2,10,0,0,2,10,2,1,2,1, },
	{ 26, 7,0,0,10,8,4,0,2,1,2,1, },
	{ 27, 4,6,4,0,2,7,0,5,0,5,0, },
	
},	
nose={	
	{ 0, 2,7,5,0,4,4,5,0,10,5,2, },
	{ 1, 0,3,1,10,6,10,9,0,10,10,9, },
	{ 2, 0,2,5,9,0,10,7,0,8,9,2, },
	{ 3, 0,4,9,3,1,10,4,0,10,9,4, },
	{ 4, 0,5,5,7,8,5,5,0,9,5,1, },
	{ 5, 0,0,10,10,2,10,6,0,7,10,9, },
	{ 6, 1,4,5,6,5,7,5,0,8,6,2, },
	{ 7, 0,5,7,5,6,7,2,0,10,7,1, },
	{ 8, 2,4,4,6,6,9,6,10,8,5,0, },
	{ 9, 0,1,3,0,2,5,5,0,10,10,8, },
	{ 10, 3,2,1,5,6,8,5,0,5,7,0, },
	{ 11, 0,4,2,3,8,2,8,0,10,7,0, },
	{ 12, 1,3,9,10,1,10,5,0,10,5,5, },
	{ 13, 10,4,4,9,7,10,4,0,5,1,9, },
	{ 14, 0,1,0,0,3,4,8,6,9,8,4, },
	{ 15, 0,5,5,10,5,10,4,0,10,7,5, },
	{ 16, 1,3,10,0,10,10,0,0,8,10,4, },
	{ 17, 3,1,6,10,10,10,2,0,10,10,10, },
	{ 18, 0,1,5,4,1,5,5,0,5,10,3, },
	{ 19, 0,4,4,10,8,10,5,0,4,10,3, },
	{ 20, 3,10,8,6,8,10,0,0,10,6,7, },
	{ 21, 5,1,3,1,2,2,5,0,8,6,10, },
	{ 22, 0,3,0,7,5,10,3,0,10,10,4, },
	{ 23, 0,1,1,10,9,10,9,0,7,6,7, },
	{ 24, 0,3,3,10,5,4,2,0,10,10,0, },
	{ 25, 3,3,0,0,5,10,7,7,10,10,10, },
	{ 26, 0,0,0,0,0,10,9,5,10,10,0, },
	{ 27, 0,3,8,2,6,3,1,0,9,10,6, },
	
},	
cheek={	
	{ 0, 6,8,2,10,3,10, },
	{ 1, 7,4,7,7,3,0, },
	{ 2, 10,10,2,6,5,7, },
	{ 3, 10,9,6,5,2,5, },
	{ 4, 6,7,0,10,2,6, },
	{ 5, 10,9,6,5,2,5, },
	{ 6, 8,5,5,2,4,6, },
	{ 7, 9,0,7,10,0,10, },
	{ 8, 9,3,3,5,0,5, },
	{ 9, 8,0,10,7,7,6, },
	{ 10, 3,0,7,9,5,3, },
	{ 11, 3,8,5,4,0,9, },
	{ 12, 0,8,6,0,2,8, },
	{ 13, 3,7,0,10,0,8, },
	{ 14, 10,10,0,7,5,9, },
	{ 15, 10,7,4,7,3,7, },
	{ 16, 10,10,10,10,10,10, },
	{ 17, 8,8,10,8,6,9, },
	{ 18, 9,6,10,6,5,7, },
	{ 19, 10,10,6,10,1,4, },
	{ 20, 0,10,5,8,10,2, },
	{ 21, 10,9,6,5,2,5, },
	{ 22, 4,8,6,10,10,9, },
	{ 23, 10,9,6,5,2,5, },
	{ 24, 10,10,10,0,10,10, },
	{ 25, 9,0,9,10,10,2, },
	{ 26, 7,10,10,0,10,10, },
	{ 27, 2,7,0,9,3,1, },
	
},	
mouth={	
	{ 0, 10,8,4,3,3,5,7, },
	{ 1, 10,10,9,3,9,7,8, },
	{ 2, 9,2,4,5,2,6,9, },
	{ 3, 10,10,6,4,3,1,4, },
	{ 4, 9,1,1,6,5,5,10, },
	{ 5, 5,6,10,2,10,1,0, },
	{ 6, 7,7,6,2,4,1,0, },
	{ 7, 10,5,1,5,1,5,0, },
	{ 8,10,10,6,8,0,10,4, },
	{ 9, 10,6,6,10,5,10,4, },
	{ 10, 10,8,6,9,0,6,5, },
	{ 11, 10,5,3,5,0,10,9, },
	{ 12, 6,7,6,3,7,10,1, },
	{ 13, 2,10,10,0,10,10,1, },
	{ 14, 8,7,4,3,3,10,10, },
	{ 15, 5,5,5,5,5,8,10, },
	{ 16, 10,9,4,0,8,10,10, },
	{ 17, 5,10,8,0,9,10,10, },
	{ 18, 5,5,2,5,1,9,4, },
	{ 19, 9,8,4,0,10,8,0, },
	{ 20, 9,5,0,8,5,4,0, },
	{ 21, 5,5,7,5,8,1,10, },
	{ 22, 10,3,2,0,6,1,10, },
	{ 23, 0,5,1,0,8,10,10, },
	{ 24, 10,4,5,8,1,10,8, },
	{ 25, 3,6,10,6,3,8,2, },
	{ 26, 7,2,1,10,0,0,5, },
	{ 27, 7,3,0,9,9,1,1, },
	
},	
chin={	
	{ 0, 5,3,7,3,5,2,0,8,4,5,7,5, },
	{ 1, 4,4,5,3,10,5,10,10,8,5,3,6, },
	{ 2, 9,5,8,0,4,4,0,6,6,5,5,5, },
	{ 3, 7,6,6,5,10,5,0,8,8,5,5,0, },
	{ 4, 6,4,8,5,8,0,0,5,5,5,5,10, },
	{ 5, 5,5,5,4,7,3,4,10,4,5,5,5 },
	{ 6, 6,4,5,2,9,0,1,8,7,5,5,5, },
	{ 7, 8,6,3,5,4,5,0,8,10,7,7,2, },
	{ 8, 8,3,7,6,9,0,2,5,10,5,3,10, },
	{ 9, 5,3,6,0,10,0,10,10,5,5,5,6, },
	{ 10, 9,5,9,2,7,1,1,2,10,5,4,0, },
	{ 11, 9,5,10,0,4,2,0,3,5,5,4,10, },
	{ 12, 1,3,1,9,5,7,8,6,6,5,7,5, },
	{ 13, 7,10,2,3,1,5,8,3,0,3,5,0, },
	{ 14, 2,2,5,7,4,6,2,5,8,6,8,3, },
	{ 15, 1,0,2,6,9,6,0,5,5,5,5,10, },
	{ 16, 0,10,5,10,5,9,10,9,0,5,10,0, },
	{ 17, 0,10,4,0,0,10,10,9,0,9,10,0, },
	{ 18, 4,8,5,5,5,5,0,5,5,5,5,5, },
	{ 19, 0,8,6,8,10,5,10,8,4,5,6,6, },
	{ 20, 4,5,6,8,10,3,2,5,6,5,5,5, },
	{ 21, 5,5,5,4,7,3,4,10,4,5,5,5, },
	{ 22, 0,4,3,6,10,6,1,2,6,4,10,0, },
	{ 23, 0,2,0,10,0,7,4,4,0,2,9,5, },
	{ 24, 0,4,4,4,7,10,10,8,4,8,10,3, },
	{ 25, 5,0,4,0,6,5,0,10,0,8,6,0, },
	{ 26, 10,10,5,0,3,10,8,0,10,6,10,10, },
	{ 27, 1,4,5,9,8,8,0,3,7,5,6,5, },
	
},	
skincolor={	
	{ 0, 0,0, },
	{ 1, 3,1, },
	{ 2, 1,5, },
	{ 3, 2,0, },
	{ 4, 0,6, },
	{ 5, 4,6, },
	{ 6, 1,6, },
	{ 7, 2,0, },
	{ 8, 0,1, },
	{ 9, 3,1, },
	{ 10, 1,4, },
	{ 11, 2,1, },
	{ 12, 0,6, },
	{ 13, 4,6, },
	{ 14, 1,5, },
	{ 15, 2,7, },
	{ 16, 0,7, },
	{ 17, 3,0, },
	{ 18, 1,7, },
	{ 19, 2,7, },
	{ 20, 0,2, },
	{ 21, 4,2, },
	{ 22, 1,2, },
	{ 23, 2,2, },
	{ 24, 0,1, },
	{ 25, 3,3, },
	{ 26, 1,1, },
	{ 27, 2,1, },
	
},	
deco={	
	{ 0, 255,0,0, },
	{ 1, 255,0,0, },
	{ 2, 255,0,0, },
	{ 3, 255,0,0, },
	{ 4, 255,0,0, },
	{ 5, 255,0,0, },
	{ 6, 255,5,0, },
	{ 7, 255,0,0, },
	{ 8, 255,0,0, },
	{ 9, 255,0,0, },
	{ 10, 255,0,0, },
	{ 11, 255,0,0, },
	{ 12, 2,0,0, },
	{ 13, 1,3,0, },
	{ 14, 255,0,0, },
	{ 15, 1,2,0, },
	{ 16, 0,0,0, },
	{ 17, 1,7,0, },
	{ 18, 0,3,0, },
	{ 19, 0,4,0, },
	{ 20, 0,1,0, },
	{ 21, 255,0,0, },
	{ 22, 255,0,0, },
	{ 23, 255,0,0, },
	{ 24, 255,0,0, },
	{ 25, 255,0,0, },
	{ 26, 255,0,0, },
	{ 27, 255,0,0, },
	
},	
base={	
	{ 0, 0,0, 0,0,0,0,0,0,0,0,0, },
	{ 1, 0,3, 1,1,1,1,1,1,1,1,1, },
	{ 2, 0,5, 2,2,2,2,2,2,2,2,2, },
	{ 3, 0,0, 3,3,3,3,3,3,3,3,3, },
	{ 4, 0,6, 4,4,4,4,4,4,4,4,4, },
	{ 5, 0,1, 5,5,5,5,5,5,5,5,5, },
	{ 6, 0,6, 6,6,6,6,6,6,6,6,6, },
	{ 7, 0,0, 7,7,7,7,7,7,7,7,7, },
	{ 8, 0,1, 8,8,8,8,8,8,8,8,8, },
	{ 9, 0,1, 9,9,9,9,9,9,9,9,9, },
	{ 10, 0,4, 10,10,10,10,10,10,10,10,10, },
	{ 11, 0,6, 11,11,11,11,11,11,11,11,11, },
	{ 12, 0,6, 12,12,12,12,12,12,12,12,12, },
	{ 13, 0,6, 13,13,13,13,13,13,13,13,13, },
	{ 14, 0,5, 14,14,14,14,14,14,14,14,14, },
	{ 15, 0,7, 15,15,15,15,15,15,15,15,15, },
	{ 16, 0,7, 16,16,16,16,16,16,16,16,16, },
	{ 17, 0,1, 17,17,17,17,17,17,17,17,17, },
	{ 18, 0,7, 18,18,18,18,18,18,18,18,18, },
	{ 19, 0,7, 19,19,19,19,19,19,19,19,19, },
	{ 20, 0,2, 20,20,20,20,20,20,20,20,20, },
	{ 21, 0,2, 21,21,21,21,21,21,21,21,21, },
	{ 22, 0,2, 22,22,22,22,22,22,22,22,22, },
	{ 23, 0,2, 23,23,23,23,23,23,23,23,23, },
	{ 24, 0,1, 24,24,24,24,24,24,24,24,24, },
	{ 25, 0,3, 25,25,25,25,25,25,25,25,25, },
	{ 26, 0,1, 26,26,26,26,26,26,26,26,26, },
	{ 27, 0,1, 27,27,27,27,27,27,27,27,27, },
	
},	
}	
return this	
