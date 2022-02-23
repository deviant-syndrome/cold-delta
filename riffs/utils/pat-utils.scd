var pat8ths = { | pattern |
	Routine.new({
		pattern.do({ arg v;
			if (v == 1, { (1 / 4).yield; }, { Rest(1 / 4).yield; });
		})
	});
};

var loopForever = { | routine, subRepeats = 4 |
	Routine.new({
		loop({
			subRepeats.do({ |i|
				routine.value(i).embedInStream;
			});
		});
	});
};

var e = currentEnvironment;

Require("e-pattern.scd");

e[\patternUtilsContext] = { |
							  euclidianPattern,
	                   		  exec
					 	    | exec.value(pat8ths,
										 loopForever,
										 euclidianPattern); };
