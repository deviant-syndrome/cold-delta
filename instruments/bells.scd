SynthDef(\bells, { |out=0, freq=440, amp=0.5, gate=1, c3=17, sustain = 0.3, pan=0 |
	var snd, snd2;
	var env = Env.perc(0.01, 0.8);
		var env2 = Env.adsr(0.01, 0.5, sustain, 1.4);


	var body = RLPF.ar(Saw.ar(freq, EnvGen.ar(env, gate, doneAction: 2)), XLine.ar(1800, 160, 0.5)) ! 2;

		var freqBase=freq;
		var freqRes=SinOsc.kr(Rand(0,1),0).range(freqBase / 2,freqBase * 2);
		var pdbase=Impulse.ar(freqBase);
		var pd=Phasor.ar(pdbase,2*pi*freqBase/s.sampleRate,0,2pi);
		var pdres=Phasor.ar(pdbase,2*pi*freqRes/s.sampleRate,0,2pi);
		var pdi=LinLin.ar((2pi-pd).max(0),0,2pi,0,1);
		snd2=Lag.ar(SinOsc.ar(0,pdres)*pdi,1/freqBase).dup;
		snd2=Splay.ar(snd2);
	snd2=snd2*EnvGen.ar(Env.perc(0.1,1.4)) * 0.1;

	    snd =  body + snd2;
		snd = snd*0.1 + BBandPass.ar(snd, 751,0.075) + BBandPass.ar(snd, 1460,0.075) + BBandPass.ar(snd, 2841,0.075);


	Out.ar(out, snd * 0.1);

}).add;
