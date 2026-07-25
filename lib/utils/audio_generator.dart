import 'dart:math';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';

/// Generates and plays synthesized audio for the imposter reveal sequence.
/// Creates WAV audio entirely in memory — no external audio files needed.
class AudioGenerator {
  static AudioPlayer? _player;

  static AudioPlayer _getOrCreatePlayer() {
    if (_player == null) {
      _player = AudioPlayer();
      _player!.setPlayerMode(PlayerMode.lowLatency);
    }
    return _player!;
  }

  /// Plays the dramatic reveal sequence: accelerating drum hits,
  /// rising tension sweep, and a final reveal chord.
  static Future<void> playRevealSequence() async {
    try {
      final player = _getOrCreatePlayer();
      await player.stop();
      final wavBytes = _generateRevealWav();
      await player.play(BytesSource(wavBytes));
    } catch (e) {
      // Audio is non-critical — fail silently
    }
  }

  /// Plays a single tension drum tick (used during countdown).
  static Future<void> playTick({double intensity = 0.5}) async {
    try {
      final player = _getOrCreatePlayer();
      await player.stop();
      final wavBytes = _generateTickWav(intensity);
      await player.play(BytesSource(wavBytes));
    } catch (e) {
      // Fail silently
    }
  }

  /// Plays an atmospheric alarm chime when the discussion timer finishes.
  static Future<void> playTimerEndSound() async {
    try {
      final player = _getOrCreatePlayer();
      await player.stop();
      final wavBytes = _generateTimerEndWav();
      await player.play(BytesSource(wavBytes));
    } catch (e) {
      // Fail silently
    }
  }

  static void dispose() {
    _player?.dispose();
    _player = null;
  }

  // ─── WAV Generation ─────────────────────────────────────────────────────

  /// Generates the full reveal sequence (~3.5 seconds):
  /// - Accelerating drum hits (0–1.9s)
  /// - Rising tension tone (0–1.9s)
  /// - Brief silence (1.9–2.1s)
  /// - Dramatic reveal chord (2.1–3.5s)
  static Uint8List _generateRevealWav() {
    const sampleRate = 44100;
    const totalDuration = 3.5;
    final totalSamples = (sampleRate * totalDuration).round();
    final samples = Float64List(totalSamples);

    // ── Accelerating drum hits ──
    _addDrum(samples, sampleRate, 0.00, 0.30, 75, 18);
    _addDrum(samples, sampleRate, 0.50, 0.38, 80, 16);
    _addDrum(samples, sampleRate, 0.88, 0.46, 82, 14);
    _addDrum(samples, sampleRate, 1.18, 0.54, 78, 13);
    _addDrum(samples, sampleRate, 1.40, 0.62, 85, 12);
    _addDrum(samples, sampleRate, 1.55, 0.70, 80, 11);
    _addDrum(samples, sampleRate, 1.65, 0.78, 88, 10);
    _addDrum(samples, sampleRate, 1.73, 0.84, 82, 9);
    _addDrum(samples, sampleRate, 1.80, 0.90, 90, 8);

    // ── Rising tension sweep ──
    _addSweep(samples, sampleRate, 0.0, 1.9, 100, 450, 0.18);

    // ── Dramatic reveal chord at 2.1s ──
    _addDrum(samples, sampleRate, 2.10, 0.95, 50, 3);
    _addDrum(samples, sampleRate, 2.10, 0.70, 75, 4);
    _addDrum(samples, sampleRate, 2.10, 0.50, 100, 5);
    _addDrum(samples, sampleRate, 2.10, 0.35, 150, 6);
    _addDrum(samples, sampleRate, 2.10, 0.25, 200, 7);

    // ── Low sustain rumble ──
    _addSweep(samples, sampleRate, 2.1, 3.5, 50, 35, 0.35);

    return _samplesToWav(samples, sampleRate);
  }

  /// Generates a single tick sound (~0.15 seconds).
  static Uint8List _generateTickWav(double intensity) {
    const sampleRate = 44100;
    const totalDuration = 0.2;
    final totalSamples = (sampleRate * totalDuration).round();
    final samples = Float64List(totalSamples);

    _addDrum(samples, sampleRate, 0.0, intensity.clamp(0.1, 0.8), 80, 20);

    return _samplesToWav(samples, sampleRate);
  }

