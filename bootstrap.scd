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
Require("instruments/bells.scd");
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

Require("instruments/spectral/builders.scd");
// ~textureSpearBuilder.value("partials/low-res/guitar1.csv", \bowedHell);

Require("behaviours/play-basic-riff.scd");
Require("commutation.scd");

~player = Pbind(
	\instrument, Pseq([\steelString5, \steelString6], inf),
	\dur, 0.5,
	\fret, Pseq([3, 0, 2, 0], inf),
	\amp, Pseq([1, 0.7], inf),
	\group, ~globalRouting[\chuggs][\strip],
	\out, ~globalRouting[\chuggs][\busNum]
);

~player.play;
topEnvironment.putAll(currentEnvironment.deepCopy);
Environment.make({}).push;
