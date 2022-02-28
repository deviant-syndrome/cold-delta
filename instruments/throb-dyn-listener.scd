// currentEnvironment.use({
// 	~context.valueEnvir(exec: { | const_THROB_DROP |
// 		SynthDef(\throbListenDyn, { | in = 0 |
// 			var source, trigger;
//
// 			source = In.ar(in, 2);
// 			var trigger = DetectSilence.ar(in: source, amp: 0.5, time: 0.1, doneAction: 0);
// 			// var reset = Onsets.kr(FFT(LocalBuf(512), In.ar(in, 2)), 0.7s);
// 			SendTrig.kr(trigger, 0, const_THROB_DROP);
// 		}).add;
// 	});
// });
