{ Mark Sattolo  428500     CSI-1100A  DGD-1  TA: Chris Lankester   Assignment 8, Challenge question } program  CrosstheRiver (input,output);{ ****************************************************************************** }	procedure Cross_River(Short, Long:integer; River:string; var Success:boolean); { Determine if River can be crossed by passing from one stone ('O') to another by    a combination of Long and Short "steps". } { Data Dictionary	   Givens:	River - a string consisting of O's and -'s, that starts and ends with an O.	   			Short, Long - positive integers, with Short < Long.      Results:	Success - a boolean which is true if River can be "crossed" by a combination      						of Long's and Short's, and false otherwise.Intermediates:	W - the length of River. } 	var		W : integer;		    begin  { procedure Cross_River }    	W := length(River);    	Success := false;			if (W = Short+1) OR (W = Long+1) then   			Success := true    	else    		if River[Long+1] = 'O' then     			Cross_River(Short, Long, copy(River, Long+1, W-Long), Success);    		if not Success then	    		if River[Short+1] = 'O' then 	    			Cross_River(Short, Long, copy(River, Short+1, W-Short), Success);    end;	{ procedure Cross_River }    			{ ****************************************************************************** }{ program CrosstheRiver: provide input and output and call procedure Cross_River. }{ Data Dictionary	   Givens:	River - a string of O's and -'s.	   			Long, Short - positive integers where Short < Long.	  Results:	Success - a boolean which is true if River can be "crossed", and false 	  			otherwise.	     Uses:	Cross_River }var	River : string;	Long, Short : integer;	Success : boolean;begin	{ Read in the program's givens. }repeat	write('Please enter a string for the "River": ');	readln(River);	write('Please enter a value for "Long": ');	readln(Long);	write('Please enter a value for "Short": ');	readln(Short);		Cross_River(Short, Long, River, Success);			{ write out the results }	writeln;	writeln('*******************************************************');	writeln('Mark Sattolo  428500');	writeln('CSI-1100A  DGD-1  TA: Chris Lankester');	writeln('Assignment 8, Challenge question');	writeln('*******************************************************');	writeln;	if Success then		writeln('Congratulations - You crossed the river!')	else		writeln('Sorry, you are stuck on the other side!');	writeln;	writeln('*******************************************************');until Short = 99;end.