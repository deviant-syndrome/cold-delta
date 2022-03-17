SynthDef(\throbListenHigh, { | in = 0,
	                            onSetSignal       = 1,
								onBeatSignal      = 2,
								speedUpSignal     = 3,
								speedDownSignal   = 4,
								onSparseSetSignal = 5
							  |
	var reset, sparseDetect;
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


	sparseDetect = PV_JensenAndersen.ar(FFT(LocalBuf(2048), source), threshold: 0.1);
	SendTrig.ar(sparseDetect, 0, onSparseSetSignal);

	SendTrig.kr(trackq, 0, onBeatSignal);
	slopeanalysis = Slope.kr(Latch.kr(in: tempo, trig: Impulse.kr(1)));


	SendTrig.kr(InRange.kr(in: slopeanalysis, lo: 400, hi: 1000), 0, speedUpSignal);
	SendTrig.kr(InRange.kr(in: slopeanalysis, lo: -1000, hi: -200), 0, speedDownSignal);
	//
	// bsound= Pan2.ar(LPF.ar(WhiteNoise.ar*(Decay.kr(trackb,0.05)),1000),0.0);
	//
	// hsound= Pan2.ar(BPF.ar(WhiteNoise.ar*(Decay.kr(trackh,0.05)),3000,0.66),-0.5);
	//
	// qsound= Pan2.ar(HPF.ar(WhiteNoise.ar*(Decay.kr(trackq,0.05)),5000),0.5);

	// Out.ar(0, (bsound+hsound+qsound) * 0.5);

}).add;
