var strums = Pbind(
	\instrument, Pseq([\steelString5, \steelString6], inf),
	\dur, 2,
	\fret, Pseq([3, 0, 2, 0], inf),
	\group, ~globalRouting[\chuggs][\strip],
	\out, ~globalRouting[\chuggs][\busNum]
).asStream;

var movement1Riffs = Dictionary.newFrom([
	\strums, strums
]);
