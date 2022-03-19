var radius = 0.021;

var frets = [[0.942, 100],     // C#
             [0.909, 110],     // D
		     [0.856, 116],     // D#
		     [0.813, 125],     // E
		     [0.763, 129]];    // F


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
	~stringBuilderContext.value(6, modeamps, modefreqs);
});
