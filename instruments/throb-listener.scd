currentEnvironment.use({
	~context.valueEnvir(exec: { | const_HI_THROB |
		SynthDef(\throbListenHigh, { | in = 0 |

			var trackb,trackh,trackq,tempo;
			var source, beep;

			source= In.ar(in, 2); //PlayBuf.ar(1,b.bufnum,1.0,1,0,1);

			#trackb,trackh,trackq,tempo=DrumTrack.kr(source, 0, kicksensitivity:0.91,snaresensitivity:0.5,debugmode:2);

			beep= SinOsc.ar(1000,0.0,Decay.kr(trackh,0.01));
			Poll.kr(Impulse.kr(2), trackh);
			Out.ar(0,Pan2.ar((0.5*beep),0.0));

			// var reset = Onsets.kr(FFT(LocalBuf(512), In.ar(in, 2)), 0.7s);

			// SendTrig.kr(reset, 0, const_HI_THROB);
		}).add;
	});
});
