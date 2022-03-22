// (
//
// SynthDef(\pwmSaw, { | out, gate = 1, freq = 440, masterVol = 1,
// 	                  attack = 0.2, decay = 0.2, sustain = 0.8, release = 0.7,
// 	                  accent = 0, vibrato = 0,
// 	                  sub = 0.5, subDetune = 0, subComp = 0,
// 	                  filterBoost = 0,
// 	                  detuneBoost = 0,
// 	                  pwmBoost = 0
// 	               |
// 	var filterFreq = 1200;
//     var filterFreqEnv = Line.ar(900 + filterBoost, 200, 3);
//
// 	var mainEnv = EnvGen.ar(Env.adsr(attack, decay, sustain, release), gate, 0.02 * masterVol, doneAction: 2);
// 	var globalDetune = 10.0;
// 	var detuneDecay = EnvGen.ar(Env.perc(0.0, 0.6 + detuneBoost), gate, globalDetune);
//
// 	var accentGlissFreq = Select.ar(accent > 0, [DC.ar(freq), freq + EnvGen.ar(Env.perc(0.0, 0.3), 1, freq * accent)]);
// 	var accentGlissVibFreq = Vibrato.ar(accentGlissFreq, rate: 6, depth: vibrato, delay: 0.0, onset: 0.0, rateVariation: 0.04, depthVariation: 0.1);
//
// 	// high register
// 	var detunedCurve1 = LFNoise2.ar(freq: 2.0, mul: 7.0 * detuneDecay, add: accentGlissVibFreq);
// 	var detunedCurve2 = LFNoise2.ar(freq: 4.0, mul: 3.0 * detuneDecay, add: accentGlissVibFreq);
// 	var detunedCurve3 = LFNoise2.ar(freq: 6.0, mul: 1.0 * detuneDecay, add: accentGlissVibFreq);
//
// 	// low register
// 	var detunedCurve4 = LFNoise2.ar(freq: 4.0 + subDetune, mul: 4.0 * detuneDecay, add: accentGlissVibFreq * sub);
// 	var detunedCurve5 = LFNoise2.ar(freq: 9.0 + subDetune, mul: 3.0 * detuneDecay, add: accentGlissVibFreq * sub);
// 	var detunedCurve6 = LFNoise2.ar(freq: 5.0 + subDetune, mul: 1.0 * detuneDecay, add: accentGlissVibFreq * sub);
//
// 	var pwm = Line.kr(4 + pwmBoost, 0.2, 0.4 + pwmBoost * 1.2);
//
// 	var saw1 = Pan2.ar(SyncSaw.ar(detunedCurve1, detunedCurve1 * pwm, mainEnv), Rand(-0.4, 0.4));
// 	var saw2 = Pan2.ar(SyncSaw.ar(detunedCurve2, detunedCurve2 * pwm, mainEnv), Rand(-0.4, 0.4));
// 	var saw3 = Pan2.ar(SyncSaw.ar(detunedCurve3, detunedCurve3 * pwm, mainEnv), Rand(-0.4, 0.4));
//
// 	var saw4 = DPW4Saw.ar(detunedCurve4, mainEnv);
// 	var saw5 = DPW4Saw.ar(detunedCurve5, mainEnv);
// 	var saw6 = DPW4Saw.ar(detunedCurve6, mainEnv);
//
// 	var lowSaws = saw4 + saw5 + saw6;
//
// 	var subs = Select.ar(subComp > 0, [RLPF.ar(lowSaws, filterFreqEnv, 0.1),
// 		tanh(RLPF.ar(lowSaws, filterFreq, 0.2, 0.1))]);
//
// 	Out.ar(out, RLPF.ar(saw1 + saw2 + saw3, filterFreq, 0.1) + subs)
// }, variants: (
// 	 arp: [\attack, 0.03, \decay, 0.3, \sustain: 0.2],
//  arpOpen: [\attack, 0.03, \decay, 0.4, \sustain: 0.4],
// 	riff: [attack: 0.2, decay: 2.5, sub: 0.5, release: 1.0],
// 	lead: [attack: 0.2, decay: 2.5, release: 1.0, sub: 0.25,
//            subDetune: 10, subComp: 1, filterBoost: 1000,
// 	       detuneBoost: 1, pwmBoost: 2, vibrato: 0.0]
//    )).add;
//
// )
//
// (
// SynthDef(\keys,{ | out, gate = 1, masterVol = 1,
// 	               attack = 0.2, decay = 0.5, sustain = 0.7, release = 0.4
//                    voiced = 0.8, freq = 440,
// 	               xmod = 0,
// 	               highBoost = 0
// 	             |
// 	var periodicsource, source, output, original, ringMod, vibrato;
//
// 	var mainEnv = EnvGen.ar(Env.adsr(attack, decay, sustain, release), gate, masterVol, doneAction: 2);
//
// 	var formantfreqs = [800, 1150, 2900, 3900, 4950];
// 	var formantamps = ([0 ,-6, -32, -20, -50] -6).dbamp;
// 	var formantbandwidths = [80, 90, 120, 130, 140];
//
// 	var phaseMod = LFNoise2.ar(LFNoise1.ar(1,0.25,0.5),0.1,0.5);
// 	var sawAmpMod = LFNoise2.ar(LFNoise1.ar(1,0.25,0.5),0.1,0.5) *0.5;
// 	var bandWidthMod = LFNoise2.ar(LFNoise1.ar(1,0.5,4),10);
//
// 	source = LPF.ar(SinOsc.ar(freq, phaseMod) *0.2 + DPW4Saw.ar(freq, sawAmpMod), 3000 + highBoost);
//     original = BPF.ar(source, formantfreqs,(formantbandwidths + bandWidthMod) / formantfreqs, formantamps);
//
// 	ringMod = SinOsc.ar(900, 0, 0.2) * original;
//
// 	output = Select.ar(xmod > 0, [original, SinOsc.ar(1900, 0, 0.2) * original]) *mainEnv;
// 	Out.ar(0, output.dup)
//
// }, variants: (
// 	 runs: [attack: 0.1, masterVol: 0.8, decay: 0.6],
// 	metal: [attack: 0.01, decay: 0.8, release: 3, masterVol: 4.0, xmod: 1, highBoost: 1000],
// 	string: [attack: 1, decay: 2, release: 4, masterVol: 1.0]
//    )
// ).add;
//
// )
//
// (
~synth2 =
Ppar([

	Pbind(
		\instrument, \hellhell,
		\dur, Pseq([1 / 2, 1 / 2, 1 / 2, 0.5 / 2], inf),
		\release, Pseq([0.4 , 0.1, 0.1, 0.2], inf),
		\p1, Pseq([5, 5, 1, 2], inf),
		\amp, 0.06
	),

	Pbind(
	\instrument, 'keys',
	\scale, Scale.harmonicMinor,
	\degree, Pseq([[0, 2, 4], [4, 6, 1, 3], [0, 2, 4], [6, 1, 3 + 0.1]], inf),
	\octave, Pseq([[5, 5, 5], [3, 3, 4, 4], [5, 5, 5], [3, 4, 4]], inf),
	\root, 1,
	\dur, 3,
),
Pbind(
	\instrument, 'bells',
	\scale, Scale.melodicMinor,
	\degree, Pseq([0, 2, 4, 0, 0, 2, 4, 0,
		           4, 6, 1, 3, 4, 6, 1, 3,
				   0, 2, 4, 0, 0, 2, 4, 0,
				   6, 1, 3 + 0.1, 6, 1, 3 + 0.1], inf),
	\octave, 5,
	\root, 1,
	\dur, 3 / 8,
)]);//.play;
// )

//
// (
// ~synth2.stop;
// )
