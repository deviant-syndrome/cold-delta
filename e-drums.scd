SynthDef(\snare, {
	arg amp = 0.05, scaleSize = 0.8;

	var tri = Saw.ar(111.0 * scaleSize);
	var freqS1 = FreqShift.ar(tri, 175 * scaleSize, 0, 0.1);
	var freqS2 = FreqShift.ar(tri, 224 * scaleSize, 0, 0.1);

	var env = EnvGen.ar(Env.perc(0, 0.5), 1, amp, doneAction: 2);

	var membraine = SinOsc.ar(180, 0 * scaleSize) + SinOsc.ar(330 * scaleSize, 0, 0.4) + freqS1 + freqS2;
	var memEq = BPeakEQ.ar(membraine, 7200, 4.0, 6);
	Out.ar(0, ((memEq + WhiteNoise.ar(0.20)) * env).dup(2));
}).add;

SynthDef(\kick, {
	arg baseFreq = 150, amp = 0.6;

	var pitchEnv = EnvGen.ar(Env.perc(0, 0.2));
	var ampEnv =  EnvGen.ar(Env.perc(0, 2.2), levelScale: amp, doneAction: 2);
	Out.ar(0, HPF.ar(SinOsc.ar(baseFreq * pitchEnv, 0, ampEnv), 100).dup(2))
}).add;


SynthDef(\ride, {
	arg amp = 0.4;

	var square1 = Pulse.ar(10400, 0.7);
	var square2 = Pulse.ar(9300, 0.6);
	var square3 = Pulse.ar(9200);
	var square4 = Pulse.ar(5250);
	var square5 = Pulse.ar(7800, 0.2);
	var square6 = Pulse.ar(12010);

	var signal = square1 + square2 + square3 + square4 + square5 + square6;


	var highComponent = BBandPass.ar(signal, 14000);
	var lowComponent = BBandPass.ar(signal, 400);

	var highVCA = EnvGen.ar(Env.perc(0, 0.4, 0.1), 1, amp);
	var lowVCA = EnvGen.ar(Env.perc(0, 0.8, 0.8), 1, amp, doneAction: 2);

	Out.ar(0, (highComponent * highVCA + lowComponent * lowVCA).dup(2));
}).add;

(
SynthDef(\dwgbowed, { |out=0, freq=440, amp=0.5,force=1, gate=1,pos=0.07,c1=0.25,c3=31,pan=0|
    var vib = Gendy1.kr(1,1,1,1,0.1, 4,mul:0.003,add:1);
    var son = DWGBowed.ar(freq*vib, amp,force, gate,pos,0.1,c1,c3);
    son = DWGSoundBoard.ar(son);
    son = BPF.ar(son,118,1)+son;
    son = BPF.ar(son,430,1)+son;
    son = BPF.ar(son,490,1)+son;
    son = LPF.ar(son,6000);
    Out.ar(out, Pan2.ar(son * 0.01, pan));
}).add;
)

