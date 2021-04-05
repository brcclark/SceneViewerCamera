
PROGRAM _INIT
	(* Insert code here *)
	AsmReadInfo.Assembly := ADR(gAssembly_1);
	AsmReadInfo.Enable := TRUE;
	AsmPowerOn.Assembly := ADR(gAssembly_1);
	MoveOnSector.Sector := ADR(Sector_1);
	MoveOnSector.Assembly := ADR(gAssembly_1);
	FindShuttles.Assembly := ADR(gAssembly_1);
END_PROGRAM

PROGRAM _CYCLIC
	CASE State OF
		0://power on
			IF AsmReadInfo.AssemblyInfo.ReadyForPowerOn THEN
				AsmPowerOn.Execute := TRUE;
			END_IF
		
			IF AsmPowerOn.Done AND AsmReadInfo.AssemblyInfo.PowerOn THEN
				AsmPowerOn.Execute := FALSE;
				State := 1;
	  
			END_IF;
		
		1: //FIND SHUTTLES
			FindShuttles.Execute := TRUE;
			IF FindShuttles.Done THEN
				FindShuttles.Execute := FALSE;
				AxisArray := FindShuttles.ShuttleAxisArray;
				State := 2;
			END_IF
			
		2://move shuttles
			MoveOnSector.Acceleration := 10;
			MoveOnSector.Deceleration := 10;
			MoveOnSector.Velocity := 2;
			MoveOnSector.AxisArray := AxisArray;
			MoveOnSector.Execute := TRUE;
			IF MoveOnSector.Done THEN
				MoveOnSector.Execute := FALSE;
				State := 3;
			END_IF
		
		3: //running
		
	END_CASE
	
			
			
			
	AsmReadInfo();
	AsmPowerOn();
	MoveOnSector();
	FindShuttles();
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

