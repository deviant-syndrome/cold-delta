currentEnvironment.use({
	~context.valueEnvir(exec: { | const_HI_THROB |
		SynthDef(\throbListenHigh, { | in = 0 |

			var reset = Onsets.kr(FFT(LocalBuf(512), In.ar(in, 2)), 0.7);

			SendTrig.kr(reset, 0, const_HI_THROB);
		}).add;
	});
});
