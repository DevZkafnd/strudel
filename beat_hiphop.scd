// ============================================
// BEAT HIP-HOP - Pattern Hip-Hop Klasik
// ============================================
// Beat dengan groove hip-hop yang khas

s.waitForBoot({
	~bpm = 90;  // Tempo hip-hop biasanya 80-100 BPM
	~clock = TempoClock(~bpm/60);
	
	// ===== SYNTH DEFINISI =====
	SynthDef(\kick, { |out=0, amp=0.9, freq=50|
		var env, pitchEnv, sig, click;
		env = EnvGen.ar(Env.perc(0.001, 0.4, 1, -4), doneAction:2);
		pitchEnv = EnvGen.ar(Env([1, 0.25], [0.02], 'exp'));
		click = HPF.ar(WhiteNoise.ar(0.15), 4000) * EnvGen.ar(Env.perc(0.001, 0.015));
		sig = SinOsc.ar(freq * pitchEnv) + click;
		sig = sig * env * amp;
		Out.ar(out, sig ! 2);
	}).add;
	
	SynthDef(\snare, { |out=0, amp=0.7|
		var env, body, noise, sig;
		env = EnvGen.ar(Env.perc(0.001, 0.25, 1, -3), doneAction:2);
		body = SinOsc.ar(200) * EnvGen.ar(Env.perc(0.001, 0.1));
		noise = HPF.ar(WhiteNoise.ar(1.0), 6000);
		sig = (body * 0.4 + noise * 0.6) * env * amp;
		Out.ar(out, sig ! 2);
	}).add;
	
	SynthDef(\hat, { |out=0, amp=0.35|
		var env, sig;
		env = EnvGen.ar(Env.perc(0.001, 0.08), doneAction:2);
		sig = HPF.ar(WhiteNoise.ar(1.0), 12000) * env * amp;
		Out.ar(out, sig ! 2);
	}).add;
	
	// ===== PATTERN HIP-HOP =====
	// Pattern klasik: Kick pada 1, 1.5, 3.5, Snare pada 2 dan 4
	
	Pdef(\kick, Pbind(
		\instrument, \kick,
		\dur, Pseq([1, 0.5, 1, 1, 0.5, 1], inf),  // Pattern syncopated
		\amp, 0.9
	));
	
	Pdef(\snare, Pbind(
		\instrument, \snare,
		\dur, 2,
		\timingOffset, 1,
		\amp, 0.7
	));
	
	Pdef(\hats, Pbind(
		\instrument, \hat,
		\dur, 0.25,  // Hi-hat cepat untuk groove
		\amp, Pseq([0.2, 0.4, 0.2, 0.4], inf)  // Pattern volume
	));
	
	s.sync;
	
	~start = {
		"🎤 Hip-Hop Beat dimulai!".postln;
		Pdef(\kick).play(~clock, quant:1);
		Pdef(\snare).play(~clock, quant:1);
		Pdef(\hats).play(~clock, quant:1);
	};
	
	~stop = { Pdef.all.do(_.stop) };
	
	~start.();
});

