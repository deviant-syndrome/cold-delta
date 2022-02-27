(var radius = 0.0179;
// String 5 should be F# for the C# (!) standard tuning
var frets = [[0.837, 133.5],  // F#
		     [0.793, 140.1],  // G
		     [0.779, 144.5],  // G#
		     [0.737, 146.9],  // A
		     [0.695, 148.9]   // A#
		    ];

var numPositions = 5;

var modeamps = Array.newClear(numPositions);
var modefreqs = Array.newClear(numPositions);


topEnvironment.use({
	~calculationContext.valueEnvir(exec: { | calculation |
		numPositions.do { arg i;
		   var c = calculation.value(length: frets[i][0], beating: frets[i][1], radius: radius);
		   modeamps[i] = c[\modeamps];
		   modefreqs[i] = c[\modefreqs];
		};
	});
});


////
SynthDef(\steelString5, { |
						 out = 0,
						 gate = 1,
						 amp = 1,
						 release = 1,
						 fret = 0,
						 stroke = 0 |

var nonHarm;
var filterMovement;
var filterDown;
var filterUp;
var res;

var modes = 8;

var env = EnvGen.ar(Env.adsr(0.01, 1.3, 0.5, release), gate, amp, doneAction: Done.freeSelf);
  var sound = Mix.fill( modes, { arg i;
  XLine.ar(1.0, Select.kr(fret, modeamps)[i], 2.2 * (6  - i)) * FSinOsc.ar(Select.kr(fret, modefreqs)[i], 0, 1 / modes)
  });
// todo:
// add release handling for damping effect
// add randomness to frequency damping
// add weighted randmomness for odd strokes
// add random noise
// add randomize envelope
// for longer strokes the high-freq energy should dissipate slower
// FIlter Q: find a sweet spot + one ringing extremity + one dead extremity
// When playing fast palm-mutes - less Q, less hi-freqs
// a little timing fluctuation?
nonHarm = FreqShift.ar(sound, TRand.ar(2000, 2015, gate)) * 0.005;
filterDown = XLine.ar(1754, 100 + TRand.ar(0, 200, gate), 4.09 + TRand.ar(0, 0.03, gate));
filterUp = XLine.ar(100 + TRand.ar(0, 200, gate), 1754, 0.09 + TRand.ar(0, 0.03, gate));
filterMovement = Select.ar(stroke, [filterDown, filterUp]);
res = DynKlank.ar(`[[51, 85, 365, 500], nil, [0, 0.4, 0.0, 0.15]], (sound + nonHarm)) * 0.003;
Out.ar(out, HPF.ar(RLPF.ar((res + sound + nonHarm) * env, filterMovement, TWChoose.ar(gate, [DC.ar(2.7), DC.ar(7.8)], [0.2, 0.8]) ), 60, 3));
}).add;)
