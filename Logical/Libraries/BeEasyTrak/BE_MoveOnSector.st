
(* TODO: Add your comment here *)
FUNCTION_BLOCK BE_MoveOnSector
	CASE State OF
		0:
			IF Execute THEN
				i := 1;
				State := 1;
			END_IF
		
		1:
			AsmGetShuttle.Assembly := ADR(Assembly);
			AsmGetShuttle.Enable := TRUE;
			IF AsmGetShuttle.Valid THEN
				NumShuttles := AsmGetShuttle.TotalCount;
				AsmGetShuttle.Enable := FALSE;
				State := 2;
			END_IF
			
			
		2:
			IF EDGEPOS(RoutedMoveVel.Active) THEN
				i := i + 1;
			ELSIF AxisArray[i].controlif <> 0 THEN
				RoutedMoveVel.Sector := ADR(Sector);
				RoutedMoveVel.Axis := ADR(AxisArray[i]);
				RoutedMoveVel.Position := 0;
				RoutedMoveVel.RouteVelocity := Velocity;
				RoutedMoveVel.Velocity := Velocity;
				RoutedMoveVel.Acceleration := Acceleration;
				RoutedMoveVel.Deceleration := Deceleration;
				RoutedMoveVel.Execute := TRUE;		
			END_IF
		
			IF i > NumShuttles THEN
				State := 3;
			END_IF
		
		3:
			Done := TRUE;
			State := 4;
		
		4:
			IF NOT Execute THEN
				Done := FALSE;
				NumShuttles := 0;
				State := 0;
			END_IF
		
			
	END_CASE
	
	AsmGetShuttle();
	RoutedMoveVel();
	RoutedMoveVel.Execute := FALSE;
	
END_FUNCTION_BLOCK
