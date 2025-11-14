# 🎛️ SuperCollider Beat Maker - Membuat Beat Melalui Coding

Project ini adalah kumpulan file SuperCollider untuk membuat beat dan musik melalui coding. Cocok untuk pemula yang ingin belajar live coding musik dengan SuperCollider!

## 🚀 Fitur

### 🎵 File Beat yang Tersedia

- **⭐ beat_basic.scd**: Template dasar untuk membuat beat (cocok untuk pemula)
  - Pattern sederhana: Kick, Snare, Hi-hat
  - Kontrol mudah dengan `~start.()` dan `~stop.()`
  - BPM: 120 (dapat diubah)

- **🎤 beat_hiphop.scd**: Beat hip-hop klasik dengan groove yang khas
  - Pattern syncopated
  - BPM: 90 (khas hip-hop)
  - Kick dan snare dengan karakteristik hip-hop

- **🔥 beat_trap.scd**: Beat trap modern dengan 808 kick dan hi-hat rolls
  - 808-style kick (sub bass)
  - Hi-hat rolls yang kompleks
  - BPM: 140 (khas trap)
  - Snare pada beat 3

- **🎚️ dj_loop.scd**: DJ club remix dengan struktur arrangement lengkap
  - Intro, build-up, drop, breakdown, outro
  - Sidechain compression
  - Master effects (reverb, limiter)
  - BPM: 125

- **🎬 cinematic.scd**: Komposisi cinematic dengan pad, choir, bass, arpeggio
  - Auto-record ke file WAV
  - Durasi: 90 detik
  - Multiple layers (pad, choir, bass, arpeggio, percussion)

- **🌙 saas.scd**: Musik dreamy/ambient dengan bass dan gitar pad
  - Musik ambient lembut
  - Bass dan gitar pad
  - Cocok untuk background music

- **📖 SUPERCOLLIDER_GUIDE.md**: Panduan lengkap cara menggunakan SuperCollider untuk membuat beat

## 📦 Instalasi

### 1. Install SuperCollider

