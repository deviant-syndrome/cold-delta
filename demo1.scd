(var kickPattern; var ridePattern;
 //Quarks.load(thisProcess.nowExecutingPath.dirname +/+ "quarks.txt");
 Require("spear.scd");
 Require("e-drums.scd");
 Require("spear-rand-partials.scd");
 Require("e-pattern.scd");
 Require("pat-utils.scd");


/*
~spearBuilder.value("/partials/low-res/composite1.csv",
	mixin: { DC.ar(0); },
	partialPicker: ~randomPartialPicker.value(16),
	partialGen: ~simplePartialGen
);
*/

//~singleSpearBuilder.value("/partials/low-res/snare.csv");

kickPattern = ~loopForever.value({ ~pat8ths.value([1,0,1,0,1,0]); });
ridePattern = ~loopForever.value({ |i| ~pat8ths.value(~getPattern.value(8 - i,3)); });

~player = Pspawner({|sp|
	// play looped Spear pad here
	sp.seq(Ppar([
		Pbind(
			\instrument, \kick,
			\dur, kickPattern
		),
		Pbind(
			\instrument, \ride,
			\dur, ridePattern
	    )
	]));
}).play;

)

~player.stop();

s.freeAll;
