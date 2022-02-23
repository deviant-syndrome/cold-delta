Require("stopwatch.scd");
Require("../riffs/basic.scd");

// todo: use dependency inversion here
//       instead of adding a global variable
//       pass the handlerMananger as context
//       and register function in it

// also, probably should remove this class altogheher
~hiThrobHandler = { | msg, time |
    ~behaviour[\onTick].value(time);
}
