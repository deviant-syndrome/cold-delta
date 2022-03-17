SynthDef(\throbListenLookAhead, { | in = 0 |
	var reset;
	var trackb,trackh,trackq,tempo;
	var source, beep;
	var slopeanalysis;
	var beatanalysis;
	var bsound, hsound, qsound;
	var dynanalysis;
	var stopw;

	source = In.ar(in, 1);

	#trackb,trackh,trackq,tempo = DrumTrack.kr(source, 0,
		kicksensitivity: 0.91,
		snaresensitivity: 0.8,
		debugmode: 2);

	slopeanalysis = Latch.kr(
		Clip.kr(Slope.kr(
			Slope.kr(in: Latch.kr(Timer.kr(trig: trackq),
			Impulse.kr(25)), mul: 1.0, add: 0.0)), -10, 10),
			Impulse.kr(2));

			stopw = Timer.kr(trig: Changed.kr(slopeanalysis));
			Poll.kr(Changed.kr(slopeanalysis), stopw);


		bsound= Pan2.ar(LPF.ar(WhiteNoise.ar*(Decay.kr(trackb,0.05)),1000),0.0);

		hsound= Pan2.ar(BPF.ar(WhiteNoise.ar*(Decay.kr(trackh,0.05)),3000,0.66),-0.5);

		qsound= Pan2.ar(HPF.ar(WhiteNoise.ar*(Decay.kr(trackq,0.05)),5000),0.5);


	SendTrig.kr(Changed.kr(slopeanalysis), id: 1, value: 488.0);
}).add;
