// skip if server is running? (reset/free all virtual busses?)
// check media files
// execute bash scripts
// check VSTs
// init channel strips +
// init routing +
// init sync messages / event streams +
// boot server
Require("conventions.scd");
Require("mixer/channel-strip.scd");

~initChannelStrip.value();

Require("mixer/routing.scd");
Require("instruments/e-drums.scd");
Require("events/osc-triggers.scd");
Require("media.scd");
Require("instruments/throb-playback.scd");
Require("instruments/throb-listener.scd");
//Require("gui.scd");
