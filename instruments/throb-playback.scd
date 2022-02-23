currentEnvironment.use({

	~mediaContext.valueEnvir(exec: { | const_THROB_BUF |
		var b = const_THROB_BUF;

		SynthDef(\throbBlast, { | out = 0, offsetSeconds = 0, freeze = 0 |
			var snd, reset;
			var buf = LocalBuf(44100 * 0.5, 1);

			snd = PlayBuf.ar(1, b, BufRateScale.kr(b), startPos: SampleRate.ir * offsetSeconds, loop: 1);
			reset = Onsets.kr(FFT(LocalBuf(512), snd), 0.7);

			BufWr.ar(snd, buf, Phasor.ar(reset, 1, 0, BufFrames.kr(buf)));

			snd = DelayC.ar(snd, 0.2, 0.2);
			snd = Select.ar(freeze, [snd, PlayBuf.ar(1, buf, BufRateScale.kr(buf), loop: 1)]);

			Out.ar(out, snd ! 2 * 0.25);
		}).add;
	});
})
