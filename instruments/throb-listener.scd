// todo: instead of using a constant here
//        move it to synth params
//        use the context in the routing setup

currentEnvironment.use({
	~context.valueEnvir(exec: { | const_HI_THROB |
		SynthDef(\throbListenHigh, { | in = 0 |
			var reset;
			var trackb, trackh, trackq, tempo;
			var source, beep;
			var bsound, hsound, qsound;
			var slopeanalysis;
			var beatanalysis;
			var dynanalysis;

			source = In.ar(in, 1);

			#trackb,trackh,trackq,tempo = DrumTrack.kr(source, 0,
				kicksensitivity: 0.91,
				snaresensitivity: 0.8,
				debugmode: 2);

			reset = Onsets.kr(FFT(LocalBuf(512), In.ar(in, 2)), 0.7);
			SendTrig.kr(reset, 0, const_HI_THROB);

			SendTrig.kr(trackb, 0, 777.0);
			slopeanalysis = Slope.kr(Latch.kr(in: tempo, trig: Impulse.kr(1)));


			SendTrig.kr(InRange.kr(in: slopeanalysis, lo: 400, hi: 1000), 0, 778.0);
			SendTrig.kr(InRange.kr(in: slopeanalysis, lo: -1000, hi: -200), 0, 779.0);

			bsound= Pan2.ar(LPF.ar(WhiteNoise.ar*(Decay.kr(trackb,0.01)),1000),0.0);
			hsound= Pan2.ar(BPF.ar(WhiteNoise.ar*(Decay.kr(trackh,0.01)),3000,0.66),-0.5);

			qsound= Pan2.ar(HPF.ar(WhiteNoise.ar*(Decay.kr(trackq,0.01)),5000),0.5);

		}).add;
	});
});


SynthDef(\throbListenHigh2, { | in = 0,
	                            onSetSignal     = 1,
								onBeatSignal    = 2,
								speedUpSignal   = 3,
								speedDownSignal = 4
							  |
	var reset;
	var trackb, trackh, trackq, tempo;
	var source, beep;
	var bsound, hsound, qsound;
	var slopeanalysis;
	var beatanalysis;
	var dynanalysis;

	source = In.ar(in, 1);

	#trackb,trackh,trackq,tempo = DrumTrack.kr(source, 0,
		kicksensitivity: 0.91,
		snaresensitivity: 0.8,
		debugmode: 2);

	reset = Onsets.kr(FFT(LocalBuf(512), In.ar(in, 2)), 0.7);
	SendTrig.kr(reset, 0, onSetSignal);

	SendTrig.kr(trackb, 0, onBeatSignal);
	slopeanalysis = Slope.kr(Latch.kr(in: tempo, trig: Impulse.kr(1)));


	SendTrig.kr(InRange.kr(in: slopeanalysis, lo: 400, hi: 1000), 0, speedDownSignal);
	SendTrig.kr(InRange.kr(in: slopeanalysis, lo: -1000, hi: -200), 0, 779.0);

	bsound= Pan2.ar(LPF.ar(WhiteNoise.ar*(Decay.kr(trackb,0.01)),1000),0.0);
	hsound= Pan2.ar(BPF.ar(WhiteNoise.ar*(Decay.kr(trackh,0.01)),3000,0.66),-0.5);

	qsound= Pan2.ar(HPF.ar(WhiteNoise.ar*(Decay.kr(trackq,0.01)),5000),0.5);

}).add;
