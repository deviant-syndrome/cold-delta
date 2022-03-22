~globalRouting[\throbe][\jack].value(\throbBlast);

currentEnvironment.use({
	~conventionsContext.valueEnvir(exec: { |
		                                     const_THROB_SPARSE_SET,
											 const_THROB_SET,
				                             const_THROB_BEAT,
								             const_THROB_SPEEDUP,
								             const_THROB_SPEEDDOWN |

		~globalRouting[\throbe][\send].value(\throbListenHigh,
			[
				\onSetSignal, const_THROB_SET,
				\onBeatSignal, const_THROB_BEAT,
				\speedUpSignal, const_THROB_SPEEDUP,
				\speedDownSignal, const_THROB_SPEEDDOWN,
				\onSparseSetSignal, const_THROB_SPARSE_SET
			]);
	});
});

// ~globalRouting[\throbe][\gain].set(\gains, 0.0); // debug

// ~globalRouting[\throbe][\send].value(\cymbalTexture, [\out, ~globalRouting[\cymbals][\busNum]]);

~globalRouting[\throbLookAhead][\jack].value(\throbBlast, [\offsetSeconds, 0.0]);
~globalRouting[\throbLookAhead][\send].value(\throbListenLookAhead);
~globalRouting[\throbLookAhead][\gain].set(\gains, 0.0);


~globalRouting[\chuggs][\gain].set(\gains, 0.3);
~globalRouting[\chuggs][\gain].set(\pos, -1);

~configContext.valueEnvir(exec: { | config |
	currentEnvironment.use({
		~globalRouting[\chuggs][\vstInsert].value(config["vst"]["cabsim.path"], false);
		~globalRouting[\chuggs][\vstInsert].value(config["vst"]["ampsim.path"], true);
	});
});

~globalRouting[\synth1][\send].value(\reverb);
~globalRouting[\synth1][\send].value(\delayLine);
~globalRouting[\synth1][\gain].set(\gains, 0.5);
