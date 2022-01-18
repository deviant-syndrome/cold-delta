(//Quarks.load(thisProcess.nowExecutingPath.dirname +/+ "quarks.txt");

 Require("spear.scd");
 Require("e-drums.scd");


/*~spearBuilder.value("/partials/composite1.csv",
	mixin: { DC.ar(0); },
	partialPicker: ~randomPartialPicker.value(64)
);*/
~singleSpearBuilder.value("/partials/snare.csv");


)


s.freeAll;
