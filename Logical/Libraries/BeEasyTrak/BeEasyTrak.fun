
{REDUND_ERROR} FUNCTION_BLOCK BE_TrgPoint (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		ProcessPoint : REFERENCE TO McProcessPointType;
		Enable : BOOL;
	END_VAR
	VAR_OUTPUT
		ShuttleAxis : McAxisType;
		Triggered : BOOL;
	END_VAR
	VAR
		State : USINT;
		TrgPoint : TrgPoint_typ;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} FUNCTION_BLOCK BE_SimStartup (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Assembly : REFERENCE TO McAssemblyType;
		Sector : REFERENCE TO McSectorType;
		Execute : BOOL;
	END_VAR
	VAR_OUTPUT
		ShuttleAxisArray : ARRAY[1..MAX_SHUTTLES] OF McAxisType;
		Done : BOOL;
	END_VAR
	VAR
		AsmReadInfo : MC_BR_AsmReadInfo_AcpTrak;
		AddShuttle : MC_BR_SecAddShuttle_AcpTrak;
		ElasticMoveVel : MC_BR_ElasticMoveVel_AcpTrak;
		State : USINT;
		i : USINT := 1;
		zzEdge00000 : BOOL;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} FUNCTION_BLOCK BE_Rate (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		ProcessPoint : REFERENCE TO McProcessPointType;
		Enable : BOOL;
	END_VAR
	VAR_OUTPUT
		PPM : UINT;
		PPM_Instant : REAL;
		PPH : UINT;
		PPH_Instant : REAL;
	END_VAR
	VAR
		Counter : UINT;
		State : USINT;
		TrgPoint : BE_TrgPoint;
		TON_InstantRate : TON;
		TON_PPM : TON;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} FUNCTION_BLOCK BE_FindShuttles (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Assembly : REFERENCE TO USINT;
		Execute : {REDUND_UNREPLICABLE} BOOL;
	END_VAR
	VAR_OUTPUT
		NumShuttlesFound : UINT;
		ShuttleAxisArray : ARRAY[1..MAX_SHUTTLES] OF McAxisType;
		Done : {REDUND_UNREPLICABLE} BOOL;
		Error : BOOL;
		Busy : BOOL;
	END_VAR
	VAR
		i : USINT;
		AsmGetShuttle : MC_BR_AsmGetShuttle_AcpTrak;
		State : USINT;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} FUNCTION_BLOCK BE_MoveOnSector (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Execute : {REDUND_UNREPLICABLE} BOOL;
		Sector : REFERENCE TO McSectorType;
		Velocity : REAL;
		Acceleration : REAL;
		Deceleration : REAL;
		AxisArray : ARRAY[1..MAX_SHUTTLES] OF McAxisType;
		Assembly : REFERENCE TO McAssemblyType;
	END_VAR
	VAR_OUTPUT
		NumShuttles : UINT;
		Done : {REDUND_UNREPLICABLE} BOOL;
	END_VAR
	VAR
		RoutedMoveVel : MC_BR_RoutedMoveVel_AcpTrak;
		AsmGetShuttle : MC_BR_AsmGetShuttle_AcpTrak;
		i : UINT;
		State : USINT;
		zzEdge00000 : BOOL;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} FUNCTION_BLOCK BE_AsmStop (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Execute : {REDUND_UNREPLICABLE} BOOL;
		AxisArray : {REDUND_UNREPLICABLE} ARRAY[1..MAX_SHUTTLES] OF McAxisType;
		Deceleration : REAL;
		NumShuttles : UINT;
	END_VAR
	VAR_OUTPUT
		Done : {REDUND_UNREPLICABLE} BOOL;
	END_VAR
	VAR
		State : USINT;
		Stop : MC_Stop;
		i : UINT;
	END_VAR
END_FUNCTION_BLOCK
