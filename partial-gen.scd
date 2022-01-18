~partialGen = { | data,
	              timeScale,
	              freqModFactory,
	              ampModFactory
	            |

	var count = data.size.div(3);
	Mix.fill(count, { arg i;
		var access = i * 3;

		var partialTimePoints = data[access];
		var partialFreqPoints = data[access + 1];
		var partialAmpPoints = data[access + 2];


		var ampEnvArray = Env(partialAmpPoints, partialTimePoints);
		var freqEnvArray = Env(partialFreqPoints, partialTimePoints);

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

~simplePartialGen = { | data | ~partialGen.value(data, 1, { | i | DC.ar(1)}, { | i | DC.ar(1)} ); }

~movingParticleEnvelope = { }

~particleFreqVibrato = { }