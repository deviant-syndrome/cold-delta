// todo: instead of using a constant here
//        move it to synth params
//        use the context in the routing setup

currentEnvironment.use({
	~context.valueEnvir(exec: { | const_HI_THROB |
		SynthDef(\throbListenHigh, { | in = 0 |
			var reset;
			var trackb,trackh,trackq,tempo;
			var source, beep;
			var bsound,hsound,qsound;

			source = In.ar(in, 1);

			#trackb,trackh,trackq,tempo = DrumTrack.kr(source, 0,
				kicksensitivity: 0.91,
				snaresensitivity: 0.8,
				debugmode: 2);

			reset = Onsets.kr(FFT(LocalBuf(512), In.ar(in, 2)), 0.7);
			SendTrig.kr(reset, 0, const_HI_THROB);

			SendTrig.kr(trackb, 0, 777.0);

			// bsound= Pan2.ar(LPF.ar(WhiteNoise.ar*(Decay.kr(trackb,0.01)),1000),0.0);
			//
			// hsound= Pan2.ar(BPF.ar(WhiteNoise.ar*(Decay.kr(trackh,0.01)),3000,0.66),-0.5);
			// Poll.kr(Impulse.kr(2), tempo);
			qsound= Pan2.ar(HPF.ar(WhiteNoise.ar*(Decay.kr(trackq,0.01)),5000),0.5);

			// Out.ar(0, (qsound) * 0.5);
			// beep = SinOsc.ar(1000,0.0, Decay.kr(trackh, 0.01));
			// Poll.kr(Impulse.kr(2), DrumTrack.kr(source, 0,
			// 	kicksensitivity: 0.91,
			// 	snaresensitivity: 1.0));
			// Out.ar(0, Pan2.ar((0.5 * beep), 0.0));


		}).add;
	});
});
