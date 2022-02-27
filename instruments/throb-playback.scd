currentEnvironment.use({

	~stutter = { |snd, reset, fragmentlength, rate = 1.0, maxdelay = 10|
	    var phase, fragment, del;
	    phase = Sweep.ar(reset);
	    fragment = { |ph| (ph - Delay1.ar(ph)) < 0 + Impulse.ar(0) }.value(phase / fragmentlength % 1);
	    del = Latch.ar(phase, fragment) + ((fragmentlength - Sweep.ar(fragment)) * (rate - 1));
	    DelayC.ar(snd, maxdelay, del);
	};

	~mediaContext.valueEnvir(exec: { | const_THROB_BUF |
		var b = const_THROB_BUF;

		SynthDef(\throbBlast, { | out = 0, offsetSeconds = 0, freeze = 0 |
			var snd, reset;
			var buf = LocalBuf(44100 * 0.5, 1);

			snd = PlayBuf.ar(1, b, BufRateScale.kr(b), startPos: SampleRate.ir * offsetSeconds, loop: 1);

			reset = Onsets.kr(FFT(LocalBuf(512), snd), 0.7);
 			// snd = ~stutter.value(snd, reset, 0.09);

			BufWr.ar(snd, buf, Phasor.ar(reset, 1, 0, BufFrames.kr(buf)));

			snd = DelayC.ar(snd, 0.2, 0.2);
			snd = Select.ar(freeze, [snd, PlayBuf.ar(1, buf, BufRateScale.kr(buf), loop: 1)]);

			Out.ar(out, snd ! 2 * 0.25);
		}).add;
	});
})
