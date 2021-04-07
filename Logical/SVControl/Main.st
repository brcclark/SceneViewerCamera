
PROGRAM _INIT
	(* Insert code here *)
	
	Point[0] := StartView;
	Vis.Bind.Camera := StartView;
	
	Vis.Bind.FocalPoint.X := FocalPointInit.X;
	Vis.Bind.FocalPoint.Y := FocalPointInit.Y;
	Vis.Bind.FocalPoint.Z := FocalPointInit.Z;
	
	Vis.Controls.Linear.X := StartView.ViewPoint.X;
	Vis.Controls.Linear.Y := StartView.ViewPoint.Y;
	Vis.Controls.Z := StartView.ViewPoint.Z;
	Vis.Controls.Fov := StartView.Fov;
	Vis.Controls.Circular.Radius := 100;
END_PROGRAM

PROGRAM _CYCLIC
	
	
	
	

	
	Vis.Bind.FocalPoint.X := Vis.Bind.FocalPoint.X + Vis.Controls.FocalPoint.XBtnPos - Vis.Controls.FocalPoint.XBtnNeg;
	Vis.Bind.FocalPoint.Y := Vis.Bind.FocalPoint.Y + Vis.Controls.FocalPoint.YBtnPos - Vis.Controls.FocalPoint.YBtnNeg;
	Vis.Bind.FocalPoint.Z := Vis.Bind.FocalPoint.Z + Vis.Controls.FocalPoint.ZBtnPos - Vis.Controls.FocalPoint.ZBtnNeg;

	Vis.Controls.Circular.Radius := Vis.Controls.Circular.Radius + Vis.Controls.Circular.RadiusBtnPos - Vis.Controls.Circular.RadiusBtnNeg;
	Vis.Controls.Linear.X := Vis.Controls.Linear.X + Vis.Controls.Linear.XBtnPos - Vis.Controls.Linear.XBtnNeg;
	Vis.Controls.Linear.Y := Vis.Controls.Linear.Y + Vis.Controls.Linear.YBtnPos - Vis.Controls.Linear.YBtnNeg;

	
	Vis.Bind.FocalPointVisible := Vis.Controls.FocalPoint.Visible;
	
	CASE State OF
		MOVE_SETTINGS: //set points
			CASE Vis.Controls.MoveMode OF
				LINEAR:
					MoveText := 'Linear';
					Vis.Bind.Camera.ViewPoint.X := Vis.Controls.Linear.X;
					Vis.Bind.Camera.ViewPoint.Y := Vis.Controls.Linear.Y;
				
					AngleRad := atan2((Vis.Bind.Camera.ViewPoint.Y - Vis.Bind.FocalPoint.Y),(Vis.Bind.Camera.ViewPoint.X - Vis.Bind.FocalPoint.X));
					Vis.Controls.Circular.Angle := AngleRad * 180 / PI;
					IF Vis.Controls.Circular.Angle < 0 THEN
						Vis.Controls.Circular.Angle := Vis.Controls.Circular.Angle + 360;
					ELSIF Vis.Controls.Circular.Angle >= 360 THEN
						Vis.Controls.Circular.Angle := Vis.Controls.Circular.Angle - 360;
					END_IF
					Vis.Controls.Circular.Radius := (Vis.Bind.Camera.ViewPoint.X - Vis.Bind.FocalPoint.X) / COS(AngleRad);
				RADIAL:
					MoveText := 'Radial';
					AngleRad := Vis.Controls.Circular.Angle * PI / 180;
				
					Vis.Bind.Camera.ViewPoint.X := (Vis.Controls.Circular.Radius * COS(AngleRad)) + Vis.Bind.FocalPoint.X;
					Vis.Bind.Camera.ViewPoint.Y := (Vis.Controls.Circular.Radius * SIN(AngleRad)) + Vis.Bind.FocalPoint.Y;
				
					Vis.Controls.Linear.X := Vis.Bind.Camera.ViewPoint.X;
					Vis.Controls.Linear.Y := Vis.Bind.Camera.ViewPoint.Y;
			END_CASE
			
			Vis.Bind.Camera.OrientationVector.X := 0;
			Vis.Bind.Camera.OrientationVector.Y := 0;
			Vis.Bind.Camera.OrientationVector.Z := 1;
					
				
			
			Vis.Bind.Camera.ViewPoint.Z := Vis.Controls.Z;
			Vis.Bind.Camera.Fov := Vis.Controls.Fov;
			
			
			Vis.Bind.Camera.ViewVector.X := (Vis.Bind.FocalPoint.X - Vis.Bind.Camera.ViewPoint.X) / 1000.0;
			Vis.Bind.Camera.ViewVector.Y := (Vis.Bind.FocalPoint.Y - Vis.Bind.Camera.ViewPoint.Y) / 1000.0;
			Vis.Bind.Camera.ViewVector.Z := (Vis.Bind.FocalPoint.Z - Vis.Bind.Camera.ViewPoint.Z) / 1000.0;
			
					
			IF Vis.Controls.NewMove THEN
				Vis.Controls.NewMove := FALSE;
				State := NEW_MOVE;
			ELSIF Vis.Controls.Load THEN
				State := LOAD_MOVE;
			ELSIF Vis.Controls.Save THEN
				Vis.Controls.Save := FALSE;
				State := SAVE_MOVE;
			END_IF
					
					
					
			
			IF Vis.Controls.SavePointA THEN
				Vis.Controls.SavePointA := FALSE;
				Point[0] := Vis.Bind.Camera;
			END_IF
				
			IF Vis.Controls.Start THEN
				CompletedMoves := 0;
				PointA := Point[0];
				PointB := CamMove[0].Point;
				FocalPointA := FocalPointInit;
				FocalPointB := CamMove[0].FocalPoint;
				State := START_MOVE;
			END_IF
			
		NEW_MOVE: //new move
			FOR i := 0 TO MAX_NUM_MOVES DO
				IF NOT CamMove[i].IsSaved THEN
					CamMove[i].IsSaved := TRUE;
					CamMove[i].MoveType := Vis.Controls.MoveMode;
					CamMove[i].TravelTime := REAL_TO_TIME(Vis.Controls.TimeInput * 1000);

					State := NEW_MOVE_SAVE;
					EXIT;
				ELSIF i = MAX_NUM_MOVES THEN
					State := MOVE_SETTINGS;
				END_IF
			END_FOR
			
		NEW_MOVE_SAVE: 

			TotalNumMoves := TotalNumMoves + 1;
			CamMove[i].Point := Vis.Bind.Camera;
			CamMove[i].FocalPoint := Vis.Bind.FocalPoint;
			
			State := UPDATE_LIST;
			
		UPDATE_LIST:
			brsftoa(i, ADR(MoveIndexString));
			MoveNumText[i] := CONCAT(MoveIndexString, ': ');
			MoveNumText[i] := CONCAT(MoveNumText[i], MoveText);
			MoveNumText[i] := CONCAT(MoveNumText[i], ' Move');
					
			IntermediateDateProvider[i] := CONCAT('{"value":"',MoveIndexString);
			IntermediateDateProvider[i] := CONCAT(IntermediateDateProvider[i],'","text":"');
			IntermediateDateProvider[i] := CONCAT(IntermediateDateProvider[i], MoveNumText[i]);
			DataProvider[i] := CONCAT(IntermediateDateProvider[i],'"}');
			
			State := MOVE_SETTINGS;
			
		
			
		LOAD_MOVE: //load
			Vis.Controls.Load := FALSE;
			
			IF CamMove[Vis.Controls.SelectedMove].IsSaved THEN
				Vis.Controls.Linear.X := CamMove[Vis.Controls.SelectedMove].Point.ViewPoint.X;
				Vis.Controls.Linear.Y := CamMove[Vis.Controls.SelectedMove].Point.ViewPoint.Y;
				Vis.Controls.Z := CamMove[Vis.Controls.SelectedMove].Point.ViewPoint.Z;
				Vis.Controls.Fov := CamMove[Vis.Controls.SelectedMove].Point.Fov;
				Vis.Controls.TimeInput := TIME_TO_REAL(CamMove[Vis.Controls.SelectedMove].TravelTime) / 1000;
				
				
				
				Vis.Bind.Camera := CamMove[Vis.Controls.SelectedMove].Point;
				Vis.Bind.FocalPoint := CamMove[Vis.Controls.SelectedMove].FocalPoint;
			END_IF
			State := MOVE_SETTINGS;
			
		SAVE_MOVE: //save
			IF CamMove[Vis.Controls.SelectedMove].IsSaved THEN
				CamMove[Vis.Controls.SelectedMove].Point := Vis.Bind.Camera;
				CamMove[Vis.Controls.SelectedMove].FocalPoint := Vis.Bind.FocalPoint;
				CamMove[Vis.Controls.SelectedMove].TravelTime := REAL_TO_TIME(Vis.Controls.TimeInput * 1000);
				i := Vis.Controls.SelectedMove;
				State := UPDATE_LIST;
			ELSE
				State := MOVE_SETTINGS;
			END_IF
			
			
		START_MOVE:
			TravelTime := CamMove[CompletedMoves].TravelTime;
			IF CamMove[CompletedMoves].MoveType = LINEAR THEN
				State := LINEAR_MOVE;
			ELSIF CamMove[CompletedMoves].MoveType = RADIAL THEN
				State := RADIAL_MOVE;
			END_IF
			
			
			
		RADIAL_MOVE:
			Vis.Controls.SelectedMove := CompletedMoves;
			RadialMove.PointA := PointA;
			RadialMove.PointB := PointB;
			RadialMove.FocalPointA := FocalPointA;
			RadialMove.FocalPointB := FocalPointB;
			RadialMove.TravelTime := TravelTime;
			RadialMove.Execute := TRUE;
			State := WAIT_FOR_RADIAL_MOVE_DONE;
			
			
	
			
		WAIT_FOR_RADIAL_MOVE_DONE:
			
			
			IF RadialMove.Done THEN
				RadialMove.Execute := FALSE;
				CompletedMoves := CompletedMoves + 1;
				State := MOVE_COMPLETE;
			END_IF
			
			RadialMove();
			Vis.Controls.ActiveMoveTravelTime := TravelTime;
			Vis.Controls.ActiveMoveElapsedTime := RadialMove.ElapsedTime;
			Vis.Bind.FocalPoint := RadialMove.FocalPointPos;
			Vis.Bind.Camera := RadialMove.SceneViewPos;
		
		LINEAR_MOVE:
			Vis.Controls.SelectedMove := CompletedMoves;
			FocalPointMove.PointA := PointA;
			FocalPointMove.PointB := PointB;
			//FocalPointMove.FocalPoint := Vis.FocalPoint;
			FocalPointMove.FocalPointA := FocalPointA;
			FocalPointMove.FocalPointB := FocalPointB;
			FocalPointMove.TravelTime := TravelTime;
			FocalPointMove.Execute := TRUE;
			State := WAIT_FOR_LINEAR_MOVE_DONE;
			
		
		WAIT_FOR_LINEAR_MOVE_DONE:
			
		
			IF FocalPointMove.Done THEN
				FocalPointMove.Execute := FALSE;
				CompletedMoves := CompletedMoves + 1;
				State := MOVE_COMPLETE;
			END_IF
			
			FocalPointMove();
			Vis.Controls.ActiveMoveTravelTime := TravelTime;
			Vis.Controls.ActiveMoveElapsedTime := FocalPointMove.ElapsedTime;
			Vis.Bind.FocalPoint := FocalPointMove.FocalPointPos;
			Vis.Bind.Camera := FocalPointMove.SceneViewPos;
			
		
		MOVE_COMPLETE:
			IF CompletedMoves < TotalNumMoves THEN
				PointA := Vis.Bind.Camera;
				PointB := CamMove[CompletedMoves].Point;
				FocalPointA := Vis.Bind.FocalPoint;
				FocalPointB := CamMove[CompletedMoves].FocalPoint;
				State := START_MOVE;
			ELSE
				State := WAIT_FOR_STOP;
			END_IF
			
		WAIT_FOR_STOP:
			IF NOT Vis.Controls.Start THEN
				State := MOVE_SETTINGS;
			END_IF
		

		
		
		
		
	END_CASE
	
	
//	RadialMove();
//	FocalPointMove();
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

