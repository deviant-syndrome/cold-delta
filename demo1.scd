(//Quarks.load(thisProcess.nowExecutingPath.dirname +/+ "quarks.txt");

 Require("spear.scd");
 Require("e-drums.scd");
 Require("spear-rand-partials.scd");


/*
~spearBuilder.value("/partials/low-res/composite1.csv",
	mixin: { DC.ar(0); },
	partialPicker: ~randomPartialPicker.value(16),
	partialGen: ~simplePartialGen
);
*/

~singleSpearBuilder.value("/partials/low-res/snare.csv");


)




s.freeAll;
