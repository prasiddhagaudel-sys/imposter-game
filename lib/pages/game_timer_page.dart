import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';
import '../utils/audio_generator.dart';
import 'imposter_reveal_page.dart';

class GameTimerPage extends StatefulWidget {
  final double timerMinutes;
  final List<String> playerNames;
  final List<bool> isImposter;

  const GameTimerPage({
    super.key,
    required this.timerMinutes,
    required this.playerNames,
    required this.isImposter,
  });

  @override
  State<GameTimerPage> createState() => _GameTimerPageState();
}

class _GameTimerPageState extends State<GameTimerPage>
    with TickerProviderStateMixin {
  late AnimationController _timerController;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  late AnimationController _particleController;
  late AnimationController _revealBtnController;
  late Animation<double> _revealBtnAnimation;

  bool _timerDone = false;
  final List<_TimerParticle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();

    final totalSeconds = (widget.timerMinutes * 60).round();

    _timerController = AnimationController(
      vsync: this,
      duration: Duration(seconds: totalSeconds),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    _particleController.addListener(_updateParticles);

    _revealBtnController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _revealBtnAnimation = CurvedAnimation(
      parent: _revealBtnController,
      curve: Curves.elasticOut,
    );

    _initParticles();

    _timerController.addStatusListener((status) {
      if (status == AnimationStatus.completed && !_timerDone) {
        _finishTimer();
      }
    });

    _timerController.forward();
  }

  void _finishTimer() {
    if (_timerDone) return;
    _timerController.stop();
    setState(() => _timerDone = true);
    _revealBtnController.forward();
    AudioGenerator.playTimerEndSound();
  }

  void _initParticles() {
    for (int i = 0; i < 35; i++) {
      _particles.add(_TimerParticle(
        x: _random.nextDouble() * 1000,
        y: _random.nextDouble() * 2000,
        speedX: (_random.nextDouble() - 0.5) * 0.4,
        speedY: (_random.nextDouble() - 0.5) * 0.3,
        radius: _random.nextDouble() * 2.5 + 0.5,
        opacity: _random.nextDouble() * 0.2 + 0.05,
      ));
    }
  }

  void _updateParticles() {
    for (var p in _particles) {
      p.x += p.speedX;
      p.y += p.speedY;
      if (p.x < 0) p.x = 1000;
      if (p.x > 1000) p.x = 0;
      if (p.y < 0) p.y = 2000;
      if (p.y > 2000) p.y = 0;
    }
  }

  @override
  void dispose() {
    _timerController.dispose();
    _pulseController.dispose();
    _particleController.dispose();
    _revealBtnController.dispose();
    super.dispose();
  }

  // ─── Helpers ────────────────────────────────────────────────────────────

  // devilLevel: 0 = angel (start), 1 = devil (end)
  double get _devilLevel => _timerController.value;

  Color _getMoodColor(double level) {
    if (level < 0.3) {
      return Color.lerp(
        const Color(0xFFFFD700), // gold
        const Color(0xFF2563EB), // calm royal blue
        level / 0.3,
      )!;
    } else if (level < 0.6) {
      return Color.lerp(
        const Color(0xFF2563EB), // calm royal blue
        const Color(0xFFFF6B35), // orange
        (level - 0.3) / 0.3,
      )!;
    } else {
      return Color.lerp(
        const Color(0xFFFF6B35),
        const Color(0xFF9C1B30), // blood red
        (level - 0.6) / 0.4,
      )!;
    }
  }

  String _getMoodEmoji(double level) {
    if (level < 0.2) return '😇';
    if (level < 0.4) return '😐';
    if (level < 0.6) return '😰';
    if (level < 0.8) return '😨';
    return '😈';
  }

  String _getMoodLabel(double level) {
    if (level < 0.2) return 'Discuss peacefully...';
    if (level < 0.4) return 'Getting suspicious...';
    if (level < 0.6) return 'Tensions rising!';
    if (level < 0.8) return 'Almost time!';
    return 'FINAL MOMENTS!';
  }

  String _formatRemaining(double fraction) {
    final totalSec = (widget.timerMinutes * 60).round();
    final remaining = ((1 - fraction) * totalSec).round();
    final m = remaining ~/ 60;
    final s = remaining % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  // ─── Build ──────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A1A),
      body: Stack(
        children: [
          // Particles
          Positioned.fill(
            child: AnimatedBuilder(
              animation: Listenable.merge([_particleController, _timerController]),
              builder: (context, _) {
                return CustomPaint(
                  painter: _TimerParticlePainter(
                    particles: _particles,
                    devilLevel: _devilLevel,
                  ),
                );
              },
            ),
          ),

          // Background orbs
          AnimatedBuilder(
            animation: _timerController,
            builder: (context, _) {
              final d = _devilLevel;
              final orbColor = Color.lerp(
                const Color(0xFFFFD700).withValues(alpha: 0.08),
                const Color(0xFF9C1B30).withValues(alpha: 0.15),
                d,
              )!;
              return Stack(
                children: [
                  Positioned(
                    top: -80,
                    right: -60,
                    child: Container(
                      width: 280,
                      height: 280,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [orbColor, Colors.transparent],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 60,
                    left: -100,
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [orbColor, Colors.transparent],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // Main content
          SafeArea(
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _timerController,
                _pulseAnimation,
                _revealBtnAnimation,
              ]),
              builder: (context, _) {
                final d = _devilLevel;
                final moodColor = _getMoodColor(d);
                final pulse = _pulseAnimation.value;

                return Column(
                  children: [
                    const SizedBox(height: 24),

                    // Title with dynamic mood glow
                    Text(
                      'DISCUSSION TIME',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFFF8FAFC),
                        letterSpacing: 4,
                        shadows: [
                          Shadow(offset: const Offset(0, 2), blurRadius: 10, color: moodColor),
                          Shadow(offset: const Offset(0, 4), blurRadius: 20, color: moodColor.withValues(alpha: 0.5)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _timerDone ? 'TIME\'S UP!' : _getMoodLabel(d),
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: moodColor.withValues(alpha: 0.9),
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    // Timer
                    Expanded(
                      child: Center(
                        child: SizedBox(
                          width: 260,
                          height: 260,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Outer glow
                              Container(
                                width: 260,
                                height: 260,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: moodColor.withValues(
                                        alpha: 0.1 + pulse * 0.1 * d,
                                      ),
                                      blurRadius: 40 + d * 30,
                                      spreadRadius: 10 + d * 15,
                                    ),
                                  ],
                                ),
                              ),

                              // Timer ring painter
                              CustomPaint(
                                size: const Size(260, 260),
                                painter: _CountdownPainter(
                                  progress: _timerDone ? 1.0 : d,
                                  devilLevel: d,
                                  pulseValue: pulse,
                                ),
                              ),

                              // Center content
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 400),
                                    child: Text(
                                      _timerDone ? '💀' : _getMoodEmoji(d),
                                      key: ValueKey('mood_${_getMoodEmoji(d)}_$_timerDone'),
                                      style: const TextStyle(fontSize: 32),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    _timerDone ? '0:00' : _formatRemaining(d),
                                    style: TextStyle(
                                      fontSize: 42,
                                      fontWeight: FontWeight.w900,
                                      color: Color.lerp(
                                        Colors.white,
                                        moodColor,
                                        d * 0.6 + (_timerDone ? 0.4 : 0),
                                      ),
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Reveal Button or Player Count & End Timer Early
                    if (_timerDone) ...[
                      Transform.scale(
                        scale: _revealBtnAnimation.value,
                        child: _buildRevealButton(context),
                      ),
                    ] else ...[
                      _buildPlayerInfo(),
                      const SizedBox(height: 12),
                      _buildEndEarlyButton(),
                    ],

                    const SizedBox(height: 32),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRevealButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          final scale = 1.0 + _pulseAnimation.value * 0.04;
          return Transform.scale(scale: scale, child: child);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              width: double.infinity,
              height: 62,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF3D71), Color(0xFF9C1B30)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondary) =>
                            ImposterRevealPage(
                              playerNames: widget.playerNames,
                              isImposter: widget.isImposter,
                            ),
                        transitionsBuilder: (context, animation, secondary, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 800),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(20),
                  splashColor: Colors.white.withValues(alpha: 0.1),
                  child: const Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('🔍', style: TextStyle(fontSize: 22)),
                        SizedBox(width: 12),
                        Text(
                          'REVEAL THE IMPOSTER',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerInfo() {
    final imposterCount = widget.isImposter.where((b) => b).length;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white.withValues(alpha: 0.04),
              border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.groups_rounded, color: Color(0xFF7B61FF), size: 20),
                const SizedBox(width: 10),
                Text(
                  '${widget.playerNames.length} players',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                ),
                const SizedBox(width: 20),
                const Text('😈', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 6),
                Text(
                  '$imposterCount imposter${imposterCount > 1 ? "s" : ""} hidden',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEndEarlyButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xFFFF3D71).withValues(alpha: 0.12),
              border: Border.all(
                color: const Color(0xFFFF3D71).withValues(alpha: 0.3),
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _finishTimer,
                borderRadius: BorderRadius.circular(16),
                splashColor: const Color(0xFFFF3D71).withValues(alpha: 0.2),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('🚨', style: TextStyle(fontSize: 18)),
                      SizedBox(width: 8),
                      Text(
                        'IMPOSTER FOUND! END TIMER',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFFFF3D71),
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// COUNTDOWN PAINTER
// ═════════════════════════════════════════════════════════════════════════════

class _CountdownPainter extends CustomPainter {
  final double progress; // 0→1 (fraction elapsed)
  final double devilLevel;
  final double pulseValue;

  _CountdownPainter({
    required this.progress,
    required this.devilLevel,
    required this.pulseValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 24;
    const startAngle = -pi / 2;
    final remainFraction = (1 - progress).clamp(0.0, 1.0);
    final sweepAngle = remainFraction * 2 * pi;

    final arcColor = _colorForLevel(devilLevel);

    // ── Track ──
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.06)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..strokeCap = StrokeCap.round,
    );

    // ── Tick marks ──
    for (int i = 0; i < 60; i++) {
      final tickAngle = startAngle + (i / 60) * 2 * pi;
      final isMajor = i % 5 == 0;
      final outerR = radius + (isMajor ? 8 : 4);
      final innerR = radius + 2;
      double opacity = isMajor ? 0.2 : 0.08;

      // Flicker at high devil level
      if (devilLevel > 0.7) {
        final flicker = sin(pulseValue * pi * 3 + i * 1.5);
        opacity *= (0.5 + flicker * 0.5).clamp(0.2, 1.0);
      }

      canvas.drawLine(
        Offset(center.dx + cos(tickAngle) * innerR, center.dy + sin(tickAngle) * innerR),
        Offset(center.dx + cos(tickAngle) * outerR, center.dy + sin(tickAngle) * outerR),
        Paint()
          ..color = Color.lerp(
            Colors.white.withValues(alpha: opacity),
            arcColor.withValues(alpha: opacity * 1.5),
            devilLevel,
          )!
          ..strokeWidth = isMajor ? 2.0 : 1.0
          ..strokeCap = StrokeCap.round,
      );
    }

    // ── Arc glow ──
    if (sweepAngle > 0.01) {
      final glowIntensity = 0.12 + devilLevel * 0.25 + pulseValue * 0.08 * devilLevel;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        Paint()
          ..color = arcColor.withValues(alpha: glowIntensity)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 18
          ..strokeCap = StrokeCap.round
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12),
      );
    }

    // ── Main arc ──
    if (sweepAngle > 0.01) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        Paint()
          ..color = arcColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 7
          ..strokeCap = StrokeCap.round,
      );
    }

    // ── Handle knob at end of arc ──
    final handleAngle = startAngle + sweepAngle;
    final hx = center.dx + cos(handleAngle) * radius;
    final hy = center.dy + sin(handleAngle) * radius;

    canvas.drawCircle(
      Offset(hx, hy),
      12,
      Paint()
        ..color = arcColor.withValues(alpha: 0.3 + pulseValue * 0.15)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10),
    );
    canvas.drawCircle(Offset(hx, hy), 7, Paint()..color = arcColor);
    canvas.drawCircle(
      Offset(hx, hy),
      3,
      Paint()..color = Colors.white.withValues(alpha: 0.5),
    );

    // ── Ember particles at high devil level ──
    if (devilLevel > 0.5) {
      final rng = Random(42);
      final count = (devilLevel * 10).round();
      for (int i = 0; i < count; i++) {
        final a = rng.nextDouble() * 2 * pi;
        final dist = radius * (0.85 + rng.nextDouble() * 0.3);
        final phase = sin(pulseValue * pi * 2 + i * 1.2);
        final ex = center.dx + cos(a) * dist + phase * 3;
        final ey = center.dy + sin(a) * dist - phase * 4;
        final es = 1.0 + rng.nextDouble() * 2.0 * devilLevel;
        final eo = (0.2 + phase * 0.3).clamp(0.0, 0.5) * (devilLevel - 0.5) * 2;

        canvas.drawCircle(
          Offset(ex, ey),
          es,
          Paint()..color = arcColor.withValues(alpha: eo),
        );
      }
    }
  }

  Color _colorForLevel(double level) {
    if (level < 0.3) {
      return Color.lerp(const Color(0xFFFFD700), const Color(0xFF7B61FF), level / 0.3)!;
    } else if (level < 0.6) {
      return Color.lerp(const Color(0xFF7B61FF), const Color(0xFFFF6B35), (level - 0.3) / 0.3)!;
    } else {
      return Color.lerp(const Color(0xFFFF6B35), const Color(0xFF9C1B30), (level - 0.6) / 0.4)!;
    }
  }

  @override
  bool shouldRepaint(covariant _CountdownPainter old) {
    return old.progress != progress ||
        old.devilLevel != devilLevel ||
        old.pulseValue != pulseValue;
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// PARTICLE SYSTEM
// ═════════════════════════════════════════════════════════════════════════════

class _TimerParticle {
  double x, y, speedX, speedY, radius, opacity;
  _TimerParticle({
    required this.x,
    required this.y,
    required this.speedX,
    required this.speedY,
    required this.radius,
    required this.opacity,
  });
}

class _TimerParticlePainter extends CustomPainter {
  final List<_TimerParticle> particles;
  final double devilLevel;

  _TimerParticlePainter({required this.particles, required this.devilLevel});

  @override
  void paint(Canvas canvas, Size size) {
    final color = Color.lerp(
      const Color(0xFFFFD700),
      const Color(0xFFFF3D71),
      devilLevel,
    )!;
    for (var p in particles) {
      final x = (p.x / 1000) * size.width;
      final y = (p.y / 2000) * size.height;
      canvas.drawCircle(
        Offset(x, y),
        p.radius,
        Paint()..color = color.withValues(alpha: p.opacity),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
