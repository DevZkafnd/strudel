s.options.memSize = 262144;   // 256 MB RT memory
s.options.numBuffers = 4096;  // buffer lebih banyak

// Jalankan sebelum atau sesudah Synth diputar
s.freqscope;        // membuka analyzer real-time (spektrum frekuensi)
s.scope;            // oscilloscope (gelombang waktu)

// Boot server
s.waitForBoot({

    // =========================
    // Definisi Synth
    // =========================

	s.record(numChannels: 2, path: "D:/soundtrack/cinematic2.wav");


    // =========================
    // Definisi Synth
    // =========================

    // Guitar Pad + Shimmer + Chorus
    SynthDef(\guitarPad, { |freq = 220, amp = 0.2, pan = 0|
        var sig, env, shimmer, chorus;
        env = EnvGen.kr(Env.asr(6, 1, 10), doneAction: 2);

        sig = Saw.ar(freq, 0.3);
        sig = LPF.ar(sig, 1500);

        shimmer = SinOsc.ar(freq*2, 0, 0.15);
        shimmer = HPF.ar(shimmer, 2500);

        chorus = DelayC.ar(sig, 0.03, SinOsc.kr(0.1, 0, 0.015, 0.015));
        sig = Mix([sig, shimmer, chorus]) * env * amp;

        sig = FreeVerb2.ar(sig, sig, mix: 0.8, room: 0.99, damp: 0.2);
        sig = CombC.ar(sig, 0.7, LFNoise1.kr(0.05).range(0.25,0.45), 10);

        Out.ar(0, Pan2.ar(sig, pan));
    }).add;

    // Choir / String Pad + Vibrato
    SynthDef(\choirPad, { |freq = 220, amp = 0.2, pan = 0|
        var sig, env, vibrato;
        env = EnvGen.kr(Env.asr(8, 1, 12), doneAction: 2);

        vibrato = SinOsc.kr(0.1, 0, 0.005, 1); // slow pitch modulation
        sig = Pulse.ar(freq * vibrato, 0.4, 0.3) + SinOsc.ar(freq*0.5 * vibrato, 0, 0.3);
        sig = LPF.ar(sig, 1200);
        sig = FreeVerb.ar(sig, mix: 0.85, room: 0.99, damp: 0.2);
        sig = sig * env * amp;

        Out.ar(0, Pan2.ar(sig, pan));
    }).add;

    // Deep Soft Bass + Sub Oscillator
    SynthDef(\softBass, { |freq = 110, amp = 0.2, pan = 0|
        var sig, env, lfo, sub;
        env = EnvGen.kr(Env.asr(0.5, 1, 4), doneAction: 2);

        sig = SinOsc.ar(freq, 0, 0.6) + SinOsc.ar(freq/2, 0, 0.3);
        sig = LPF.ar(sig, 180);

        sub = SinOsc.ar(freq/4, 0, 0.2); // extra sub
        sig = sig + sub;

        lfo = SinOsc.kr(0.03).range(0.8, 1.3);
        sig = sig * lfo;
        sig = sig.tanh * env * amp;

        Out.ar(0, Pan2.ar(sig, pan));
    }).add;

    // Ethereal Arpeggio + Auto-pan + Delay
    SynthDef(\arpPluck, { |freq = 440, amp = 0.2, pan = 0|
        var sig, env, delay;
        env = EnvGen.kr(Env.perc(0.01, 2), doneAction: 2);

        sig = Saw.ar(freq, 0.25);
        sig = LPF.ar(sig, 2000);
        sig = sig * env * amp;

        delay = CombC.ar(sig, 0.5, 0.3, 8);
        sig = Mix([sig, delay]);

        sig = Pan2.ar(sig, SinOsc.kr(0.05).range(-0.8, 0.8));
        sig = FreeVerb.ar(sig, mix: 0.6, room: 0.95);

        Out.ar(0, sig);
    }).add;

    // Atmosphere Noise + Moving Bandpass
    SynthDef(\atmoNoise, { |amp = 0.1|
        var sig, sweep;
        sweep = SinOsc.kr(0.02).range(600, 3000);
        sig = PinkNoise.ar(0.3);
        sig = BPF.ar(sig, sweep, 0.5);
        sig = FreeVerb.ar(sig, mix: 0.65, room: 0.98, damp: 0.3);
        Out.ar(0, sig * amp);
    }).add;

    // Cinematic Percussion (taiko-style hit + sub)
    SynthDef(\cinPerc, { |amp = 0.3|
        var sig, env, sub;
        env = EnvGen.kr(Env.perc(0.001, 2), doneAction: 2);

        sig = SinOsc.ar(50, 0, 0.8) * env;
        sig = sig + (WhiteNoise.ar(0.3) * EnvGen.kr(Env.perc(0.001, 0.3)));
        sig = LPF.ar(sig, 200);

        sub = SinOsc.ar(30, 0, 0.1) * env; // low boom
        sig = sig + sub;

        sig = FreeVerb.ar(sig, mix: 0.5, room: 0.9);
        Out.ar(0, sig * amp);
    }).add;

    // =========================
    // Progression + Pattern
    // =========================

    ~chords = [
        [60, 64, 67], // C
        [57, 60, 64], // Am
        [53, 57, 60], // F
        [55, 59, 62]  // G
    ];

    // Pad
    Pdef(\pad,
        Pbind(
            \instrument, \guitarPad,
            \dur, 8,
            \amp, 0.3,
            \freq, Pseq(~chords, inf).collect { |ch|
                (ch + [0, 12, 24].choose).midicps
            }
        )
    ).play;

    // Choir
    Pdef(\choir,
        Pbind(
            \instrument, \choirPad,
            \dur, 16,
            \amp, 0.25,
            \freq, Pseq(~chords, inf).collect { |ch|
                (ch[0] - 12).midicps
            }
        )
    ).play;

    // Bass
    Pdef(\bass,
        Pbind(
            \instrument, \softBass,
            \dur, 4,
            \amp, 0.3,
            \freq, Pseq([48, 45, 41, 43].midicps, inf)
        )
    ).play;

    // Arpeggio
    Pdef(\arp,
        Pbind(
            \instrument, \arpPluck,
            \dur, Pwhite(0.5, 1.5, inf),
            \amp, 0.15,
            \freq, Pseq(~chords, inf).collect { |ch|
                (ch.choose + [0, 12].choose).midicps
            },
            \pan, Pwhite(-0.7, 0.7, inf)
        )
    ).play;

    // Atmosphere layer
    Synth(\atmoNoise, [\amp, 0.06]);

    // Percussion build (pelan → kuat)
    Pdef(\perc,
        Pbind(
            \instrument, \cinPerc,
            \dur, Pseq([4, 4, 2, 2, 1, 1, 0.5, 0.5], inf),
            \amp, Pseg(Pseq([0.1, 0.5, 0.8, 0.3], inf), 32)
        )
    ).play;

	// =========================
    // Stop otomatis setelah 90 detik
    // =========================
    Routine({
        90.wait;
        // Stop semua pattern
        Pdef(\pad).stop;
        Pdef(\choir).stop;
        Pdef(\bass).stop;
        Pdef(\arp).stop;
        Pdef(\perc).stop;
        ~atmo.free;

        // Stop recording
        s.stopRecording;
        ("Rekaman selesai dalam 90 detik: " ++ ~filePath).postln;
    }).play;

});
