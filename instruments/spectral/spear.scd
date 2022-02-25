Require("file-load.scd");

~spearBuilder = { | fileName,
	                mixin,
	                name,
	                partialPicker,
	                partialGen,
	                envFactory,
	                gate = 1,
		            attack = 0.2,
	                decay = 1,
	                sustain = 0.4,
	                release = 0.5
	              |

    var initialData = ~loadPartials.value(fileName);
	var data = partialPicker.value(initialData);
	postln("Version 5");
	SynthDef(name, { | gate = 1, amp = 0.15 |
		var env = EnvGen.ar(envFactory.value(attack, decay, sustain, release), gate, doneAction: 2);

		var partials = SynthDef.wrap(
			partialGen, prependArgs: [data, 4, gate]
		);

		var transient = SynthDef.wrap(
            mixin
        );

		Out.ar(0, ((partials * env * amp) + transient) ! 2);
	}).add;
};

~allPartialsPicker = { | data |
   data;
};

~percussionEnvelope = { | attack, decay, sustain, release |
	Env.perc(attack, release);
};

~sustainedEnvelope = { | attack, decay, sustain, release |
	Env.adsr(attack, decay, sustain, release);
};
