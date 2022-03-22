SynthDef(\reverb, { | in = 0, out = 0 |
	Out.ar(out,
		FreeVerb.ar(In.ar(in, 1), mix: 1, room: 0.5, damp: 0.5, mul: 1.0, add: 0.0));
}).add;
