Require("utils/pat-utils.scd");

currentEnvironment.use({
	~patternUtilsContext.valueEnvir(exec: { | pat8ths, loopForever, euclidianPattern |
		var cymbals = Pbind(
	    	\instrument, \splash,
	    	\dur, loopForever.value({ |i| pat8ths.value(euclidianPattern.value(8 - i, 3)); }),
	    	\group, ~globalRouting[\cymbals][\strip],
			\pan, Pwrand.new([-0.4, -0.7, 0.6], [1, 3, 5].normalizeSum, inf),
			\amp, 0.2,
	    	\out, ~globalRouting[\cymbals][\busNum]
		).asStream;

		var chuggs = Pbind(
	    	\instrument, \steelString,
	    	\group, ~globalRouting[\chuggs][\strip],
			\dur, 0.5,
	    	\amp, 0.12,
	    	\stroke, Pgate(Pseq([0, 1], inf), inf, \strokeGate),
	    	\out, ~globalRouting[\chuggs][\busNum]
	    ).asStream;

		var basicRiffs =  Dictionary.newFrom([
			\cymbals, cymbals,
			\chuggs, chuggs
		]);

		currentEnvironment[\riffsContext] = { |
			                   					exec
							 				  | exec.value(basicRiffs); };
	});
});
