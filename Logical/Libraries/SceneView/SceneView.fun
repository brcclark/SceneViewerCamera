
{REDUND_ERROR} FUNCTION_BLOCK SV_BE_MoveView (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Execute : BOOL;
		PointA : SceneViewCamera_typ;
		PointB : SceneViewCamera_typ;
		TravelTime : TIME;
	END_VAR
	VAR_OUTPUT
		Error : BOOL;
		Done : BOOL;
		SceneViewPos : SceneViewCamera_typ;
	END_VAR
	VAR
		TON_ViewChange : TON;
		State : USINT;
		ChangeRate : SceneViewCamera_typ;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} FUNCTION_BLOCK SV_BE_FocalPointMove (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		FocalPointA : SceneViewCoord_typ;
		FocalPointB : SceneViewCoord_typ;
		Execute : BOOL;
		PointA : SceneViewCamera_typ;
		PointB : SceneViewCamera_typ;
		TravelTime : TIME;
	END_VAR
	VAR_OUTPUT
		Error : BOOL;
		Done : BOOL;
		FocalPointPos : SceneViewCoord_typ;
		SceneViewPos : SceneViewCamera_typ;
	END_VAR
	VAR
		TON_ViewChange : TON;
		State : USINT;
		FocalPointChangeRate : SceneViewCoord_typ;
		ChangeRate : SceneViewCamera_typ;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} FUNCTION_BLOCK SV_BE_RadialMove
	VAR_INPUT
		FocalPointA : SceneViewCoord_typ;
		FocalPointB : SceneViewCoord_typ;
		Execute : BOOL;
		PointA : SceneViewCamera_typ;
		PointB : SceneViewCamera_typ;
		TravelTime : TIME;
	END_VAR
	VAR_OUTPUT
		Error : BOOL;
		Done : BOOL;
		FocalPointPos : SceneViewCoord_typ;
		SceneViewPos : SceneViewCamera_typ;
	END_VAR
	VAR
		FocalPointChangeRate : SceneViewCoord_typ;
		TON_ViewChange : TON;
		State : USINT;
		ChangeRate : SceneViewCamera_typ;
		RadiusA : REAL;
		RadiusB : REAL;
		RadiusChangeRate : REAL;
		OutputRadius : REAL;
		AngleA : REAL;
		AngleB : REAL;
		AngleChangeRate : REAL;
		OutputAngle : REAL;
	END_VAR
END_FUNCTION_BLOCK
