SynthDef(\cymbalTexture, { | in = 0, out = 0, cymbalFilter = 15010, cymbalDucking = 1, level = 1 |

	var lodriver, locutoffenv, hidriver, hicutoffenv, freqs, res, thwack, ducking;
	var amp = Amplitude.ar(in:
		Limiter.ar(in: In.ar(in, 1), level: 1.0 * cymbalDucking, dur: 0.05),
		attackTime: 0.01, releaseTime: 0.3, mul: 1.0, add: 0.0);


	locutoffenv = cymbalFilter;

	lodriver = LPF.ar(WhiteNoise.ar(0.1), locutoffenv);



	hicutoffenv = 10001; //- (EnvGen.ar(Env.perc(1, 3)) * 10000);

	hidriver = HPF.ar(WhiteNoise.ar(0.1), hicutoffenv);

	hidriver = hidriver * EnvGen.ar(Env.perc(1, 0.5, 0.25));



	thwack = EnvGen.ar(Env.perc(0.001,0.001,1));



	freqs  = {exprand(2500, 15000)}.dup(60);

	res    = Ringz.ar(lodriver + hidriver + thwack, freqs).mean;

    ducking = Clip.ar(in: (1 - amp), lo: 0.0, hi: 1.0);

	Out.ar(out, (((res * 1) + (lodriver * 2) + thwack) * 0.01).dup * ducking * level);

}).add;
