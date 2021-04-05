
(* TODO: Add your comment here *)
FUNCTION_BLOCK BE_AsmStop
	CASE State OF
		0:
			IF Execute THEN
				i := 1;
				State := 1;
			END_IF
		
		1:
			
			Stop.Deceleration := Deceleration;
			Stop.Axis := ADR(AxisArray[i]);
			Stop.Execute := TRUE;
			
			IF i >= NumShuttles THEN
				Done := TRUE;
				State := 3;
			ELSE
				State := 2;
			END_IF
		
		2:
			Stop.Execute := FALSE;
			i := i + 1;
			State := 1;
		
		3:
			IF NOT Execute THEN
				State := 0;
				Done := FALSE;
				Stop.Execute := FALSE;
			END_IF
		
	END_CASE
	
	Stop();
	
END_FUNCTION_BLOCK
