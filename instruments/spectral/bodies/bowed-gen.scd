~bowedGen = { | data,
	              ttl,
                  gate,
	              timeScale = 1,
	              freqModFactory,
	              ampModFactory,
	              loopNode = nil,
	              releaseNode,
	              force=1,
	              pos=0.07,
	              c1=0.25,
	              c3=31,
	              pan=0
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
		var freqEnvSig = EnvGen.ar(freqEnvArray, timeScale: timeScale, gate: gate);

		var freqModAr = SynthDef.wrap(
			freqModFactory, prependArgs: [i]
        );

		var ampModAr = SynthDef.wrap(
			ampModFactory,  prependArgs: [i]
        );

		var vib = Gendy1.kr(1,1,1,1,0.1, 4,mul:0.003,add:1);

		var chain, trig;
    // Define the bow envelope inside
		// var ppos = Linen.kr(gate: 1.0, attackTime: 140.0, susLevel: 1.0, releaseTime: 0.01, doneAction: 0);
		var son = DWGBowed.ar(Fold.ar(in: freqEnvSig * vib, lo: 440, hi: 14000), 0.5, 0.7, gate, 0.14, 0.1, c1, c3);
		son = DWGSoundBoard.ar(son);
		son = BPF.ar(son,118,1)+son;
		son = BPF.ar(son,430,1)+son;
		son = BPF.ar(son,490,1)+son;
		son = LPF.ar(son,6000);

		son * ampEnvSig;

		// chain = FFT(LocalBuf(2048), son * ampEnvSig);
		// chain = PV_BinScramble(chain, TWChoose.ar(LFPulse.ar(10), [DC.ar(0), LFNoise0.ar(0.4)], [0.70, 0.30].normalizeSum), 0.1, 0);
		// IFFT(chain) * 0.5;
	});
};

~loopedBowedGen = { | data, ttl, gate |
	~bowedGen.value(data, ttl, gate, 1, { | i | DC.ar(1) }, { | i | DC.ar(1)}, 0, ~loopReleaseNode ); } ;
