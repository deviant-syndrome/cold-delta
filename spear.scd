Require("partial-gen.scd");

~spearBuilder = { | fileName,
	                mixin,
	                partialPicker,
	                partialGen,
	                gate = 1,
		            attack = 0.2,
	                decay = 4,
	                sustain = 0.4,
	                release = 0.5
	              |

	var initialData = CSVFileReader.readInterpret(thisProcess.nowExecutingPath.dirname +/+ fileName);
	var data = partialPicker.value(initialData);

	// todo:
	// make two version of this
	//    -> One shot
	//    -> Sustained

	SynthDef(\heck, { | gate = 1 |
		var env = EnvGen.ar(Env.adsr(attack, decay, sustain, release), gate, doneAction: 2);
		var subGate = Done.kr(env);

		var partials = SynthDef.wrap(
			partialGen, prependArgs: [data, 4, gate]
		);


		var transient = SynthDef.wrap(
            mixin
        );

		Out.ar(0, ((partials * env * 0.15) + transient) ! 2);
	}).play;
};

~singleSpearBuilder = { | fileName |
	~spearBuilder.value(fileName,
		mixin: { DC.ar(0); },
		partialPicker: ~allPartialsPicker,
		partialGen: ~simplePartialGen
	);
};

~allPartialsPicker = { | data |
   data;
};

// test spear - returns function that plays a synth and kills it
// prod spear - returns PBind event

// modulationg with partials:

// 1. design a synth-pad
// 2. N synth pad, each pad it modulated by a particle
// technical: synthdef wrapping? 