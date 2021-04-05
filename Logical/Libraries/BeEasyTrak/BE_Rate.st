
(* TODO: Add your comment here *)
FUNCTION_BLOCK BE_Rate
	

	
	CASE State OF
		0:
			IF Enable THEN
				State := 1;
			END_IF
		
		1:
			TON_InstantRate.PT := T#60m;
			TON_InstantRate.IN := TRUE;
			
			TrgPoint.ProcessPoint := ADR(ProcessPoint);
			TrgPoint.Enable := TRUE;
	
			IF TrgPoint.Triggered THEN
				Counter := Counter + 1;
				
				TON_InstantRate.IN := FALSE;
				IF TIME_TO_REAL(TON_InstantRate.ET) <> 0 THEN
					PPM_Instant := 1000 / TIME_TO_REAL(TON_InstantRate.ET);
					PPH_Instant := 60 * 1000 / TIME_TO_REAL(TON_InstantRate.ET);
				END_IF
			END_IF
			
			
			
			TON_PPM.PT := T#60s;
			TON_PPM.IN := TRUE;
	
			
	
			IF TON_PPM.Q THEN
				TON_PPM.IN := FALSE;
				PPM := Counter;
				Counter := 0;
			END_IF
	
			PPH := PPM * 60;
			
		
	END_CASE
	
	TON_InstantRate;
	TrgPoint();
	TON_PPM();
	
	
	
	

	
	
	
	
	
	
END_FUNCTION_BLOCK
