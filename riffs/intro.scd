Require("utils/pat-utils.scd");

currentEnvironment.use({
	~patternUtilsContext.valueEnvir(exec: { | pat8ths, loopForever, euclidianPattern, globalRouting |
		var cymbals = Pbind(
	    	\instrument, \splash,
	    	\dur, loopForever.value({ |i| pat8ths.value(euclidianPattern.value(8 - i, 3)); }),
	    	\group, globalRouting[\cymbals][\strip],
			\pan, Pwrand.new([-0.4, -0.7, 0.6], [1, 3, 5].normalizeSum, inf),
			\amp, 0.2,
	    	\out, globalRouting[\cymbals][\busNum]
		).asStream;

		var bells = Pbind(
			\instrument, \bells,
			\group, globalRouting[\synth1][\strip],
			\scale, Scale.minor,
			\octave, 5,
			\degree,
			Pdfsm(
				   [
					   Pseq( [\reprise, \reprise, \reprise, \coda], inf ),
					   (
						   \reprise : [0, Pseq([0, 4, 4, 3, Rest(), 2, 1, Rest(), 6, 7], 1)],
						   \coda : [0, Pseq([-4, 4, 4, 3, Rest(), 2, 1, Rest(), 6, 7], 1)]
					   )
				   ],
				   0,
				   inf
			   ).asStream,
			\sustain, Pseq([0.3, 0.6], inf),
			\out, globalRouting[\synth1][\busNum]
		).asStream;

		var bowed = Pbind(
	    	\instrument, \bowedHell,
	    	\dur, loopForever.value(routine: { |i| pat8ths.value(euclidianPattern.value(8 - i, 3), length: 3); }),
	    	\group, globalRouting[\partials][\strip],
			\timeScale, Pseq([1, 2, 0.5], inf),
			\freqScale, Pseq([1, 2 / 3, (2 / 3) * (2 / 3)], inf),
			\amp, 0.2,
	    	\out, globalRouting[\partials][\busNum]
		).asStream;

		// var chuggs = Pbind(
	    // 	\instrument, \steelString,
	    // 	\group, ~globalRouting[\chuggs][\strip],
		// 	\dur, 0.35,
	    // 	\amp, 0.12,
	    // 	\stroke, Pgate(Pseq([0, 1], inf), inf, \strokeGate),
	    // 	\out, ~globalRouting[\chuggs][\busNum]
	    // ).asStream;

		var introRiffs =  Dictionary.newFrom([
			\cymbals, cymbals,
			// \chuggs, chuggs,
			\bowed, bowed,
			\bells, bells
		]);

		currentEnvironment[\riffsContext] = { |
			                   					exec
							 				  | exec.value(introRiffs); };
	});
});
