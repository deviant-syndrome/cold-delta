// todo: use dependency inversion here
//       instead of adding a global variable
//       pass the handlerMananger as context
//       and register function in it

// also, probably should remove this class altogheher


// var player = Pbind(
// 	// todo: some spectrally morphed-in stuff here
// 	\instrument, Pseq([\steelString5, \steelString6, \steelString5, \steelString6, \steelString6, \steelString6, \steelString6], inf),
// 	\dur, Pseq([0.5, 0.5, 0.5, 0.5, 0.2, 0.2, 0.2], inf),
// 	\fret, Pseq([3, 0, 2, 0, 1, 4, 1], inf),
// 	\amp, Pseq([1, 0.7], inf),
// 	\pm, Pseq([0, 0, 0, 0, 1, 1, 1], inf),
// 	\group, ~globalRouting[\chuggs][\strip],
// 	\out, ~globalRouting[\chuggs][\busNum]
// ).asStream;
//

~hiThrobHandler = { | msg, time |
//    player.next(Event.new).play;
   ~behaviour[\onSet].value(time);
}
