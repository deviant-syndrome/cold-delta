// skip if server is running? (reset/free all virtual busses?)
// check media files
// execute bash scripts
// check VSTs
// init channel strips +
// init routing +
// init sync messages / event streams +
// boot server?

Environment.stack = [];

Require("read-config.scd");
Require("events/stopwatch.scd");
Require("conventions.scd");
Require("mixer/channel-strip.scd");
Require("mixer/routing.scd");
Require("instruments/e-drums.scd");
// Require("instruments/bells.scd");
Require("effects/delay.scd");
Require("events/osc-triggers.scd");
Require("media.scd");
Require("instruments/throb-playback.scd");
Require("instruments/throb-listener.scd");
Require("instruments/modeled/calculation.scd");
Require("instruments/modeled/string-test.scd");
Require("instruments/modeled/string_5.scd");
Require("instruments/modeled/string_6.scd");
Require("events/become.scd");
// todo: require a riff dictionary instrad
Require("riffs/intro.scd");
Require("riffs/movement1.scd");

Require("instruments/spectral/builders.scd");
// ~textureSpearBuilder.value("partials/low-res/guitar1.csv", \bowedHell);

Require("behaviours/play-basic-riff.scd");
Require("behaviours/play-movement-1.scd");
Require("behaviours/play-fast.scd");
Require("commutation.scd");


// ~player = Pbind(
// 	// todo: some spectrally morphed-in stuff here
// 	\instrument, Pseq([\steelString5, \steelString6, \steelString5, \steelString6, \steelString6, \steelString6, \steelString6], inf),
// 	\dur, Pseq([0.5, 0.5, 0.5, 0.5, 0.2, 0.2, 0.2], inf),
// 	\fret, Pseq([3, 0, 2, 0, 1, 4, 1], inf),
// 	\amp, Pseq([1, 0.7], inf),
// 	\pm, Pseq([0, 0, 0, 0, 1, 1, 1], inf),
// 	\group, ~globalRouting[\chuggs][\strip],
// 	\out, ~globalRouting[\chuggs][\busNum]
// );

// ~player.play;
topEnvironment.putAll(currentEnvironment.deepCopy);
Environment.make({}).push;
