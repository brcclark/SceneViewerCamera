
(* TODO: Add your comment here *)
FUNCTION_BLOCK BE_SimStartup
	
	AsmReadInfo.Assembly := ADR(Assembly);
	AsmReadInfo.Enable := TRUE;
	
	
	CASE State OF
		0: //POWER_ON
			IF Execute THEN
				State := 1;
			END_IF
		
		1: //ADD_SHUTTLES
			AddShuttle.Sector := ADR(Sector);
			AddShuttle.Position := (i - 1) * 0.1;
			AddShuttle.Execute := TRUE;
			
			IF AddShuttle.Done  THEN
				ShuttleAxisArray[i] := AddShuttle.Axis;
				AddShuttle.Execute := FALSE;
				i := i + 1;
			END_IF
		
			IF i > NUM_SHUTTLES THEN
				i := 1;
				State := 2;
			END_IF
		
		2: //MOVE_SHUTTLES
			

			IF EDGEPOS(ElasticMoveVel.Active) THEN
				i := i + 1;
			ELSIF ShuttleAxisArray[i].controlif <> 0 THEN
				ElasticMoveVel.Axis := ADR(ShuttleAxisArray[i]);
				ElasticMoveVel.Velocity := 2;
				ElasticMoveVel.Acceleration := 10;
				ElasticMoveVel.Deceleration := 10;
				ElasticMoveVel.Execute := TRUE;
			END_IF
		
			IF i > NUM_SHUTTLES THEN
				State := 3;
			END_IF
//		
		3: //STANDBY
			Done := TRUE;
			IF NOT Execute THEN
				Done := FALSE;
				State := 0;
			END_IF
		
	END_CASE
	
	
	AddShuttle();
	AsmReadInfo();
	ElasticMoveVel();
	ElasticMoveVel.Execute := FALSE;

	
END_FUNCTION_BLOCK
