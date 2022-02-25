var pat8ths = { | pattern, length = 0.25 |
	Routine.new({
		pattern.do({ arg v;
			if (v == 1, { (length).yield; }, { Rest(length).yield; });
		})
	});
};

var loopForever = { | routine, subRepeats = 4, length = 0.25 |
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
							  globalRouting,
							  euclidianPattern,
	                   		  exec
					 	    | exec.value(
										 pat8ths,
										 loopForever,
										 euclidianPattern,
										 globalRouting); };
