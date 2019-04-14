"CLOCK for CHECKPOINT
Copyright (C) 1985 Infocom, Inc.  All rights reserved."

"List of queued routines:
G-LEAVE-TRAIN
I-ARRIVE-WARNING
I-ATTENTION
I-BAD-SPY
I-BAD-SPY-W-CASE
I-BAD-SPY-W-YOU
I-BOND
I-BOND-OTHER
I-COME-TO
I-CONDUCTOR
I-CONTACT-APPEARS
I-CONTACT-GIVES-UP
I-DEPART
I-DEPART-WARNING
I-EXTRA
I-FOLLOW
I-LEAVE-TRAIN
I-PROMPT
I-TICKETS-PLEASE
I-TRAIN-ARREST
I-TRAIN-LURCH
I-TRAIN-RESTART
I-TRAIN-SCENERY
;I-TRAIN-SOUNDS
I-TRAVELER
I-TRAVELER-FINDS-CONTACT
I-TRAVELER-SEEKS-FLOWER
I-TRAVELER-TO-GRNZ
I-VESTIBULE-DOOR
"

<CONSTANT C-TABLELEN 222>
<GLOBAL C-TABLE %<COND ;(<GASSIGNED? PREDGEN> '<ITABLE NONE 111>)
		       (T '<ITABLE NONE 222>)>>

<GLOBAL C-INTS 222>
<CONSTANT C-INTLEN 6>
<CONSTANT C-ENABLED? 0>
<CONSTANT C-TICK 1>
<CONSTANT C-RTN 2>

<ROUTINE QUEUE (RTN TICK "AUX" CINT)
	 ;#DECL ((RTN) ATOM (TICK) FIX (CINT) <PRIMTYPE VECTOR>)
	 <PUT <SET CINT <INT .RTN>> ,C-TICK .TICK>
	 .CINT>

<ROUTINE INT (RTN "OPTIONAL" (DEMON <>) E C INT)
	 ;#DECL ((RTN) ATOM (DEMON) <OR ATOM FALSE> (E C INT) <PRIMTYPE
							      VECTOR>)
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<==? .C .E>
			<SETG C-INTS <- ,C-INTS ,C-INTLEN>>
			;<AND .DEMON <SETG C-DEMONS <- ,C-DEMONS ,C-INTLEN>>>
			<SET INT <REST ,C-TABLE ,C-INTS>>
			<PUT .INT ,C-RTN .RTN>
			<RETURN .INT>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN> <RETURN .C>)>
		 <SET C <REST .C ,C-INTLEN>>>>

;<ROUTINE ENABLED? (RTN)
	<NOT <ZERO? <GET <INT .RTN> ,C-ENABLED?>>>>

<ROUTINE QUEUED? (RTN "AUX" C)
	<SET C <INT .RTN>>
	<COND (<ZERO? <GET .C ,C-ENABLED?>> <RFALSE>)
	      (<ZERO? <SET C <GET .C ,C-TICK>>> <RFALSE>)
	      (T .C)>>

<GLOBAL CLOCK-WAIT <>>

"SCORE INDICATES HOURS / MOVES = MINUTES"

<GLOBAL SCORE 0>
<GLOBAL MOVES 0>
<GLOBAL PRESENT-TIME 600>

<ROUTINE CLOCKER ("AUX" C E TICK (FLG <>) VAL)
	 ;#DECL ((C E) <PRIMTYPE VECTOR> (TICK) FIX ;(FLG) ;<OR FALSE ATOM>)
	 <COND (,CLOCK-WAIT <SETG CLOCK-WAIT <>> <RFALSE>)>
	 <SETG PRESENT-TIME <+ ,PRESENT-TIME 1>>
	 ;<COND (<G? ,PRESENT-TIME 1199>
		<TIMES-UP>)>
	 <COND (<G? <SETG MOVES <+ ,MOVES 1>> 59>
		<SETG MOVES 0>
		<COND (<G? <SETG SCORE <+ ,SCORE 1>> 23>
		       <SETG SCORE 0>)>)>
	 <SET C <REST ,C-TABLE <COND (T ;,P-WON ,C-INTS) ;(T ,C-DEMONS)>>>
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <REPEAT ()
		 <COND (<==? .C .E> <RETURN .FLG>)
		       (<NOT <ZERO? <GET .C ,C-ENABLED?>>>
			<SET TICK <GET .C ,C-TICK>>
			<COND (<ZERO? .TICK>)
			      (T
			       <PUT .C ,C-TICK <- .TICK 1>>
			       <COND (<AND <NOT <G? .TICK 1>>
				           <SET VAL <APPLY <GET .C ,C-RTN>>>>
				      <COND (<OR <NOT .FLG>
						 <==? .VAL ,M-FATAL>>
					     <SET FLG .VAL>)>)>)>)>
		 <SET C <REST .C ,C-INTLEN>>>>