(
Require("bootstrap.scd");
//
// postln(topEnvironment);

// todo: basslines
//       cymbal textures
//       thin string for soloing / leaks


topEnvironment[\become].value(topEnvironment[\playMovement1]);

// topEnvironment[\become].value(topEnvironment[\playLeaks]);
//
// topEnvironment[\become].value(Dictionary.newFrom([
// 		\onSet, {}
// 	]));
//
// // ~player = Pbind(
// 	\instrument, Pseq([\steelString6, \steelString5], inf),
// 	\dur, 2
// 	).play;

)

(
~globalRouting[\chuggs][\gain].set(\gains, 0.4);
)

(
	~player.stop;
	s.freeAll;
)

(
	s.makeGui();
)

(
	// could be a good type of metal cymbal
	{ DynKlank.ar(`[[800, 1071, 1153, 1723], nil, [1, 1, 1, 1]], Impulse.ar(2, 0, 0.1)) }.play;
)

(
SynthDef(\hellhell, { | p1 = 0, p2 = 0, gate = 1, release = 1, amp = 0.3 |
	var env = EnvGen.ar(Env.adsr(0.01, 0.5, 0.2, release), gate, levelScale: amp, doneAction: Done.freeSelf);
 	var sig = SinOsc.ar(XLine.ar(200, 60, 0.1), 0.1);
	sig = Wrap.ar(sig, -0.2, 0.4);
	sig = (sig * p1).tanh + sig;
	// sig = Wrap.ar(sig, -0.2, 0.4);
	// sig = Wrap.ar(sig, -0.2, 0.4);
	//
	// sig = CrossoverDistortion.ar(sig, 0.7, -0.4, 0.4);
	// sig = CrossoverDistortion.ar(sig, 0.7, -0.4, 0.4);
	// sig = CrossoverDistortion.ar(sig, 0.7, -0.4, 0.4);
	sig = CrossoverDistortion.ar(sig, 0.7, -0.4, 0.02);
	sig = (sig * 5) + DynKlank.ar(`[[800, 1071, 1153, 1723], nil, [1, 1, 1, 1]], sig);
	Out.ar(0, (sig + PinkNoise.ar(0.6)) * amp);
}).add;
)

(
	var curDir = thisProcess.nowExecutingPath.dirname;
	d =Buffer.read(s,curDir +/+ "media/drums.wav");
)

(
	b = Buffer.alloc(s,2048,1);
   c = Buffer.alloc(s,2048,1);
    t = Buffer.alloc(s,2048,1);
)
(
SynthDef("help-morph2", { arg out=0, bufnumA=0, bufnumB=1, soundBufnum=2;
    var inA, chainA, inB, chainB, chain;
	var trigger = Dust.ar(density: MouseY.kr(0.1, 50, 1), mul: 1.0, add: 0.0);
	var env = EnvGen.ar(Env.perc(0.01, 0.3), trigger);
    inA = CrossoverDistortion.ar(Mix(Formant.ar([120, 180], [1200, 2000], [240, 360], 0.2)), 0.7, -0.4, 0.45) * env;
    inB = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
    chainA = FFT(bufnumA, inA);
    chainB = FFT(bufnumB, inB);
    chain = PV_Morph(chainA, chainB, MouseX.kr);
    Out.ar(out,  IFFT(chain).dup);
}).play(s,[\out, 0, \bufnumA, b.bufnum, \bufnumB, c.bufnum, \soundBufnum, d.bufnum]);


)

