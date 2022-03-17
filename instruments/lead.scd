SynthDef(\lead, { | gate = 1, freq = 497.87, amp = 0.8, ir = 0, out = 0 |
	var env = EnvGen.ar(Env.adsr(0.01, 0.4, 0.5, 0.1), gate: gate, levelScale: amp * 0.5, doneAction: Done.freeSelfToHead);
	var snd;


	snd = Mix.new([
		Saw.ar(freq),
		Saw.ar(freq * 2.09) * EnvGen.ar(Env.perc(0.01, 0.1)),
		Saw.ar(Vibrato.ar(DC.ar(freq), LFNoise2.ar(0.3, 1.5, 3), 0.01)),
		Saw.ar(Vibrato.ar(DC.ar(freq), LFNoise2.ar(0.5, 0.5, 2), 0.002)),
		Saw.ar(Vibrato.ar(DC.ar(freq), LFNoise2.ar(0.5, 0.5, 2), 0.01)) * 0.2,
		Saw.ar(Vibrato.ar(DC.ar(freq * 0.5), LFNoise2.ar(0.5, 0.5, 2),0.02)) * (2.pow(freq / 440)) * 0.4,
	]) * env * (1/5);

	snd = (Wrap.ar(snd, -0.012, amp * 0.75) * 2).tanh * 0.2;
	snd = Wrap.ar(CrossoverDistortion.ar(snd, 0.2, -0.4, 0.2), 0, 0.4);
	snd = RLPF.ar(snd, 14000, 0.3);

	Out.ar(out, snd ! 2);
}).add;
