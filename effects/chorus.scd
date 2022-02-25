SynthDef(\chorus, {
	var source;
	var fx;
	var n = 2;

	source = In.ar(0, 2);

	Out.ar(0, Mix.fill(n, {

		var maxdelaytime = rrand(0.01, 0.03);
		var half = maxdelaytime * 0.5;
		var quarter = maxdelaytime * 0.25;

		DelayC.ar(source, maxdelaytime, LFNoise1.kr(Rand(5, 10), 0.01, 0.02) )

	}) * 0.1);
}).add;
