
TYPE
	Barrier_typ : 	STRUCT 
		BarrierReadInfo : MC_BR_BarrierReadInfo_AcpTrak;
		BarrierCommand : MC_BR_BarrierCommand_AcpTrak;
	END_STRUCT;
	TrgPoint_typ : 	STRUCT 
		TrgPointGetInfo : MC_BR_TrgPointGetInfo_AcpTrak;
		TrgPointEnable : MC_BR_TrgPointEnable_AcpTrak;
	END_STRUCT;
	ShuttleUserData_typ : 	STRUCT 
		Color : Color_enum;
	END_STRUCT;
	Color_enum : 
		(
		GRAY := 0,
		GREEN := 1,
		BLUE := 2,
		RED := 3,
		ORANGE := 4,
		YELLOW,
		WHITE
		);
END_TYPE
