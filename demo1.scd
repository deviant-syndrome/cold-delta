(var kickPattern; var ridePattern;
 //Quarks.load(thisProcess.nowExecutingPath.dirname +/+ "quarks.txt");
 Require("spear.scd");
 Require("e-drums.scd");
 Require("spear-rand-partials.scd");
 Require("e-pattern.scd");
 Require("pat-utils.scd");


~randomTextureSpearBuilder.value("/partials/low-res/composite1.csv", "texture1", 20);


kickPattern = ~loopForever.value({ ~pat8ths.value([1,0,1,0,1,0]); });
ridePattern = ~loopForever.value({ |i| ~pat8ths.value(~getPattern.value(8 - i,3 + i.rand)); });

~player = Pspawner({|sp|
	sp.seq(Ppar([
		Pbind(
			\instrument, "texture1",
			\dur, inf,
			\amp, 0.2
		),
		Pbind(
			\instrument, "texture2",
			\dur, Pseq([4, 4, 8, 16, 4], inf)
		 ),
		 Pbind(
		 	\instrument, \kick,
		 	\dur, kickPattern,
		 	\amp, 0.1
		 ),
		 Pbind(
		 	\instrument, \snare,
		 	\dur, ridePattern,
		 	\amp, 0.05
		 )
	]));
}).play;

)


~player.stop();

s.options.maxLogins = 2;
s.reboot;
s.freeAll;
s.defaultGroups;

(
r = Server(
    \remote4,
    // example NetAddr of the machine that runs scsynth on standard port
    NetAddr("127.0.0.1", 57110),
    s.options,        // make sure all remote servers use the same options
    1                 // and when desired, set fixed client by hand
);
)