  /// Generates an alarm gong sound (~1.5 seconds) for timer completion.
  static Uint8List _generateTimerEndWav() {
    const sampleRate = 44100;
    const totalDuration = 1.5;
    final totalSamples = (sampleRate * totalDuration).round();
    final samples = Float64List(totalSamples);

    // Initial heavy bass impact
    _addDrum(samples, sampleRate, 0.0, 0.8, 60, 4);
    _addDrum(samples, sampleRate, 0.0, 0.5, 120, 6);

    // Alarm pulses
    _addDrum(samples, sampleRate, 0.15, 0.6, 600, 10);
    _addDrum(samples, sampleRate, 0.35, 0.6, 600, 10);
    _addDrum(samples, sampleRate, 0.55, 0.7, 750, 8);

    // Low rumble sustain
    _addSweep(samples, sampleRate, 0.0, 1.5, 120, 40, 0.3);

    return _samplesToWav(samples, sampleRate);
  }

  // ─── Sound Primitives ───────────────────────────────────────────────────

  /// Adds a drum hit (sine burst with exponential decay) to the sample buffer.
  static void _addDrum(
    Float64List samples,
    int sampleRate,
    double time,
    double amplitude,
    double frequency,
    double decay,
  ) {
    final start = (time * sampleRate).round();
    final length = (0.3 * sampleRate).round();
    for (int i = 0; i < length && start + i < samples.length; i++) {
      final t = i / sampleRate;
      samples[start + i] +=
          sin(2 * pi * frequency * t) * amplitude * exp(-t * decay);
    }
  }

  /// Adds a frequency sweep (ascending tone with crescendo envelope).
  static void _addSweep(
    Float64List samples,
    int sampleRate,
    double startTime,
    double endTime,
    double startFreq,
    double endFreq,
    double amplitude,
  ) {
    final s = (startTime * sampleRate).round();
    final e = (endTime * sampleRate).round();
    final dur = (e - s) / sampleRate;
    for (int i = s; i < e && i < samples.length; i++) {
      final t = (i - s) / sampleRate;
      final progress = t / dur;
      final freq = startFreq + (endFreq - startFreq) * progress;
      // Crescendo envelope
      final env = amplitude * progress;
      samples[i] += sin(2 * pi * freq * t) * env;
    }
  }

  // ─── WAV Encoding ──────────────────────────────────────────────────────

  /// Converts Float64 samples to a complete WAV file (16-bit PCM, mono).
  static Uint8List _samplesToWav(Float64List samples, int sampleRate) {
    const channels = 1;
    const bitsPerSample = 16;
    final byteRate = sampleRate * channels * bitsPerSample ~/ 8;
    final blockAlign = channels * bitsPerSample ~/ 8;
    final dataSize = samples.length * 2;
    final fileSize = 36 + dataSize;

    final buffer = ByteData(44 + dataSize);

    // RIFF header
    _writeString(buffer, 0, 'RIFF');
    buffer.setUint32(4, fileSize, Endian.little);
    _writeString(buffer, 8, 'WAVE');

    // fmt subchunk
    _writeString(buffer, 12, 'fmt ');
    buffer.setUint32(16, 16, Endian.little); // subchunk size
    buffer.setUint16(20, 1, Endian.little); // PCM format
    buffer.setUint16(22, channels, Endian.little);
    buffer.setUint32(24, sampleRate, Endian.little);
    buffer.setUint32(28, byteRate, Endian.little);
    buffer.setUint16(32, blockAlign, Endian.little);
    buffer.setUint16(34, bitsPerSample, Endian.little);

    // data subchunk
    _writeString(buffer, 36, 'data');
    buffer.setUint32(40, dataSize, Endian.little);

    // PCM samples
    for (int i = 0; i < samples.length; i++) {
      final s = (samples[i].clamp(-1.0, 1.0) * 32767).round();
      buffer.setInt16(44 + i * 2, s, Endian.little);
    }

    return buffer.buffer.asUint8List();
  }

  static void _writeString(ByteData buffer, int offset, String str) {
    for (int i = 0; i < str.length; i++) {
      buffer.setUint8(offset + i, str.codeUnitAt(i));
    }
  }
}
