~partialGen = { | data,
	              ttl,
	              timeScale,
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


		// choose releaseNode
		var ampEnvArray = Env(partialAmpPoints, partialTimePoints, releaseNode: releaseNode.value(partialTimePoints), loopNode: loopNode);
		var freqEnvArray = Env(partialFreqPoints, partialTimePoints, releaseNode: releaseNode.value(partialTimePoints), loopNode: loopNode);

		var ampEnvSig = EnvGen.ar(ampEnvArray, timeScale: timeScale);
		var freqEnvSig = EnvGen.ar(freqEnvArray, timeScale: timeScale);

		var freqModAr = SynthDef.wrap(
			freqModFactory, prependArgs: [i]
        );

		var ampModAr = SynthDef.wrap(
			ampModFactory,  prependArgs: [i]
        );

		FreeSelf.kr(TDelay.kr(DC.kr(1), ttl));

		SinOsc.ar(freqEnvSig * freqModAr, 0, ampEnvSig * ampModAr)
	});
};

  ~noReleaseNode = { | size | nil; };
~loopReleaseNode = { | size | size - 2; };

~simplePartialGen = { | data, ttl | ~partialGen.value(data, ttl, 1, { | i | DC.ar(1) }, { | i | DC.ar(1)}, nil, ~noReleaseNoe ); };

~movingPartialGen = { | data, ttl | ~partialGen.value(data, ttl, 1, { | i | DC.ar(1) }, ~movingParticleEnvelope) };

~loopedPartialGen = { | data, ttl | ~partialGen.value(data, ttl, 1, { | i | DC.ar(1) }, { | i | DC.ar(1)}, 0); } ;

~movingParticleEnvelope = { | i | LFNoise1.ar(0.15 + 0.3.rand) };

~particleFreqVibrato = { | i | }
// todo longest partial kills synth?

// case 1
// on-shot - longest partial kills synth
//

