// skip if server is running
// check media files
// execute bash scripts
// check VSTs
// init channel strips
// init routing
// init sync messages / event streams
// boot server
Require("mixer/channel-strip.scd");

~initChannelStrip.value();

Require("mixer/routing.scd");

//Require("gui.scd");
