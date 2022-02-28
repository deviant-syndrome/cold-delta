var everyTime = Routine.new({ true.yieldAndReset; });
var halftime = Routine.new({ true.yield; false.yield; false.yield; false.yieldAndReset; });

var movement1Sync;

var chops = Pbind(
	// todo: some spectrally morphed-in stuff here
	\instrument, Pseq([\steelString5, \steelString6, \steelString5, \steelString6, \steelString6, \steelString6, \steelString6], 2),
	// \dur, Pseq([0.5, 0.5, 0.5, 0.5, 0.2, 0.2, 0.2], inf),
	\fret, Pn(Pseq([Pseq([3, 0, 2, 0, 1, 4, 1], 3), Pseq([4, 1, 3, 1, 0, 0, 0], 1)], 2), 1, \kek),
	\timing, Pgate(Pseq([Pfunc({ movement1Sync = halftime }), Pfunc({ movement1Sync = everyTime })], inf), \kek),
	\amp, Pseq([1, 0.7], inf),
	\pm, Pseq([0, 0, 0, 0, 1, 1, 1], 2),
	\stroke, Pgate(Pseq([0, 1], inf), inf, \strokeGate),
	\group, ~globalRouting[\chuggs][\strip],
	\out, ~globalRouting[\chuggs][\busNum]
);

var muted = Pbind(
	// todo: some spectrally morphed-in stuff here
	\instrument, \steelString6,
	// \dur, Pseq([0.5, 0.5, 0.5, 0.5, 0.2, 0.2, 0.2], inf),
	\fret, 0,
	\amp, Pn(Pseq([1, 0.7], 24), 1, \kek),
	\pm, 1,
	\choke, 1,
	\timing, Pgate(Pseq([Pfunc({ movement1Sync = everyTime }), Pfunc({ movement1Sync = halftime })], inf), \kek),
	// \stroke, Pgate(Pseq([0, 1], inf), inf, \strokeGate),
	\group, ~globalRouting[\chuggs][\strip],
	\out, ~globalRouting[\chuggs][\busNum]
);

var both = Pseq([muted, chops], inf).asStream;

var tremolos = Pbind(
	// todo: some spectrally morphed-in stuff here
	\instrument, \steelString5,
	\dur, 0.35,
	\fret, Pseq([Pn(0, 18), 1], inf),
	\amp, 1,
	\pm, 1,
	\choke, 1,
	\release, 0.02,
	\stroke, Pseq([0, 1], inf),
	\group, ~globalRouting[\chuggs][\strip],
	\out, ~globalRouting[\chuggs][\busNum]
).asStream;

var movement1Riffs = Dictionary.newFrom([
	\chops, both,
	\tremolos, tremolos,
	\muted, muted,
]);

movement1Sync = everyTime;

currentEnvironment[\movement1Context] = { |
										exec
									  | exec.value(movement1Riffs, movement1Sync); };
