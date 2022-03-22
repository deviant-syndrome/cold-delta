var string6 = Pmono(
	\steelStringSus6,
	\heck, Pseq([0, 1], inf),
	\heck2, Pseq([1, 0], inf),
	\fret, Pseq([0, 0, 1, 3, 2], inf),
	\group, ~globalRouting[\chuggs][\strip],
	\out, ~globalRouting[\chuggs][\busNum]
).asStream;

var string5 = Pmono(
	\steelStringSus5,
	\fret, Pseq([2, 3, 2, 0, 2], inf),
	\heck, Pseq([0, 1], inf),
	\heck2, Pseq([1, 0], inf),
	\group, ~globalRouting[\chuggs][\strip],
	\out, ~globalRouting[\chuggs][\busNum]
).asStream;

var keys = Pbind(
	\instrument, \bells,
	\degree, Pseq([Pseq([0,7], 2), Pseq([0,8], 2), Pseq([1,7], 2), Pseq([3,5], 2)], inf),
	\scale, Scale.chromatic,
	\root, 1,
	\group, ~globalRouting[\synth1][\strip],
	\out, ~globalRouting[\synth1][\busNum]
).asStream;

var diads = Ppar([string6, string5]).asStream;

currentEnvironment[\diadsContext] = { |
										exec
									  | exec.value(string5, string6, keys); };
