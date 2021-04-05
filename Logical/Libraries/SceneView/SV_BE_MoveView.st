
(* TODO: Add your comment here *)
FUNCTION_BLOCK SV_BE_MoveView
	IF Error THEN
		State := 50;
	ELSIF NOT Execute THEN
		State := 0;
	END_IF
	
	
	CASE State OF
		0:
			Done := FALSE;
			TON_ViewChange.IN := FALSE;
			
			IF Execute THEN
				IF TIME_TO_REAL(TravelTime) = 0 THEN
					Error := TRUE;
				ELSE
					SceneViewPos := PointA;
					State := 1;
				END_IF
			END_IF
		
		1:
			ChangeRate.Zoom := (PointB.Zoom - PointA.Zoom) / TIME_TO_REAL(TravelTime);
			ChangeRate.ViewPoint.X := (PointB.ViewPoint.X - PointA.ViewPoint.X) / TIME_TO_REAL(TravelTime);
			ChangeRate.ViewPoint.Y := (PointB.ViewPoint.Y - PointA.ViewPoint.Y) / TIME_TO_REAL(TravelTime);
			ChangeRate.ViewPoint.Z := (PointB.ViewPoint.Z - PointA.ViewPoint.Z) / TIME_TO_REAL(TravelTime);
			ChangeRate.ViewVector.X := (PointB.ViewVector.X - PointA.ViewVector.X) / TIME_TO_REAL(TravelTime);
			ChangeRate.ViewVector.Y := (PointB.ViewVector.Y - PointA.ViewVector.Y) / TIME_TO_REAL(TravelTime);
			ChangeRate.ViewVector.Z := (PointB.ViewVector.Z - PointA.ViewVector.Z) / TIME_TO_REAL(TravelTime);
			ChangeRate.OrientationVector.X := (PointB.OrientationVector.X - PointA.OrientationVector.X) / TIME_TO_REAL(TravelTime);
			ChangeRate.OrientationVector.Y := (PointB.OrientationVector.Y - PointA.OrientationVector.Y) / TIME_TO_REAL(TravelTime);
			ChangeRate.OrientationVector.Z := (PointB.OrientationVector.Z - PointA.OrientationVector.Z) / TIME_TO_REAL(TravelTime);
		
			State := 2;
			
		2:
			TON_ViewChange.PT := TravelTime;
			TON_ViewChange.IN := TRUE;
			IF TON_ViewChange.Q THEN
				TON_ViewChange.IN := FALSE;
				State := 3;
			END_IF
			
			
			SceneViewPos.Zoom := PointA.Zoom + ChangeRate.Zoom * TIME_TO_REAL(TON_ViewChange.ET);
			SceneViewPos.ViewPoint.X := PointA.ViewPoint.X + ChangeRate.ViewPoint.X * TIME_TO_REAL(TON_ViewChange.ET);
			SceneViewPos.ViewPoint.Y := PointA.ViewPoint.Y + ChangeRate.ViewPoint.Y * TIME_TO_REAL(TON_ViewChange.ET);
			SceneViewPos.ViewPoint.Z := PointA.ViewPoint.Z + ChangeRate.ViewPoint.Z * TIME_TO_REAL(TON_ViewChange.ET);
			SceneViewPos.ViewVector.X := PointA.ViewVector.X + ChangeRate.ViewVector.X * TIME_TO_REAL(TON_ViewChange.ET);
			SceneViewPos.ViewVector.Y := PointA.ViewVector.Y + ChangeRate.ViewVector.Y * TIME_TO_REAL(TON_ViewChange.ET);
			SceneViewPos.ViewVector.Z := PointA.ViewVector.Z + ChangeRate.ViewVector.Z * TIME_TO_REAL(TON_ViewChange.ET);
			SceneViewPos.OrientationVector.X := PointA.OrientationVector.X + ChangeRate.OrientationVector.X * TIME_TO_REAL(TON_ViewChange.ET);
			SceneViewPos.OrientationVector.Y := PointA.OrientationVector.Y + ChangeRate.OrientationVector.Y * TIME_TO_REAL(TON_ViewChange.ET);
			SceneViewPos.OrientationVector.Z := PointA.OrientationVector.Z + ChangeRate.OrientationVector.Z * TIME_TO_REAL(TON_ViewChange.ET);
			
			
		3:
			Done := TRUE;
			
		
		50:
			IF NOT Execute THEN
				Error := FALSE;
				State := 0;
			END_IF
		
	END_CASE
	
	TON_ViewChange();
	
END_FUNCTION_BLOCK
