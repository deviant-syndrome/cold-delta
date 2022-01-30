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

SynthDef(\kick, {
	arg baseFreq = 250, masterVol = 0.6;

	var pitchEnv = EnvGen.ar(Env.perc(0, 0.2));
	var ampEnv =  EnvGen.ar(Env.perc(0, 2.2), levelScale: masterVol, doneAction: 2);
	Out.ar(0, HPF.ar(SinOsc.ar(baseFreq * pitchEnv, 0, ampEnv), 60).dup(2))
}).add;


SynthDef(\ride, {
	arg masterVol = 0.4;

	var square1 = Pulse.ar(10400, 0.7);
	var square2 = Pulse.ar(9300, 0.6);
	var square3 = Pulse.ar(9200);
	var square4 = Pulse.ar(5250);
	var square5 = Pulse.ar(7800, 0.2);
	var square6 = Pulse.ar(12010);

	var signal = square1 + square2 + square3 + square4 + square5 + square6;


	var highComponent = BBandPass.ar(signal, 14000);
	var lowComponent = BBandPass.ar(signal, 400);

	var highVCA = EnvGen.ar(Env.perc(0, 0.4, 0.1), 1, masterVol);
	var lowVCA = EnvGen.ar(Env.perc(0, 0.8, 0.8), 1, masterVol, doneAction: 2);

	Out.ar(0, (highComponent * highVCA + lowComponent * lowVCA).dup(2));
}).add;
