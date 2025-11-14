// DJ Club Remix v9 — Versi Lebih Halus & Profesional
s.waitForBoot {
	~bpm = 125;
	~clock = TempoClock(~bpm/60);

	// ===== BUS & GROUPS =====
	~reverbBus = Bus.audio(s, 2);
	~sidechainBus = Bus.control(s, 1);
	~masterGroup = Group.new;
	~instrGroup  = Group.before(~masterGroup);

	// ===== MASTER FX =====
	SynthDef(\masterLimiter, { |pregain=2.0, post=1.1|
		var inSig = In.ar(0, 2);
		var x = tanh(inSig * pregain);
		ReplaceOut.ar(0, x * post);
	}).add;

	SynthDef(\masterReverb, { |in=0, out=0, mix=0.25, room=0.9, damp=0.6|
		var dry = In.ar(in, 2);
		var rev = FreeVerb.ar(dry, mix, room, damp);
		Out.ar(out, rev);
	}).add;

	SynthDef(\sidechainPump, { |inbus=0, out=0, sidechainBus, amount=0.35, att=0.005, rel=0.15|
		var input, env, duck;
		input = In.ar(inbus, 2);
		env = Clip.kr(In.kr(sidechainBus), 0, 1);
		duck = LagUD.kr(env, att, rel) * amount;
		ReplaceOut.ar(out, input * (1 - duck));
	}).add;

	// ===== DRUMS =====
	SynthDef(\kick, { |out=0, amp=1.0, freq=50, rel=0.35|
		var env, pitchEnv, sig, click;
		env      = EnvGen.ar(Env.perc(0.001, rel, amp, -8), doneAction:2);
		pitchEnv = EnvGen.ar(Env([1, 0.3, 0.1], [0.01, rel], 'exp'));
		click    = HPF.ar(WhiteNoise.ar(0.03), 3000) * EnvGen.ar(Env.perc(0.001, 0.02));
		sig      = (SinOsc.ar(freq * pitchEnv) + click) * env;
		sig      = tanh(sig * 2);
		Out.ar(out, sig ! 2);
		Out.kr(~sidechainBus, env);
	}).add;

	SynthDef(\snare, { |out=0, amp=0.5, rel=0.25, send=0.25|
		var env, body, noise, sig;
		env  = EnvGen.ar(Env.perc(0.001, rel, 1, -4), doneAction:2);
		body = SinOsc.ar(200) * EnvGen.ar(Env.perc(0.001, 0.08));
		noise = HPF.ar(WhiteNoise.ar(0.5), 4000);
		sig  = (body * 0.4 + noise) * env * amp;
		Out.ar(~reverbBus, sig * send);
		Out.ar(out, sig ! 2);
	}).add;

	SynthDef(\hat, { |out=0, amp=0.3, rel=0.05|
		var env, sig;
		env = EnvGen.ar(Env.perc(0.001, rel), doneAction:2);
		sig = HPF.ar(WhiteNoise.ar(1.0), 8000) * env * amp;
		Out.ar(out, sig ! 2);
	}).add;

	SynthDef(\oh, { |out=0, amp=0.25, rel=0.3, send=0.15|
		var env, sig;
		env = EnvGen.ar(Env.perc(0.001, rel), doneAction:2);
		sig = BPF.ar(WhiteNoise.ar(1.0), 9000, 0.5) * env * amp;
		Out.ar(~reverbBus, sig * send);
		Out.ar(out, sig ! 2);
	}).add;

	// ===== BASS & PAD =====
	SynthDef(\bass, { |out=0, freq=55, amp=0.6, rel=0.35, cutoff=800, send=0.1|
		var env, sig;
		env = EnvGen.ar(Env.perc(0.005, rel, 1, -4), doneAction:2);
		sig = Mix([Saw.ar(freq), Pulse.ar(freq, 0.4)]) * 0.5;
		sig = LPF.ar(sig, cutoff);
		sig = sig * env * amp;
		Out.ar(~reverbBus, sig * send);
		Out.ar(out, sig ! 2);
	}).add;

	SynthDef(\pad, { |out=0, note=60, amp=0.3, cutoff=1600, send=0.45|
		var freq, sig, env, sweep;
		freq = note.midicps;
		sig  = Saw.ar(freq * [1, 1.005], 0.3).sum;
		sweep = LFNoise1.kr(0.05).range(800, cutoff);
		sig  = RLPF.ar(sig, sweep, 0.3);
		env  = EnvGen.ar(Env.linen(2, 8, 4), doneAction:2);
		sig  = sig * env * amp;
		Out.ar(~reverbBus, sig * send);
		Out.ar(out, sig ! 2);
	}).add;

	// ===== RISER FX =====
	SynthDef(\riser, { |out=0, dur=8, amp=0.3|
		var env = EnvGen.ar(Env.linen(0, dur, 1, curve:-4), doneAction:2);
		var sig = WhiteNoise.ar(amp) * env;
		sig = RLPF.ar(sig, XLine.kr(400, 8000, dur), 0.2);
		Out.ar(out, sig!2);
	}).add;

	// ===== PATTERNS =====
	Pdef(\kick, Pbind(
		\instrument, \kick,
		\dur, 1,
		\amp, 0.9
	));

	Pdef(\snare, Pbind(
		\instrument, \snare,
		\dur, Pseq([2,2,2,0.25,0.25,0.25,0.25], inf), // makin rapat menjelang drop
		\timingOffset, 1,
		\amp, 0.45
	));

	Pdef(\hats, Pbind(
		\instrument, Pseq([\hat, \hat, \hat, \oh], inf),
		\dur, Pseq([0.25,0.25,0.5,0.25], inf),
		\amp, Pwhite(0.15,0.28,inf)
	));

	Pdef(\bassline, Pbind(
		\instrument, \bass,
		\midinote, Pseq([45, 45, 43, 41, 48, 43, 41, 38], inf),
		\dur, Pseq([1,0.5,0.5,1,0.5,0.5,1,0.5]/2, inf), // syncopated
		\rel, Pkey(\dur) * 1.2,
		\amp, 0.5
	));

	Pdef(\pads, Pbind(
		\instrument, \pad,
		\degree, Pseq([0, 5, 3, -2], inf),
		\scale, Scale.minor,
		\octave, 5,
		\dur, 16,
		\amp, 0.35
	));

	// ===== FX CHAIN =====
	s.sync;
	Synth.tail(~masterGroup, \masterReverb,  [\in, ~reverbBus]);
	Synth.tail(~masterGroup, \sidechainPump, [\inbus, 0, \sidechainBus, ~sidechainBus, \amount, 0.35]);
	Synth.tail(s, \masterLimiter);

	// ===== ARRANGEMENT =====
	~start = {
		"▶️ Starting structured DJ set v9...".postln;

		// Intro
		Pdef(\kick).play(~clock, quant:1);
		~clock.sched(8, { Pdef(\hats).play(~clock, quant:1) });

		// Build-up
		~clock.sched(16, { Pdef(\snare).play(~clock, quant:1) });
		~clock.sched(24, { Pdef(\pads).play(~clock, quant:1) });
		~clock.sched(28, { Synth(\riser, [\dur, 4]) });

		// Drop
		~clock.sched(32, { Pdef(\bassline).play(~clock, quant:1) });

		// Breakdown
		~clock.sched(64, {
			"🌌 Breakdown...".postln;
			Pdef(\kick).stop; Pdef(\bassline).stop;
		});

		// Drop lagi
		~clock.sched(80, {
			"🔥 Drop kembali!".postln;
			Synth(\riser, [\dur, 4]);
			Pdef(\kick).play(~clock, quant:1);
			Pdef(\bassline).play(~clock, quant:1);
		});

		// Outro fade
		~clock.sched(112, {
			"⏬ Outro (fade)...".postln;
			Pdef(\pads).stop;
			Pdef(\snare).stop;
			Pdef(\hats).stop;
			Pdef(\bassline).stop;
			Pdef(\kick).stop;
		});
	};

	~stop = { Pdef.all.do(_.stop) };

	~start.();
};
