var d = Routine.new({

	var heck = Array.fill(17, { [Array.fill(16.rand, [1, -1]).flatten, [-1, 1].choose].wchoose([0.2, 0.8]) }).flatten.postln;
	heck.size.do { | i |
		heck[i].yield;
	};
	1.yieldAndReset;
});


var walk = Pn(Pwalk(Scale.diminished.degrees, Prand([1, -1], 8)), inf).asStream;

var walkAndTrills = Pn(Pwalk(Scale.diminished.degrees, d), inf).asStream;

var alltime = Routine.new({ true.yieldAndReset; });
var halftime =  Routine.new({ true.yield; false.yield; true.yield; false.yieldAndReset; });
var tupled =  Routine.new({ true.yield; true.yield; false.yield; false.yieldAndReset; });

var leaks = Pseq([Pbind(
	\instrument, \lead,
	\degree, Pfunc({ var res = walk.next; [res, res + 4] }),
	\root, 1,
	// \degree, Ptuple([0, Pwalk(Scale.hijaz.degrees, Prand([1, -1], inf))]),
	\dur, 0.3,
	\octave, Pgate(Pseq([5, 6, 7], inf), \kek),
    \scale, Scale.diminished,
	\group, ~globalRouting[\chuggs][\strip],
	\out, ~globalRouting[\chuggs][\busNum])
], inf).asStream;


var advancedleaks = Pseq([Pbind(
	\instrument, \lead,
	\degree, Pfunc({ var res = walkAndTrills.next; [res, res + 4] }),
	\root, 1,
	// \degree, Ptuple([0, Pwalk(Scale.hijaz.degrees, Prand([1, -1], inf))]),
	\dur, 0.3,
	\octave, Pgate(Pseq([5, 6, 7], inf), \kek),
    \scale, Scale.diminished,
	\group, ~globalRouting[\chuggs][\strip],
	\out, ~globalRouting[\chuggs][\busNum])
], inf).asStream;

currentEnvironment[\leaksContext] = { |
										exec
									  | exec.value(leaks); };
