var e = currentEnvironment;

var modes = 8;

var stringModesGen = { | modeamps, modefreqs, fret |
	Mix.fill( modes, { arg i;
		XLine.ar(1.0,
			Select.kr(fret, modeamps)[i], 2.2 * (6  - i)) * FSinOsc.ar(Select.kr(fret, modefreqs)[i], 0, 1 / modes)
	});
};

var stringModesGenSus = { | modeamps, modefreqs, fret, heck2 |
	Mix.fill( modes, { arg i;
		var env = EnvGen.ar(Env.new([0, 1.0, Select.kr(fret, modeamps)[i]], [0.001, 6.2 * (8  - i)], [0, 3]), gate: heck2);

		env * FSinOsc.ar(Select.kr(fret, modefreqs)[i], 0, 1 / modes)
	});
};


var stringModesGenPart = { | modeamps, modefreqs |
	stringModesGen.value(modeamps, modefreqs, _)
};

var stringModesGenPartSus = { | modeamps, modefreqs, heck2 |
	stringModesGenSus.value(modeamps, modefreqs, _, _)
};

var stringModelBuilder = { | stringNum, modesGen |
	SynthDef(format("steelString%", stringNum).asSymbol, { |
		                       out = 0,
		                       gate = 1,
							   amp = 1,
							   release = 1,
							   fret = 0,
							   stroke = 0,
							   pm = 0,
							   choke = 0 |

		var nonHarm;
		var filterMovement;
		var filterDown;
		var filterUp;
		var res;

		// palm mute
		// lower sustain
		// faster filter close
		var decay = Select.kr(pm, [DC.kr(1.3), DC.kr(0.3)]);
		var sustain = Select.kr(pm, [DC.kr(0.5), DC.kr(0.3)]);
		var closingSpeed = Select.kr(pm, [DC.kr(4.09), DC.kr(0.09)]);

		var env = EnvGen.ar(Env.adsr(0.01, decay, sustain, release), gate, amp,
			doneAction: Select.kr(choke, [Done.freeSelf, Done.freeSelfToHead]));

	  	var sound = SynthDef.wrap(
			modesGen, prependArgs: [fret]
		);

		nonHarm = FreqShift.ar(sound, TRand.ar(2000, 2015, gate)) * 0.005;
		filterDown = XLine.ar(1754, 100 + TRand.ar(0, 200, gate), closingSpeed + TRand.ar(0, 0.03, gate));
		filterUp = XLine.ar(100 + TRand.ar(0, 200, gate), 1754, closingSpeed + TRand.ar(0, 0.03, gate));
		filterMovement = Select.ar(stroke, [filterDown, filterUp]);
		res = DynKlank.ar(`[[51, 85, 365, 500], nil, [0, 0.4, 0.0, 0.15]], (sound + nonHarm)) * 0.003;
		Out.ar(out, HPF.ar(RLPF.ar((res + sound + nonHarm) * env, filterMovement,
			TWChoose.ar(gate, [DC.ar(2.7), DC.ar(7.8)], [0.2, 0.8]) ), 60, 3));
	}).add;
};

var stringModelBuilderSus = { | stringNum, modesGen |
	SynthDef(format("steelStringSus%", stringNum).asSymbol, { |
		                       out = 0,
		                       gate = 1,
							   amp = 1,
							   release = 1,
							   fret = 0,
							   stroke = 0,
							   pm = 0,
							   heck = 0,
							   choke = 0 |

		var nonHarm;
		var filterMovement;
		var filterDown;
		var filterUp;
		var res;

		var decay = Select.kr(pm, [DC.kr(0.2), DC.kr(0.3)]);
		var sustain = Select.kr(pm, [DC.kr(0.4), DC.kr(0.3)]);
		var closingSpeed = Select.kr(pm, [DC.kr(8.09), DC.kr(0.09)]);

		var env = EnvGen.ar(Env.new([0, 1, sustain], [0.01, decay], [0, 3]), Changed.kr(heck), amp);

	  	var sound = SynthDef.wrap(
			modesGen, prependArgs: [fret, heck]
		);

		nonHarm = FreqShift.ar(sound, TRand.ar(2000, 2015, gate)) * 0.005;
		filterDown = EnvGen.ar(Env.new([0, 1754, 100], [0.001, closingSpeed]), gate: Changed.kr(heck));//XLine.ar(1754, 100 + TRand.ar(0, 200, gate), closingSpeed + TRand.ar(0, 0.03, gate));
		filterUp = XLine.ar(100 + TRand.ar(0, 200, gate), 1754, closingSpeed + TRand.ar(0, 0.03, gate));
		filterMovement = Select.ar(stroke, [filterDown, filterUp]);
		res = DynKlank.ar(`[[51, 85, 365, 500], nil, [0, 0.4, 0.0, 0.15]], (sound + nonHarm)) * 0.003;
		Out.ar(out, HPF.ar(RLPF.ar(sound * env, filterMovement,
			TWChoose.ar(gate, [DC.ar(2.7), DC.ar(7.8)], [0.2, 0.8]) ), 60, 3));
	}).add;
};

e[\stringBuilderContext] = { | stringNum, modes, freqs |
					 	stringModelBuilder.value(
					 		stringNum,
					 		stringModesGenPart.value(modes, freqs)
					 	);
						stringModelBuilderSus.value(
					 		stringNum,
					 		stringModesGenPartSus.value(modes, freqs)
					 	);
					};
