
TYPE
	SceneViewCoord_typ : 	STRUCT 
		X : REAL;
		Y : REAL;
		Z : REAL;
	END_STRUCT;
	SceneViewCamera_typ : 	STRUCT 
		Perspective : BOOL;
		Zoom : REAL;
		Fov : REAL;
		ViewPoint : SceneViewCoord_typ;
		ViewVector : SceneViewCoord_typ;
		OrientationVector : SceneViewCoord_typ;
	END_STRUCT;
END_TYPE
