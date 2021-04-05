
(* TODO: Add your comment here *)
FUNCTION_BLOCK BE_TrgPoint
	
	TrgPoint.TrgPointEnable.ProcessPoint := ADR(ProcessPoint);
	TrgPoint.TrgPointGetInfo.ProcessPoint := ADR(ProcessPoint);
	
	TrgPoint.TrgPointEnable.Enable := Enable;
	
	CASE State OF
		0:
			IF TrgPoint.TrgPointEnable.EventCount > 0 THEN
				TrgPoint.TrgPointGetInfo.Execute := TRUE;
			END_IF
		
			IF TrgPoint.TrgPointGetInfo.TrgPointInfo.Event = mcACPTRAK_TP_PASSED_POSITIVE THEN
				ShuttleAxis := TrgPoint.TrgPointGetInfo.TrgPointInfo.Axis;
				TrgPoint.TrgPointGetInfo.Execute := FALSE;
				Triggered := TRUE;
				State := 1;
			END_IF
		
		1:
			Triggered := FALSE;
			State := 0;
		
		
	END_CASE
	
	TrgPoint.TrgPointEnable();
	TrgPoint.TrgPointGetInfo();
	
END_FUNCTION_BLOCK
