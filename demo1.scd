(Require("spear.scd");
 Require("e-drums.scd");

~spearBuilder.value(thisProcess.nowExecutingPath.dirname +/+ "/partials/composite1.csv",
	mixin: { DC.ar(0); },
	partialPicker: ~allPartialsPicker
);


)

(postln(thisProcess.nowExecutingPath.dirname))
s.freeAll;
