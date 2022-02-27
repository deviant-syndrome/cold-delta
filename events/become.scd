// todo: add ability to partly inherit behaviours?
~become = { | beh |
	Environment.make {
	    ~behaviour = beh;
	}.push;
};

~unbecome = { Environment.pop; };
