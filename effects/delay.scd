var buf = Buffer.alloc(s, 44100 * 2, 2);

SynthDef(\delayLine, { | in = 0, out = 0 |
	Out.ar(out, LPF.ar(PingPong.ar(buf.bufnum, In.ar(in, 2) * 1.2,
		0.4, 0.8, 1), 300))

}).add;
