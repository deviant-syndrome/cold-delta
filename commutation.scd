// todo: rewrite with contexts instead


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

~globalRouting[\throbe][\send].value(\cymbalTexture, [\out, ~globalRouting[\cymbals][\busNum]]);

~globalRouting[\throbLookAhead][\jack].value(\throbBlast, [\offsetSeconds, 0]);
~globalRouting[\throbLookAhead][\send].value(\throbListenLookAhead);
~globalRouting[\throbLookAhead][\gain].set(\gains, 0.0);


~globalRouting[\chuggs][\gain].set(\gains, 0.3);
~globalRouting[\chuggs][\gain].set(\pos, -1);

~globalRouting[\chuggs][\vstInsert].value("/Library/Audio/Plug-Ins/VST3/NadIR.vst3", false);
~globalRouting[\chuggs][\vstInsert].value("/Library/Audio/Plug-Ins/VST3/Emissary.vst3", true);

~globalRouting[\synth1][\send].value(\delayLine);
