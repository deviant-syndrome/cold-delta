var calculation = { | length, beating, radius |

  var modes, modefreqs, modeamps;

  var mu, t, e, s, k, f1, l, c, a, beta, beta2, density;

  var decaytimefunc;

  a = 0.0179;
  s = pi * a * a;

  // radius of gyration

  k = a * 0.5;
  e = 2e+7;

  density = 4200;

  mu = density*s;

  t = 100000;
  c = (t / mu).sqrt;	// speed of sound on wave

  l = length;

  f1= c / (2 * l);

  beta = (a*a / l)*((pi * e / t).sqrt);
  beta2 = beta * beta;

  modes = 8;

  modefreqs = Array.fill(modes, { arg i;
	var n, fr;
	n = i + 1;

	fr = n * f1 * (1 + beta + beta2 + (n * n * pi * pi * beta2 * 0.125));
	if ( fr>21000, { fr=21000 } ); // no aliasing
  if ( fr<100, { fr = beating } ); // overtone component

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

  Dictionary.newFrom([
	  \modes, modes,
	  \modefreqs, modefreqs,
	  \modeamps, modeamps
  ]);
};

var e = currentEnvironment;

e[\calculationContext] = { |
	                         exec
					       | exec.value(calculation); };
