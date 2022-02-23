(
    var modes, modefreqs, modeamps;

    var mu, t, e, s, k, f1, l, c, a, beta, beta2, density;

    var decaytimefunc;

    a = 0.0187;
    s = pi * a * a;

    // radius of gyration

    k = a * 0.5;
    e = 2e+7;

    density = 4200;

    mu = density*s;

    t = 100000;
    c = (t / mu).sqrt;	// speed of sound on wave

    l = 0.96;

    f1= c / (2 * l);

    beta = (a*a / l)*((pi * e / t).sqrt);
    beta2 = beta * beta;

    modes = 8;


    modefreqs = Array.fill(modes, { arg i;
      var n, fr;
      n = i + 1;

      fr = n * f1 * (1 + beta + beta2 + (n * n * pi * pi * beta2 * 0.125));
      if ( fr>21000, { fr=21000 } ); // no aliasing
	if ( fr<100, { fr=100 } ); // inharmonic component
	fr; //* (0.999 + 0.002.rand);

    });

    decaytimefunc = { arg freq;
       var t1, t2, t3;
       var m, calc, e1dive2;

       // VS p 50 2.13.1 air damping

       m = (a * 0.5) * ((2 * pi * freq / (1.5e-5)).sqrt);
       calc = 2 * m * m / ((2 * (2.sqrt) * m) + 1);

       t1 = (density / ( 2 * pi * 1.2 * freq)) * calc;

       e1dive2 = 0.01; // a guess!
       t2= e1dive2 / (pi * freq);

       // leave G as 1
       t3 = 1.0 / (8 * mu *l * freq * freq * 1);

       1 / (( 1 / t1 ) + ( 1 / t2 ) + ( 1 / t3 ));
    };

    modeamps = Array.fill(modes, { arg i; decaytimefunc.value(modefreqs.at(i)) } );

    SynthDef(\steelString, { | gate = 1,
	                           amp = 1 |
    var nonHarm;
	var res;
	var env = EnvGen.ar(Env.perc(0.01, 0.3), gate, amp, doneAction: 2);
	    var sound = Mix.fill( modes, { arg i;
		XLine.ar(1.0, modeamps.at(i), 2.2 * (6  - i)) * SinOsc.ar(modefreqs.at(i), 0, 1 / modes)
	    });
	// todo:
	// add release handling for damping effect
	// add randomness to frequency damping
    // add weighted randmomness for odd strokes
	// add random noise
	// add randomize envelope
	// for longer strokes the high-freq energy should dissipate slower
    // FIlter Q: find a sweet spot + one ringing extremity + one dead extremity
	// When playing fast palm-mutes - less Q, less hi-freqs
	nonHarm = FreqShift.ar(sound, TRand.ar(2000, 2015, gate)) * 0.005;
	res = DynKlank.ar(`[[51, 85, 365, 500], nil, [0, 0.4, 0.0, 0.15]], (sound + nonHarm)) * 0.003;
	Out.ar(0, HPF.ar(RLPF.ar((res + sound + nonHarm) * env, XLine.ar(2454, 100 + TRand.ar(0, 200, gate), 0.09 + TRand.ar(0, 0.03, gate)), TWChoose.ar(gate, [DC.ar(2.7), DC.ar(4.8)], [0.2, 0.8]) ), 60, 3) ! 2);
    }).play;
)