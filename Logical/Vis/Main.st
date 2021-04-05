PROGRAM _INIT 
    // size of Vis structure - this value has to be entered in B&R scene viewer (PVI -> Options -> Size)
	SizeofVis := SIZEOF(Vis);
	// max number of displayed shuttles  
	NumVisShuttle := SIZEOF(Vis.Shuttle) / SIZEOF(Vis.Shuttle[0]);  
	
	SizeofUserData := SIZEOF(pUserData);
END_PROGRAM

PROGRAM _CYCLIC 
	FOR i:=0 TO (NumVisShuttle-1) DO 
		IF gShuttleMon.Shuttle[i].Available THEN
			// format selected monitor data to fit B&R scene viewer  
			Vis.Shuttle[i].Available    := 1;
			Vis.Shuttle[i].PositionX    := LREAL_TO_REAL(gShuttleMon.Shuttle[i].Position.X);
			Vis.Shuttle[i].PositionY    := LREAL_TO_REAL(gShuttleMon.Shuttle[i].Position.Y);
			Vis.Shuttle[i].RotationZ    := LREAL_TO_REAL(gShuttleMon.Shuttle[i].Orientation.Angle1);
			Vis.Shuttle[i].ExtentToFront    := LREAL_TO_REAL(gShuttleMon.Shuttle[i].ExtentToFront);
			Vis.Shuttle[i].ExtentToBack        := LREAL_TO_REAL(gShuttleMon.Shuttle[i].ExtentToBack);
			Vis.Shuttle[i].Width    := LREAL_TO_REAL(gShuttleMon.Shuttle[i].Width);  
			brsitoa(gShuttleMon.Shuttle[i].Index, ADR(Vis.Shuttle[i].Text));
			Vis.Shuttle[i].ColorRed    := 0.5;    //
			Vis.Shuttle[i].ColorGreen    := 0.5;    // default shuttle color grey
			Vis.Shuttle[i].ColorBlue    := 0.5;        //
			
			// example: set shuttle colour via user data
			IF gShuttleMon.Shuttle[i].UserData <> 0 THEN  
				pUserData ACCESS gShuttleMon.Shuttle[i].UserData;    // access to user data of this shuttle
				IF pUserData.Color = GRAY THEN    
					Vis.Shuttle[i].ColorRed    := 0.5;
					Vis.Shuttle[i].ColorGreen    := 0.5;
					Vis.Shuttle[i].ColorBlue    := 0.5;
				ELSIF pUserData.Color = GREEN THEN   
					Vis.Shuttle[i].ColorRed    := 0.0;
					Vis.Shuttle[i].ColorGreen    := 1.0;
					Vis.Shuttle[i].ColorBlue    := 0.0;
				ELSIF pUserData.Color = BLUE THEN    
					Vis.Shuttle[i].ColorRed    := 0.0;
					Vis.Shuttle[i].ColorGreen    := 0.0;
					Vis.Shuttle[i].ColorBlue    := 1.0;
				ELSIF pUserData.Color = RED THEN    
					Vis.Shuttle[i].ColorRed    := 1.0;
					Vis.Shuttle[i].ColorGreen    := 0.0;
					Vis.Shuttle[i].ColorBlue    := 0.0;
				ELSIF pUserData.Color = ORANGE THEN    
					Vis.Shuttle[i].ColorRed    := 1.0;
					Vis.Shuttle[i].ColorGreen    := 0.5;
					Vis.Shuttle[i].ColorBlue    := 0.0;
				END_IF  
			END_IF

			

			
			
		ELSE
			brsmemset(ADR(Vis.Shuttle[i]), 0, SIZEOF(Vis.Shuttle[0]));
		END_IF
		
		
		
		
		
		
	END_FOR
	
	
END_PROGRAM


PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

