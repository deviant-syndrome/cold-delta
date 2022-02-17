Require("partial-gen.scd");
Require("bowed-gen.scd");

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

	var path = thisProcess.nowExecutingPath.dirname +/+ "heck.ar"; //fileName;
	var initialData = Object.readArchive(path);//CSVFileReader.readInterpret(path);

	var data = partialPicker.value(initialData);

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
	//initialData.writeArchive(thisProcess.nowExecutingPath.dirname +/+ "heck.ar")
};

~singleSpearBuilder = { | fileName |
	~spearBuilder.value(fileName,
		mixin: { DC.ar(0); },
		partialPicker: ~allPartialsPicker,
		partialGen: ~simplePartialGen,
		envFactory: ~percussionEnvelope
	);
};

~textureSpearBuilder = { |fileName, name |
  ~spearBuilder.value(fileName,
	name: name,
	mixin: { DC.ar(0); },
	partialPicker: ~allPartialsPicker,
	partialGen: ~simplePartialGen,
 	envFactory: ~sustainedEnvelope
  );
};

~textureBowedSpearBuilder = { |fileName, name, numPartials |
  ~spearBuilder.value(fileName,
	name: name,
	mixin: { DC.ar(0); },
	partialPicker: ~randomPartialPicker.value(numPartials),
	partialGen: ~loopedBowedGen,
 	envFactory: ~sustainedEnvelope
  );
};



~randomTextureSpearBuilder = { |fileName, name, numPartials |
  ~spearBuilder.value(fileName,
	name: name,
	mixin: { DC.ar(0); },
	partialPicker: ~randomPartialPicker.value(numPartials),
	partialGen: ~movingLoopingPartialGen,
 	envFactory: ~sustainedEnvelope
  );
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
