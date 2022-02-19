(var kickPattern; var ridePattern; var strum;
 //Quarks.load(thisProcess.nowExecutingPath.dirname +/+ "quarks.txt");
 Require("instruments/spectral/spear.scd");
 Require("instruments/e-drums.scd");
 Require("instruments/spectral/spear-rand-partials.scd");
 Require("e-pattern.scd");
 Require("pat-utils.scd");
 Require("instruments/spectral/spear-strum.scd");


// ~randomTextureSpearBuilder.value("/partials/low-res/composite1.csv", "texture1", 20);
~textureBowedSpearBuilder.value("/partials/low-res/guitar1.csv", "texture2", 20);
//
//strum = ~spearStrumPartials.value("/partials/hi-res/choir1.csv");

kickPattern = ~loopForever.value({ ~pat8ths.value([1,0,1,0,1,0]); });
ridePattern = ~loopForever.value({ |i| ~pat8ths.value(~getPattern.value(8 - i,3 + i.rand)); });

~player = Pspawner({|sp|
	sp.wait(1);

	//strum.value(sp);


	sp.seq(Ppar([
		// Pbind(
		// 	\instrument, "texture1",
		// 	\dur, inf,
		// 	\amp, 0.2
		// ),

		Pbind(
			\instrument, "texture2",
			\dur, Pseq([4, 4, 8, 16, 4], 1)
		 ),
		// Pbind(
		// 	\instrument, \kick,
		// 	\dur, kickPattern,
		// 	\amp, 0.1
		// ),
		// Pbind(
		// 	\instrument, \snare,
		// 	\dur, ridePattern,
		// 	\amp, 0.05
		// )
	]));
}).play;

)

//Use it.


~pleayer.stop();
s.freeAll;
