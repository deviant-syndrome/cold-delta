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
Require("conventions.scd");
Require("events/*");
Require("mixer/*");
Require("effects/*");
Require("media.scd");
Require("instruments/*");
Require("instruments/modeled/*");
Require("riffs/*");
Require("behaviours/*");
Require("commutation.scd");

topEnvironment.putAll(currentEnvironment.deepCopy);
Environment.make({}).push;
