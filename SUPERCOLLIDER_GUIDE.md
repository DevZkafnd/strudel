# 🎛️ Panduan Lengkap: Membuat Beat dengan SuperCollider

Panduan ini akan membantu Anda membuat beat menggunakan SuperCollider dari dasar hingga advanced.

## 📋 Daftar Isi

1. [Instalasi SuperCollider](#instalasi)
2. [Konsep Dasar](#konsep-dasar)
3. [File Beat yang Tersedia](#file-beat)
4. [Cara Menggunakan](#cara-menggunakan)
5. [Membuat Beat Sendiri](#membuat-beat-sendiri)
6. [Tips & Trik](#tips-trik)
7. [Troubleshooting](#troubleshooting)

---

## 🚀 Instalasi SuperCollider {#instalasi}

### Windows
1. Download dari [supercollider.github.io](https://supercollider.github.io/download)
2. Install SuperCollider IDE
3. Buka aplikasi SuperCollider

### Mac
```bash
brew install supercollider
```

### Linux
```bash
sudo apt-get install supercollider
```

---

## 📚 Konsep Dasar {#konsep-dasar}

### 1. **SynthDef** - Definisi Suara
SynthDef adalah template untuk membuat suara. Contoh:
```supercollider
SynthDef(\kick, { |out=0, amp=0.8, freq=50|
    var env, sig;
    env = EnvGen.ar(Env.perc(0.001, 0.3), doneAction:2);
    sig = SinOsc.ar(freq) * env * amp;
    Out.ar(out, sig ! 2);
}).add;
```

### 2. **Pbind** - Pattern Binding
Pbind membuat pattern ritmik:
```supercollider
Pbind(
    \instrument, \kick,
    \dur, 1,  // Durasi 1 beat
    \amp, 0.8
).play;
```

### 3. **TempoClock** - Kontrol Tempo
```supercollider
~bpm = 120;
~clock = TempoClock(~bpm/60);
```

### 4. **Pdef** - Pattern Definition
Menyimpan pattern untuk kontrol:
```supercollider
Pdef(\kick, Pbind(...));
Pdef(\kick).play;  // Mulai
Pdef(\kick).stop;  // Hentikan
```

---

## 📁 File Beat yang Tersedia {#file-beat}

### 1. **beat_basic.scd** - Template Dasar
- ✅ Cocok untuk pemula
- ✅ Pattern sederhana: Kick, Snare, Hi-hat
- ✅ BPM: 120
- ✅ Kontrol mudah dengan `~start.()` dan `~stop.()`

**Cara menggunakan:**
```supercollider
// 1. Buka file beat_basic.scd
// 2. Pilih semua (Ctrl+A)
// 3. Jalankan (Ctrl+Enter)
// 4. Beat akan mulai otomatis
```

### 2. **beat_hiphop.scd** - Beat Hip-Hop
- 🎤 Pattern hip-hop klasik
- 🎤 Kick syncopated
- 🎤 BPM: 90
- 🎤 Groove yang khas

### 3. **beat_trap.scd** - Beat Trap
- 🔥 Pattern trap modern
- 🔥 808-style kick
- 🔥 Hi-hat rolls
- 🔥 BPM: 140
- 🔥 Snare pada beat 3

### 4. **dj_loop.scd** - DJ Club Remix
- 🎚️ Full arrangement dengan struktur lengkap
- 🎚️ Intro, build-up, drop, breakdown
- 🎚️ Sidechain compression
- 🎚️ BPM: 125

### 5. **cinematic.scd** - Komposisi Cinematic
- 🎬 Musik cinematic dengan pad, choir, bass
- 🎬 Auto-record ke file WAV
- 🎬 Durasi: 90 detik

### 6. **saas.scd** - Musik Dreamy/Ambient
- 🌙 Musik ambient lembut
- 🌙 Bass dan gitar pad
- 🌙 Cocok untuk background music

---

## 🎯 Cara Menggunakan {#cara-menggunakan}

### Langkah 1: Buka SuperCollider IDE
1. Buka aplikasi SuperCollider
2. Pastikan server sudah boot (lihat di post window: "Server ready")

### Langkah 2: Buka File Beat
1. File → Open → Pilih file `.scd` yang ingin digunakan
2. Atau drag & drop file ke editor

### Langkah 3: Jalankan Kode
1. Pilih semua kode (Ctrl+A / Cmd+A)
2. Tekan Ctrl+Enter (Windows/Linux) atau Cmd+Enter (Mac)
3. Beat akan mulai bermain

### Langkah 4: Kontrol Beat
```supercollider
~start.();  // Mulai beat
~stop.();   // Hentikan beat
~bpm = 128; // Ubah tempo (perlu restart)
```

---

## 🎨 Membuat Beat Sendiri {#membuat-beat-sendiri}

### Template Minimal
```supercollider
s.waitForBoot({
    // Setup tempo
    ~bpm = 120;
    ~clock = TempoClock(~bpm/60);
    
    // Definisi kick
    SynthDef(\kick, { |out=0, amp=0.8|
        var env, sig;
        env = EnvGen.ar(Env.perc(0.001, 0.3), doneAction:2);
        sig = SinOsc.ar(50) * env * amp;
        Out.ar(out, sig ! 2);
    }).add;
    
    // Pattern
    Pdef(\kick, Pbind(
        \instrument, \kick,
        \dur, 1,
        \amp, 0.8
    ));
    
    s.sync;
    
    // Kontrol
    ~start = { Pdef(\kick).play(~clock, quant:1) };
    ~stop = { Pdef.all.do(_.stop) };
    
    ~start.();
});
```

### Menambah Elemen Drum

#### 1. Snare Drum
```supercollider
SynthDef(\snare, { |out=0, amp=0.6|
    var env, body, noise, sig;
    env = EnvGen.ar(Env.perc(0.001, 0.2), doneAction:2);
    body = SinOsc.ar(200) * EnvGen.ar(Env.perc(0.001, 0.05));
    noise = HPF.ar(WhiteNoise.ar(0.8), 5000);
    sig = (body * 0.3 + noise * 0.7) * env * amp;
    Out.ar(out, sig ! 2);
}).add;

Pdef(\snare, Pbind(
    \instrument, \snare,
    \dur, 2,
    \timingOffset, 1,  // Offset 1 beat (beat 2 dan 4)
    \amp, 0.6
));
```

#### 2. Hi-Hat
```supercollider
SynthDef(\hat, { |out=0, amp=0.4|
    var env, sig;
    env = EnvGen.ar(Env.perc(0.001, 0.05), doneAction:2);
    sig = HPF.ar(WhiteNoise.ar(1.0), 10000) * env * amp;
    Out.ar(out, sig ! 2);
}).add;

Pdef(\hats, Pbind(
    \instrument, \hat,
    \dur, 0.5,  // Setiap 0.5 beat
    \amp, 0.4
));
```

### Membuat Pattern Kompleks

#### Pattern Syncopated
```supercollider
Pdef(\kick, Pbind(
    \instrument, \kick,
    \dur, Pseq([1, 0.5, 1, 0.5, 1], inf),  // Pattern tidak teratur
    \amp, 0.8
));
```

#### Pattern dengan Variasi
```supercollider
Pdef(\hats, Pbind(
    \instrument, \hat,
    \dur, 0.25,
    \amp, Pseq([0.2, 0.4, 0.2, 0.4], inf),  // Variasi volume
    \freq, Pwhite(10000, 14000, inf)  // Variasi pitch
));
```

---

## 💡 Tips & Trik {#tips-trik}

### 1. **Ubah Tempo**
```supercollider
~bpm = 140;  // Ubah nilai BPM
~clock = TempoClock(~bpm/60);  // Restart clock
```

### 2. **Layering Pattern**
```supercollider
// Jalankan beberapa pattern bersamaan
Pdef(\kick).play(~clock, quant:1);
Pdef(\snare).play(~clock, quant:1);
Pdef(\hats).play(~clock, quant:1);
```

### 3. **Quantization**
```supercollider
// Pattern akan mulai pada beat berikutnya (lebih rapi)
Pdef(\kick).play(~clock, quant:1);
```

### 4. **Variasi Volume**
```supercollider
\amp, Pwhite(0.3, 0.6, inf)  // Volume random
\amp, Pseq([0.4, 0.6, 0.4, 0.8], inf)  // Pattern volume
```

### 5. **Variasi Pitch**
```supercollider
\freq, Pseq([50, 55, 50, 48], inf)  // Pattern pitch
\freq, Pwhite(45, 55, inf)  // Random pitch
```

### 6. **Recording**
```supercollider
// Mulai recording
s.record(numChannels: 2, path: "D:/beat_output.wav");

// Stop recording
s.stopRecording;
```

### 7. **Monitor Audio**
```supercollider
s.freqscope;  // Frequency analyzer
s.scope;      // Oscilloscope
```

---

## 🔧 Troubleshooting {#troubleshooting}

### Problem: Tidak Ada Suara
**Solusi:**
1. Pastikan server sudah boot: `s.boot;`
2. Cek volume sistem
3. Cek apakah pattern sudah di-play: `Pdef(\kick).play;`

### Problem: Pattern Tidak Sinkron
**Solusi:**
1. Gunakan `quant:1` saat play: `Pdef(\kick).play(~clock, quant:1);`
2. Pastikan semua pattern menggunakan `~clock` yang sama

### Problem: Suara Terdistorsi
**Solusi:**
1. Kurangi `amp` (amplitude)
2. Gunakan limiter: `Synth.tail(s, \limiter);`

### Problem: Latency Tinggi
**Solusi:**
1. Kurangi buffer size: `s.options.blockSize = 64;`
2. Restart server: `s.reboot;`

---

## 📖 Referensi Lanjutan

### Dokumentasi Resmi
- [SuperCollider Documentation](https://doc.sccode.org/)
- [Pattern Guide](https://doc.sccode.org/Classes/Pattern.html)
- [SynthDef Guide](https://doc.sccode.org/Classes/SynthDef.html)

### Tutorial Video
- [SuperCollider Tutorials](https://supercollider.github.io/tutorials/)
- YouTube: "SuperCollider Tutorial"

### Contoh Kode
- [SuperCollider Examples](https://github.com/supercollider/supercollider/tree/develop/examples)
- [Pattern Examples](https://github.com/supercollider/supercollider/tree/develop/examples/demonstrations)

---

## 🎵 Contoh Beat Lengkap

Berikut contoh beat lengkap dengan semua elemen:

```supercollider
s.waitForBoot({
    ~bpm = 128;
    ~clock = TempoClock(~bpm/60);
    
    // Kick
    SynthDef(\kick, { |out=0, amp=0.9|
        var env, sig;
        env = EnvGen.ar(Env.perc(0.001, 0.3), doneAction:2);
        sig = SinOsc.ar(50) * env * amp;
        Out.ar(out, sig ! 2);
    }).add;
    
    // Snare
    SynthDef(\snare, { |out=0, amp=0.7|
        var env, body, noise, sig;
        env = EnvGen.ar(Env.perc(0.001, 0.2), doneAction:2);
        body = SinOsc.ar(200) * EnvGen.ar(Env.perc(0.001, 0.05));
        noise = HPF.ar(WhiteNoise.ar(0.8), 5000);
        sig = (body * 0.3 + noise * 0.7) * env * amp;
        Out.ar(out, sig ! 2);
    }).add;
    
    // Hi-hat
    SynthDef(\hat, { |out=0, amp=0.4|
        var env, sig;
        env = EnvGen.ar(Env.perc(0.001, 0.05), doneAction:2);
        sig = HPF.ar(WhiteNoise.ar(1.0), 10000) * env * amp;
        Out.ar(out, sig ! 2);
    }).add;
    
    // Patterns
    Pdef(\kick, Pbind(\instrument, \kick, \dur, 1, \amp, 0.9));
    Pdef(\snare, Pbind(\instrument, \snare, \dur, 2, \timingOffset, 1, \amp, 0.7));
    Pdef(\hats, Pbind(\instrument, \hat, \dur, 0.5, \amp, 0.4));
    
    s.sync;
    
    ~start = {
        Pdef(\kick).play(~clock, quant:1);
        Pdef(\snare).play(~clock, quant:1);
        Pdef(\hats).play(~clock, quant:1);
    };
    
    ~stop = { Pdef.all.do(_.stop) };
    
    ~start.();
});
```

---

**Selamat membuat beat! 🎵✨**

*Jika ada pertanyaan, cek dokumentasi atau contoh file yang tersedia di project ini.*

