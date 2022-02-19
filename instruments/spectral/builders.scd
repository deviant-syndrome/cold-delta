Require("bodies/partial-gen.scd");
Require("bodies/bowed-gen.scd");
Require("spear.scd");
Require("spear-rand-partials.scd");

~singleSpearBuilder = { | fileName |
	~spearBuilder.value(fileName,
		mixin: { DC.ar(0); },
		partialPicker: ~allPartialsPicker,
		partialGen: ~simplePartialGen,
		envFactory: ~percussionEnvelope
	);
};

~textureSpearBuilder = { | fileName, name |
  ~spearBuilder.value(fileName,
	name: name,
	mixin: { DC.ar(0); },
	partialPicker: ~allPartialsPicker,
	partialGen: ~simplePartialGen,
 	envFactory: ~sustainedEnvelope
  );
};

~textureBowedSpearBuilder = { | fileName, name, numPartials |
  ~spearBuilder.value(fileName,
	name: name,
	mixin: { DC.ar(0); },
	partialPicker: ~randomPartialPicker.value(numPartials),
	partialGen: ~loopedBowedGen,
 	envFactory: ~sustainedEnvelope
  );
};

~randomTextureSpearBuilder = { | fileName, name, numPartials |
  ~spearBuilder.value(fileName,
	name: name,
	mixin: { DC.ar(0); },
	partialPicker: ~randomPartialPicker.value(numPartials),
	partialGen: ~movingLoopingPartialGen,
 	envFactory: ~sustainedEnvelope
  );
};