#### Windows
- Download dari [supercollider.github.io](https://supercollider.github.io/download)
- Install SuperCollider IDE

#### Mac
```bash
brew install supercollider
```

#### Linux
```bash
sudo apt-get install supercollider
```

### 2. Buka File .scd

1. Buka SuperCollider IDE
2. Buka file `.scd` yang ingin Anda jalankan:
   - **`beat_basic.scd`** - ⭐ **Mulai dari sini!** Template dasar untuk belajar
   - **`beat_hiphop.scd`** - Beat hip-hop klasik
   - **`beat_trap.scd`** - Beat trap modern
   - `dj_loop.scd` - DJ loop dengan arrangement lengkap
   - `cinematic.scd` - Komposisi cinematic
   - `saas.scd` - Musik dreamy/ambient

### 3. Jalankan Kode

1. Pilih seluruh isi file (Ctrl+A / Cmd+A)
2. Tekan Ctrl+Enter (Windows/Linux) atau Cmd+Enter (Mac)
3. Beat akan mulai bermain otomatis

**📖 Baca panduan lengkap:** [SUPERCOLLIDER_GUIDE.md](SUPERCOLLIDER_GUIDE.md)

## 🎼 Cara Menggunakan

### ⭐ beat_basic.scd (Pemula)

1. Buka file `beat_basic.scd` di SuperCollider IDE
2. Pilih semua (Ctrl+A) dan jalankan (Ctrl+Enter)
3. Beat akan mulai otomatis dengan pattern dasar:
   - Kick pada beat 1
   - Snare pada beat 2 dan 4
   - Hi-hat setiap 1/4 beat

**Kontrol:**
```supercollider
~start.();  // Mulai beat
~stop.();   // Hentikan beat
~bpm = 128; // Ubah tempo (lalu restart)
```

### 🎤 beat_hiphop.scd

1. Buka file `beat_hiphop.scd` di SuperCollider IDE
2. Pilih semua dan jalankan
3. Beat hip-hop dengan pattern syncopated akan mulai
4. BPM: 90 (khas hip-hop)

### 🔥 beat_trap.scd

1. Buka file `beat_trap.scd` di SuperCollider IDE
2. Pilih semua dan jalankan
3. Beat trap dengan 808 kick dan hi-hat rolls
4. BPM: 140 (khas trap)

### 🎚️ dj_loop.scd

1. Buka file `dj_loop.scd` di SuperCollider IDE
2. Pilih semua dan jalankan
3. Pattern akan mulai otomatis dengan struktur:
   - **Intro** (0-8 bar): Kick saja
   - **Build-up** (8-32 bar): Tambah hi-hat, snare, pad, riser
   - **Drop** (32 bar): Full arrangement dengan bassline
   - **Breakdown** (64 bar): Hanya pad dan atmosfer
   - **Drop kembali** (80 bar): Full arrangement lagi
   - **Outro** (112 bar): Fade out

**Kontrol Manual:**
```supercollider
~start.();  // Mulai semua pattern
~stop.();   // Hentikan semua pattern
~bpm = 126; // Ubah tempo (lalu restart clock)
```

### 🎬 cinematic.scd

1. Buka file `cinematic.scd` di SuperCollider IDE
2. Pilih semua dan jalankan
3. Musik akan mulai otomatis dan berhenti setelah 90 detik
4. File akan direkam ke `D:/soundtrack/cinematic2.wav`
   - **Catatan**: Ubah path recording sesuai kebutuhan Anda

### 🌙 saas.scd

1. Buka file `saas.scd` di SuperCollider IDE
2. Pilih semua dan jalankan
3. Musik dreamy/ambient akan mulai dengan bass dan gitar pad

## 📁 Struktur Project

```
strudel/
├── README.md                # Dokumentasi utama
├── SUPERCOLLIDER_GUIDE.md   # 📖 Panduan lengkap SuperCollider untuk beat
│
├── beat_basic.scd          # ⭐ Template dasar beat (pemula)
├── beat_hiphop.scd         # Beat hip-hop klasik
├── beat_trap.scd           # Beat trap modern
├── dj_loop.scd            # DJ club remix dengan arrangement lengkap
├── cinematic.scd          # Komposisi cinematic (90 detik, auto-record)
└── saas.scd               # Musik dreamy/ambient
```

## 🎯 Konsep Dasar SuperCollider

### 1. SynthDef - Definisi Suara
SynthDef adalah template untuk membuat suara:
```supercollider
SynthDef(\kick, { |out=0, amp=0.8, freq=50|
    var env, sig;
    env = EnvGen.ar(Env.perc(0.001, 0.3), doneAction:2);
    sig = SinOsc.ar(freq) * env * amp;
    Out.ar(out, sig ! 2);
}).add;
```

### 2. Pbind - Pattern Binding
Pbind membuat pattern ritmik:
```supercollider
Pbind(
    \instrument, \kick,
    \dur, 1,  // Durasi 1 beat
    \amp, 0.8
).play;
```

### 3. TempoClock - Kontrol Tempo
```supercollider
~bpm = 120;
~clock = TempoClock(~bpm/60);
```

### 4. Pdef - Pattern Definition
Menyimpan pattern untuk kontrol:
```supercollider
Pdef(\kick, Pbind(...));
Pdef(\kick).play;  // Mulai
Pdef(\kick).stop;  // Hentikan
```

## 💡 Tips & Tricks

### 1. Ubah Tempo
```supercollider
~bpm = 140;  // Ubah nilai BPM
~clock = TempoClock(~bpm/60);  // Restart clock
```

### 2. Layering Pattern
```supercollider
// Jalankan beberapa pattern bersamaan
Pdef(\kick).play(~clock, quant:1);
Pdef(\snare).play(~clock, quant:1);
Pdef(\hats).play(~clock, quant:1);
```

### 3. Recording
```supercollider
// Mulai recording
s.record(numChannels: 2, path: "D:/beat_output.wav");

// Stop recording
s.stopRecording;
```

### 4. Monitor Audio
```supercollider
s.freqscope;  // Frequency analyzer
s.scope;      // Oscilloscope
```

## 🚨 Troubleshooting

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

## 📚 Referensi & Learning Resources

### 📖 Panduan di Project Ini
- **[SUPERCOLLIDER_GUIDE.md](SUPERCOLLIDER_GUIDE.md)** - Panduan lengkap dengan contoh kode dan tutorial step-by-step

### Dokumentasi Resmi
- [SuperCollider Documentation](https://doc.sccode.org/)
- [Pattern Guide](https://doc.sccode.org/Classes/Pattern.html)
- [SynthDef Guide](https://doc.sccode.org/Classes/SynthDef.html)

### Tutorial
- [SuperCollider Tutorials](https://supercollider.github.io/tutorials/)
- [SuperCollider Examples](https://github.com/supercollider/supercollider/tree/develop/examples)

## 🎓 Belajar Membuat Beat

### Langkah 1: Pahami Dasar-Dasar
1. **SynthDef**: Pelajari cara membuat suara (kick, snare, hi-hat)
2. **Pbind**: Pahami cara membuat pattern ritmik
3. **TempoClock**: Pelajari kontrol tempo dan timing

### Langkah 2: Coba Contoh
1. Mulai dengan `beat_basic.scd` untuk belajar dasar
2. Modifikasi sedikit-sedikit dan dengar perubahannya
3. Coba file lain untuk genre berbeda

### Langkah 3: Buat Beat Sendiri
1. Tentukan tempo dan genre (hip-hop, trap, house, dll)
2. Buat drum pattern dasar dulu
3. Tambah bass line
4. Tambah melodi atau chord
5. Tambah efek untuk memperkaya suara

### Langkah 4: Advanced
1. **Baca Panduan**: Pelajari [SUPERCOLLIDER_GUIDE.md](SUPERCOLLIDER_GUIDE.md) untuk teknik advanced
2. **Eksperimen**: Coba berbagai pattern dan efek
3. **Buat Sendiri**: Modifikasi pattern dan buat beat unik Anda
4. **Struktur Arrangement**: Pelajari `dj_loop.scd` untuk struktur lengkap (intro, build-up, drop, outro)
5. **Recording**: Pelajari cara record output ke file WAV

## 🤝 Kontribusi

Feel free untuk:
- Menambah contoh pattern baru
- Improve dokumentasi
- Tambah fitur baru
- Report bugs
- Share beat yang Anda buat!

## 📄 License

MIT License - feel free untuk menggunakan project ini untuk apapun!

---

**Happy Coding & Happy Music Making! 🎵✨**

*Project ini dibuat untuk membantu Anda belajar membuat beat melalui coding dengan SuperCollider. Mulai dari yang sederhana, eksperimen, dan nikmati prosesnya!*
