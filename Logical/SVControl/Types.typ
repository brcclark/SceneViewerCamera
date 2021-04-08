
TYPE
	MoveType_enum : 
		(
		LINEAR,
		RADIAL
		);
	Binding_typ : 	STRUCT 
		Camera : SceneViewCamera_typ;
		FocalPoint : SceneViewCoord_typ;
		FocalPointVisible : BOOL;
	END_STRUCT;
	Vis_typ : 	STRUCT 
		Controls : Controls_typ;
		Bind : Binding_typ;
	END_STRUCT;
	LinearControls_typ : 	STRUCT 
		XBtnPos : USINT;
		XBtnNeg : USINT;
		YBtnPos : USINT;
		YBtnNeg : USINT;
		Y : REAL;
		X : REAL;
	END_STRUCT;
	CircularControls_typ : 	STRUCT 
		RadiusBtnNeg : USINT;
		RadiusBtnPos : USINT;
		Angle : REAL;
		Radius : REAL;
	END_STRUCT;
	Controls_typ : 	STRUCT 
		FocalPoint : FocalPointControls_typ;
		Fov : REAL;
		Z : REAL;
		Circular : CircularControls_typ;
		Linear : LinearControls_typ;
		SavePointA : BOOL;
		MoveType : USINT;
		NewMove : BOOL;
		Start : BOOL;
		Load : BOOL;
		Save : BOOL;
		SelectedMove : USINT;
		MoveMode : MoveType_enum;
		TimeInput : REAL;
		ActiveMoveTravelTime : TIME;
		ActiveMoveElapsedTime : TIME;
	END_STRUCT;
	FocalPointControls_typ : 	STRUCT 
		XBtnPos : USINT;
		XBtnNeg : USINT;
		YBtnPos : USINT;
		YBtnNeg : USINT;
		ZBtnPos : USINT;
		ZBtnNeg : USINT;
		Visible : BOOL;
	END_STRUCT;
	Move_typ : 	STRUCT 
		IsSaved : BOOL;
		MoveType : MoveType_enum;
		Point : SceneViewCamera_typ;
		FocalPoint : SceneViewCoord_typ;
		TravelTime : TIME;
	END_STRUCT;
	State_enum : 
		(
		MOVE_SETTINGS,
		NEW_MOVE,
		UPDATE_LIST,
		REBUILD_LIST,
		NEW_MOVE_SAVE,
		SAVE_MOVE,
		LOAD_MOVE,
		START_MOVE,
		LINEAR_MOVE,
		WAIT_FOR_LINEAR_MOVE_DONE,
		RADIAL_MOVE,
		WAIT_FOR_RADIAL_MOVE_DONE,
		MOVE_COMPLETE,
		SAVE_LOAD_RECIPE,
		WAIT_FOR_STOP
		);
	RecipeCtrlTyp : 	STRUCT 
		Cmd : RecipeCtrlCmdTyp;
		Par : RecipeCtrlParTyp;
		Sts : RecipeCtrlStsTyp;
	END_STRUCT;
	RecipeCtrlCmdTyp : 	STRUCT 
		Save : BOOL;
		Load : BOOL;
	END_STRUCT;
	RecipeCtrlParTyp : 	STRUCT 
		FileName : STRING[80];
	END_STRUCT;
	RecipeCtrlStsTyp : 	STRUCT 
		LastLoadedRecipe : STRING[80];
	END_STRUCT;
END_TYPE
