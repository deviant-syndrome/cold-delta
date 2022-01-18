~snare = {
	arg masterVol = 0.4, scale = 0.8;

	var tri = Saw.ar(111.0 * scale);
	var freqS1 = FreqShift.ar(tri, 175 * scale, 0, 0.1);
	var freqS2 = FreqShift.ar(tri, 224 * scale, 0, 0.1);

	var env = EnvGen.ar(Env.perc(0, 0.5), 1, masterVol, doneAction: 2);

	var membraine = SinOsc.ar(180, 0 * scale) + SinOsc.ar(330 * scale, 0, 0.4) + freqS1 + freqS2;
	var memEq = BPeakEQ.ar(membraine, 7200, 4.0, 6);
	((memEq + WhiteNoise.ar(0.20)) * env).dup(2);
};


