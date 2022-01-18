~spearBuilder = { | fileName,
	                mixin,
	                partialPicker,
		            attack = 0.2,
	                decay = 4,
	                sustain = 0.4,
	                release = 0.5
	              |

	var initialData = CSVFileReader.readInterpret(fileName);
	var data = partialPicker.value(initialData);
	var count = data.size.div(3);

	SynthDef(\heck, { | gate = 1 |
		var env = EnvGen.ar(Env.adsr(attack, decay, sustain, release), gate, doneAction: 2);

		var partial = Mix.fill(count, { arg i;
			var access = i * 3;

			var partialTimePoints = data[access];
			var partialFreqPoints = data[access + 1];
			var partialAmpPoints = data[access + 2];


			var ampEnvArray = Env(partialAmpPoints, partialTimePoints);
			var freqEnvArray = Env(partialFreqPoints, partialTimePoints);

			var ampEnvSig = EnvGen.ar(ampEnvArray, timeScale: 1);
			var freqEnvSig = EnvGen.ar(freqEnvArray, timeScale: 1);
			SinOsc.ar(freqEnvSig, 0, ampEnvSig)
		});
		var transient = SynthDef.wrap(
            mixin
        );

		Out.ar(0, ((partial + transient) * env) ! 2);
	}).play;
};

~singleSpearBuilder = { | fileName |
	~spearBuilder.value(fileName,
		mixin: { DC.ar(0); },
		partialPicker: ~allPartialPicker
	);
};

~allPartialsPicker = { | data |
   data;
};

// modulationg with partials:

// 1. design a synth-pad
// 2. N synth pad, each pad it modulated by a particle
// technical: synthdef wrapping? 