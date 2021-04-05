
(* TODO: Add your comment here *)
FUNCTION_BLOCK BE_FindShuttles
	AsmGetShuttle.Assembly := ADR(Assembly);

	IF AsmGetShuttle.Error THEN
		Error := TRUE;
		State := 4;
	END_IF
	
	CASE State OF
		0:
			IF Execute THEN
				i := 1;
				Busy := TRUE;
				State := 1;
			END_IF
		
		1:
			AsmGetShuttle.Enable := TRUE;
			IF AsmGetShuttle.Valid THEN
				NumShuttlesFound := AsmGetShuttle.TotalCount;
				IF AsmGetShuttle.Axis.controlif <> 0 THEN
					ShuttleAxisArray[i] := AsmGetShuttle.Axis;
				END_IF
				IF AsmGetShuttle.RemainingCount > 0 THEN
					AsmGetShuttle.Next := TRUE;
					State := 2;
				ELSE
					State := 3;
				END_IF
			END_IF
			
		2:
			AsmGetShuttle.Next := FALSE;
			i := i + 1;
			State := 1;
		
		3:
			Done := TRUE;
			IF NOT Execute THEN
				brsmemset(ADR(ShuttleAxisArray),0,SIZEOF(ShuttleAxisArray));
				AsmGetShuttle.Enable := FALSE;
				NumShuttlesFound := 0;
				Done := FALSE;
				Busy := FALSE;
				State := 0;
			END_IF
		
		4: //error state
		
	END_CASE
	
		
	AsmGetShuttle();
	
	
END_FUNCTION_BLOCK
