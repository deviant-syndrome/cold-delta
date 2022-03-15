// todo: instead of using a constant here
//        move it to synth params
//        use the context in the routing setup

currentEnvironment.use({
	~context.valueEnvir(exec: { | const_HI_THROB |
		SynthDef(\throbListenLookAhead, { | in = 0 |
			var reset;
			var trackb,trackh,trackq,tempo;
			var source, beep;
			var slopeanalysis;
			var beatanalysis;
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
					Impulse.kr(15)), mul: 1.0, add: 0.0)), -10, 10),
					Impulse.kr(2));
					
			stopw = Timer.kr(trig: Changed.kr(slopeanalysis));

			SendTrig.kr(InRange.kr(in: stopw, lo: 2.7, hi: 7), id: 1, value: stopw);

		}).add;
	});
});
