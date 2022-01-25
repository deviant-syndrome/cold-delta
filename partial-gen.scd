~partialGen = { | data,
	              timeScale,
	              freqModFactory,
	              ampModFactory,
	              loopNode = nil
	            |

	var count = data.size.div(3);
	Mix.fill(count, { arg i;
		var access = i * 3;

		var partialTimePoints = data[access];
		var partialFreqPoints = data[access + 1];
		var partialAmpPoints = data[access + 2];


		// choose releaseNode
		var ampEnvArray = Env(partialAmpPoints, partialTimePoints, releaseNode: partialTimePoints.size - 2, loopNode: loopNode);
		var freqEnvArray = Env(partialFreqPoints, partialTimePoints, releaseNode: partialTimePoints.size - 2, loopNode: loopNode);

		var ampEnvSig = EnvGen.ar(ampEnvArray, timeScale: timeScale);
		var freqEnvSig = EnvGen.ar(freqEnvArray, timeScale: timeScale);

		var freqModAr = SynthDef.wrap(
			freqModFactory, prependArgs: [i]
        );

		var ampModAr = SynthDef.wrap(
			ampModFactory,  prependArgs: [i]
        );

		SinOsc.ar(freqEnvSig * freqModAr, 0, ampEnvSig * ampModAr)
	});
};



~simplePartialGen = { | data | ~partialGen.value(data, 1, { | i | DC.ar(1) }, { | i | DC.ar(1)} ); };
~movingPartialGen = { | data | ~partialGen.value(data, 1, { | i | DC.ar(1) }, ~movingParticleEnvelope) };

~loopedPartialGen = { | data | ~partialGen.value(data, 1, { | i | DC.ar(1) }, { | i | DC.ar(1)}, 0); } ;

~movingParticleEnvelope = { | i | LFNoise1.ar(0.15 + 0.3.rand) };

// ~particleFreqVibrato = { }
// todo longest partial kills synth?

