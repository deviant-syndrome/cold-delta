var walk = Pn(Pwalk(Scale.diminished.degrees, Prand([1, -1], 8)), inf).asStream;

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

currentEnvironment[\leaksContext] = { |
										exec
									  | exec.value(leaks); };
