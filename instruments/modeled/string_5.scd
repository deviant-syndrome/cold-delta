var radius = 0.0179;
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

Require("string-builder.scd");

topEnvironment.use({
	~stringBuilderContext.value(5, modeamps, modefreqs);
});
