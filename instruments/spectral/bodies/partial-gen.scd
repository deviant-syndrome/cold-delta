~partialGen = { | data,
	              ttl,
                  gate,
	              timeScale = 1,
				  freqScale,
	              freqModFactory,
	              ampModFactory,
	              loopNode = nil,
	              releaseNode
	            |

	var count = data.size.div(3);
	Mix.fill(count, { arg i;
		var access = i * 3;

		var partialTimePoints = data[access];
		var partialFreqPoints = data[access + 1];
		var partialAmpPoints = data[access + 2];

		var ampEnvArray = Env(partialAmpPoints, partialTimePoints,
			releaseNode: releaseNode.value(partialTimePoints.size),
			loopNode: loopNode);

		var freqEnvArray = Env(partialFreqPoints, partialTimePoints,
			releaseNode: releaseNode.value(partialTimePoints.size),
			loopNode: loopNode);

		var ampEnvSig = EnvGen.ar(ampEnvArray, timeScale: timeScale, gate: gate);
		var freqEnvSig = EnvGen.ar(freqEnvArray, timeScale: timeScale, gate: gate) * freqScale;

		var freqModAr = SynthDef.wrap(
			freqModFactory, prependArgs: [i]
        );

		var ampModAr = SynthDef.wrap(
			ampModFactory,  prependArgs: [i]
        );
		FSinOsc.ar(freqEnvSig * freqModAr, 0, ampEnvSig * ampModAr)
	});
};

~noReleaseNode   = { | size | nil; };
~loopReleaseNode = { | size | size - 2; };

~simplePartialGen = { | data, ttl, gate |
	~partialGen.value(data, ttl, gate, 1, 1, { | i | DC.ar(1) }, { | i | DC.ar(1)}, nil, ~noReleaseNode ); };

~movingPartialGen = { | data, ttl, gate, timeScale, freqScale = 1 |
	~partialGen.value(data, ttl, gate, timeScale, freqScale, { | i | DC.ar(1) }, ~movingParticleEnvelope) };

~movingLoopingPartialGen = { | data, ttl, gate |
	~partialGen.value(data, ttl, gate, 1, { | i | DC.ar(1) }, ~movingParticleEnvelope, 0, ~loopReleaseNode) };


~loopedPartialGen = { | data, ttl, gate |
	~partialGen.value(data, ttl, gate, 1, { | i | DC.ar(1) }, { | i | DC.ar(1)}, 0, ~loopReleaseNode ); } ;

~movingParticleEnvelope = { | i | LFNoise1.ar(0.15 + 0.3.rand) };

~particleFreqVibrato = { | i | }