(
	// todo: tune the formant osciallators to some "evil" interval
	// todo: define pattern for deman-ugens
SynthDef("help-morph3", {
 arg out=0, bufnumA=0, bufnumB=1, soundBufnum=2, inBufnum=3;
    var in, inA, fft, chainA, inB, chainB, chain,  chain2, detect, env, env2, dd, slopeanalysis;
	var heck;
	dd = 0;
    in = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
	chain = FFT(LocalBuf(2048, 1), in);
	detect = PV_JensenAndersen.ar(chain, threshold: MouseX.kr(0.1, 1.0));

    Poll.kr(Impulse.kr(1), LinExp.kr(in: WAmp.kr(in: detect, winSize: 1), srclo: 0.0, srchi: 0.01161, dstlo: 1.0, dsthi: 2.0));
	// Poll.kr(Impulse.kr(10), detect);
	env = EnvGen.ar(Env.perc(0.02, 0.4), gate: Trig1.ar(in: detect, dur: 0.1));
	dd = Dust.ar(env*10);

	// env2 = EnvGen.ar(Env.perc(0.01, 0.7), gate: dd);
	heck = LinExp.kr(in: WAmp.kr(in: detect, winSize: 1), srclo: 0.0, srchi: 0.01161, dstlo: 1.0, dsthi: 2.0);

	inA = CrossoverDistortion.ar(Mix(Formant.ar([120, 129], [SinOsc.kr(Decay.ar(0.4 * detect, 0.1), 0, 400, 600 + heck), 2000], [240, 360], 0.2)), 0.7, -0.4, 0.45);
	inB = in;//PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
	chainA = FFT(LocalBuf(2048, 1), inA);
	chainB = FFT(LocalBuf(2048, 1), inB);
	chain2 = PV_Morph(chainA, chainB, MouseY.kr);

	// Out.ar(0, TWChoose.ar(Dust.kr(0.5), [in, in + IFFT(chain2).dup(2)], [0.8, 0.2], normalize: 1));
	Out.ar(0, IFFT(chain2).dup(2));
	// Out.ar(0, SinOsc.ar([440, 445], 0, Decay.ar(0.1 * detect, 0.1)) + (inA * env));
    // Out.ar(0, SinOsc.ar([440, 445], 0, Decay.ar(0.1 * detect, 0.1)));
}).play(s,[\out, 0, \bufnumA, b.bufnum, \bufnumB, c.bufnum, \soundBufnum, d.bufnum, \inBufnum, t.bufnum]);

)


(
//var tempfile = PathName.tmp +/+ UniqueID.next ++ ".txt";
var tempfile = "~/Downloads/txt.txt".standardizePath;
var date = "2020-04-01";
var str, file;
"curl 'https://api.nasa.gov/planetary/apod?date=2020-12-11&&api_key=DEMO_KEY' >%".format(date,tempfile)
.unixCmd({ |exit|
	protect {
		if(exit == 0) {
			d = tempfile.parseJSONFile.postln;
			{
				var browser, webview;
				1.wait;
				webview = WebView().minSize_(300@200);
				browser = View(bounds:900@700).layout_(VLayout(HLayout(),webview));
				browser.front;
				webview.url = d.at("url");}.fork(AppClock)
		} {
			"Error processing query (exit code = %)".format(exit).warn;
		};
	} { File.delete(tempfile) };
});
)

(
Pbind(
	\instrument, \hellhell,
	\dur, Pseq([1 / 2, 1 / 2, 1 / 2, 0.5 / 2], inf),
	\release, Pseq([0.4, 0.1, 0.1, 0.2], inf),
	\p1, Pseq([5, 5, 1, 2], inf)
).play;
)

(
SynthDef("help-Dust", { arg out=0;
    Out.ar(out,
        Dust.ar(0.4, 0.2)
    )
}).play;
)
(
    p = Pdfsm(
		   [
			   Pseq( [\reprise, \reprise, \reprise, \coda], inf ),
			   (
				   \reprise : [0, Pseq([0, 4, 4, 3, Rest(), 2, 1, Rest(), 6, 7], 1)],
				   \coda : [0, Pseq([-4, 4, 4, 3, Rest(), 2, 1, Rest(), 6, 7], 1)]
			   )
		   ],
		   0,
		   inf
	   ).asStream;
)

(
    p.next.postln;
	// postln("-----")
)

(
SynthDef(\bells, { |out=0, freq=440, amp=0.5, gate=1, c3=17, pan=0, bufnum = 0|
	var snd, snd2;
	var env = Env.perc(0.01, 0.8);
		var env2 = Env.adsr(0.01, 0.5, 0.3, 1.4);


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


	Out.ar(0, snd * 0.1);

}).add;
)

(
	var synth = SynthDescLib.global.at(\bowedHell);

	var controls = synth.controls;
	controls
)

(
	SynthDef(\test, { | out = 0 |
		var impulse = Impulse.kr(1);
		var sound = SinOsc.ar(440, 0, EnvGen.ar(Env.perc(0.2, 1), impulse));
		Out.ar(out, sound ! 2);
	}).add;
)

(
var a, b;
a = Pn(2, Pwhite(-1.0, 1.0));
x = a.asStream;
8.do { x.next.postln };
)
