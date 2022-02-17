~spearStrumPartials = { | fileName |

	var path = thisProcess.nowExecutingPath.dirname +/+ fileName;
	var data = CSVFileReader.readInterpret(path);
	var count = Array.fill(data.size.div(3), { arg i; [i * 3, i * 3 + 1, i * 3 + 2] });
	var foo = 0;
	var pbinds = Array.newClear(data.size.div(3));

	count.do({ arg accessor, partNum;
		var particleBind;
		var partialTimePoints = data[accessor[0]];
		var partialFreqPoints = data[accessor[1]];
		var partialAmpPoints = data[accessor[2]];

		var timeSize = partialTimePoints.size;
		var valSize = partialFreqPoints.size;

		var synthName = \partial_ ++ partNum;

		SynthDef(synthName, { | gate = 1 |
			var masterEnv = EnvGen.ar(Env.adsr(0.2, 4, 0.4, 5.5, 0.5), gate, doneAction: 2);

			var ampEnvArray = Env(partialAmpPoints, partialTimePoints, releaseNode: partialTimePoints.size - 2, loopNode: 0);
			var freqEnvArray = Env(partialFreqPoints, partialTimePoints, releaseNode: partialTimePoints.size - 2, loopNode: 0);


			var ampEnvSig = EnvGen.ar(ampEnvArray, timeScale: 0.5);
			var freqEnvSig = EnvGen.ar(freqEnvArray, timeScale: 0.5);
			Out.ar(0, HPF.ar(FSinOsc.ar(freqEnvSig * 0.5, 0, ampEnvSig * masterEnv), 100) ! 2)
		}).add;

		particleBind = Pbind(
			\instrument, synthName,
			\dur, Pn(8, 1)
		);

		pbinds[partNum] = particleBind;

	});

	{ | executor |
		pbinds.do { |pb|
			executor.par(
				pb
			);

			executor.wait(0.4)
		};
	}
};
