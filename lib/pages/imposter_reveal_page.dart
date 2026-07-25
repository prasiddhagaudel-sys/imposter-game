import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';
import '../utils/audio_generator.dart';

class ImposterRevealPage extends StatefulWidget {
  final List<String> playerNames;
  final List<bool> isImposter;

  const ImposterRevealPage({
    super.key,
    required this.playerNames,
    required this.isImposter,
  });

  @override
  State<ImposterRevealPage> createState() => _ImposterRevealPageState();
}

class _ImposterRevealPageState extends State<ImposterRevealPage>
    with TickerProviderStateMixin {
  // ─── Animation Controllers ──────────────────────────────────────────────
  late AnimationController _sequenceController; // 0→1 over ~3.5s
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  late AnimationController _particleController;

  final List<_RevealParticle> _particles = [];
  final Random _random = Random();

  late List<String> _imposterNames;

  @override
  void initState() {
    super.initState();

    _imposterNames = [];
    for (int i = 0; i < widget.playerNames.length; i++) {
      if (widget.isImposter[i]) {
        _imposterNames.add(widget.playerNames[i]);
      }
    }

    _sequenceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    _particleController.addListener(_updateParticles);

    _initParticles();

    // Start the sequence
    _sequenceController.forward();

    // Play audio in parallel
    AudioGenerator.playRevealSequence();
  }

  void _initParticles() {
    for (int i = 0; i < 50; i++) {
      _particles.add(_RevealParticle(
        x: _random.nextDouble() * 1000,
        y: _random.nextDouble() * 2000,
        speedX: (_random.nextDouble() - 0.5) * 1.0,
        speedY: -_random.nextDouble() * 0.8 - 0.2,
        radius: _random.nextDouble() * 2.5 + 0.5,
        opacity: _random.nextDouble() * 0.3 + 0.05,
        hue: _random.nextDouble(),
      ));
    }
  }

  void _updateParticles() {
    for (var p in _particles) {
      p.x += p.speedX;
      p.y += p.speedY;
      if (p.y < 0) {
        p.y = 2000;
        p.x = _random.nextDouble() * 1000;
      }
      if (p.x < 0) p.x = 1000;
      if (p.x > 1000) p.x = 0;
    }
  }

  @override
  void dispose() {
    _sequenceController.dispose();
    _pulseController.dispose();
    _particleController.dispose();
    AudioGenerator.dispose();
    super.dispose();
  }

  // ─── Sequence Phases ────────────────────────────────────────────────────
  // 0.00 - 0.15: Darkness fades in
  // 0.15 - 0.55: "WHO IS THE IMPOSTER?" pulses with drum hits
  // 0.55 - 0.65: Screen flash (white → dark)
  // 0.65 - 1.00: Reveal names with dramatic entrance

  // ─── Build ──────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _sequenceController,
          _pulseAnimation,
          _particleController,
        ]),
        builder: (context, _) {
          final t = _sequenceController.value;
          final pulse = _pulseAnimation.value;

          return Stack(
            children: [
              // Background with flash effect
              _buildBackground(t),

              // Particles
              Positioned.fill(
                child: CustomPaint(
                  painter: _RevealParticlePainter(
                    particles: _particles,
                    progress: t,
                  ),
                ),
              ),

              // Content
              SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Suspense text (phase 1-2)
                        if (t < 0.65) _buildSuspenseText(t, pulse),

                        // Reveal content (phase 3)
                        if (t >= 0.60) _buildRevealContent(t, pulse, context),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ─── Background ─────────────────────────────────────────────────────────

  Widget _buildBackground(double t) {
    // Flash at t ≈ 0.58
    double flashIntensity = 0.0;
    if (t > 0.55 && t < 0.65) {
      final flashT = (t - 0.55) / 0.10;
      flashIntensity = flashT < 0.4
          ? flashT / 0.4 // fade to white
          : 1.0 - ((flashT - 0.4) / 0.6); // back to dark
    }

    final bgColor = Color.lerp(
      const Color(0xFF0A0A0A),
      Colors.white,
      flashIntensity * 0.7,
    )!;

    // After reveal, add red tint
    final revealTint = t > 0.65 ? ((t - 0.65) / 0.35).clamp(0.0, 1.0) : 0.0;

    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.5,
          colors: [
            Color.lerp(bgColor, const Color(0xFF2A0008), revealTint)!,
            bgColor,
          ],
        ),
      ),
    );
  }

  // ─── Suspense Text ──────────────────────────────────────────────────────

  Widget _buildSuspenseText(double t, double pulse) {
    // Fade in from t=0.05 to t=0.15
    final fadeIn = ((t - 0.05) / 0.10).clamp(0.0, 1.0);
    // Fade out at flash
    final fadeOut = t > 0.50 ? 1.0 - ((t - 0.50) / 0.15).clamp(0.0, 1.0) : 1.0;
    final opacity = fadeIn * fadeOut;

    // Scale pulse effect simulating drum beats
    // Drum hit times (normalized): ~0.14, 0.29, 0.43
    final drumPulseScale = _drumPulseAt(t) * 0.15;

    return Opacity(
      opacity: opacity.clamp(0.0, 1.0),
      child: Transform.scale(
        scale: 1.0 + drumPulseScale + pulse * 0.03,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'WHO IS',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white.withValues(alpha: 0.5),
                letterSpacing: 8,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'THE IMPOSTER?',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w900,
                color: const Color(0xFFFF3D71),
                letterSpacing: 5,
                shadows: [
                  const Shadow(offset: Offset(0, 2), blurRadius: 0, color: Color(0xFF9C1B30)),
                  Shadow(offset: const Offset(0, 4), blurRadius: 10 + pulse * 10, color: const Color(0xFFFF3D71)),
                  const Shadow(offset: Offset(0, 8), blurRadius: 20, color: Colors.black),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Pulsing dots
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) {
                final dotOpacity = ((pulse + i * 0.3) % 1.0);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFFF3D71)
                          .withValues(alpha: dotOpacity * 0.6),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// Returns a spike (0→1→0) at each drum hit time.
  double _drumPulseAt(double t) {
    // Drum hit normalized times (matching audio generator)
    const drumTimes = [0.0, 0.14, 0.25, 0.34, 0.40, 0.44, 0.47, 0.49, 0.51];
    for (final dt in drumTimes) {
      final diff = (t - dt).abs();
      if (diff < 0.03) {
        return 1.0 - (diff / 0.03);
      }
    }
    return 0.0;
  }

  // ─── Reveal Content ─────────────────────────────────────────────────────

  Widget _buildRevealContent(double t, double pulse, BuildContext context) {
    // Fade in from t=0.65 to t=0.80
    final revealProgress = ((t - 0.65) / 0.15).clamp(0.0, 1.0);
    final slideUp = 60 * (1 - revealProgress);

    return Opacity(
      opacity: revealProgress,
      child: Transform.translate(
        offset: Offset(0, slideUp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // "THE IMPOSTER IS" label
            Text(
              _imposterNames.length > 1
                  ? 'THE IMPOSTERS ARE'
                  : 'THE IMPOSTER IS',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFFF3D71).withValues(alpha: 0.7),
                letterSpacing: 5,
              ),
            ),
            const SizedBox(height: 24),

            // Imposter name cards
            ..._imposterNames.asMap().entries.map((entry) {
              final index = entry.key;
              final name = entry.value;
              // Stagger each card's appearance
              final cardDelay = index * 0.05;
              final cardProgress =
                  ((revealProgress - cardDelay) / (1.0 - cardDelay))
                      .clamp(0.0, 1.0);

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Transform.scale(
                  scale: 0.7 + cardProgress * 0.3,
                  child: Opacity(
                    opacity: cardProgress,
                    child: _buildImposterCard(name, pulse),
                  ),
                ),
              );
            }),

            const SizedBox(height: 32),

            // Back to home button (appears last)
            if (revealProgress > 0.8)
              Opacity(
                opacity: ((revealProgress - 0.8) / 0.2).clamp(0.0, 1.0),
                child: _buildHomeButton(context),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildImposterCard(String name, double pulse) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: const LinearGradient(
              colors: [Color(0xFF2A0008), Color(0xFF1A0005)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: const Color(0xFFFF3D71).withValues(alpha: 0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF3D71)
                    .withValues(alpha: 0.2 + pulse * 0.15),
                blurRadius: 30 + pulse * 15,
                spreadRadius: pulse * 8,
              ),
            ],
          ),
          child: Column(
            children: [
              const Text('😈', style: TextStyle(fontSize: 40)),
              const SizedBox(height: 12),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFFF3D71).withValues(alpha: 0.15),
                  border: Border.all(
                    color: const Color(0xFFFF3D71).withValues(alpha: 0.25),
                  ),
                ),
                child: const Text(
                  'IMPOSTER',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFFF3D71),
                    letterSpacing: 4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHomeButton(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white.withValues(alpha: 0.06),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              borderRadius: BorderRadius.circular(16),
              splashColor: Colors.white.withValues(alpha: 0.1),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                child: Text(
                  'BACK TO HOME',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.white.withValues(alpha: 0.5),
                    letterSpacing: 2,
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
// PARTICLE SYSTEM
// ═════════════════════════════════════════════════════════════════════════════

class _RevealParticle {
  double x, y, speedX, speedY, radius, opacity, hue;
  _RevealParticle({
    required this.x,
    required this.y,
    required this.speedX,
    required this.speedY,
    required this.radius,
    required this.opacity,
    required this.hue,
  });
}

class _RevealParticlePainter extends CustomPainter {
  final List<_RevealParticle> particles;
  final double progress;

  _RevealParticlePainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    // Before reveal: dim red particles. After reveal: brighter, more active
    final intensity = progress > 0.6 ? 1.5 : 0.6;

    for (var p in particles) {
      final x = (p.x / 1000) * size.width;
      final y = (p.y / 2000) * size.height;
      final color = Color.lerp(
        const Color(0xFF9C1B30),
        const Color(0xFFFF3D71),
        p.hue,
      )!;
      canvas.drawCircle(
        Offset(x, y),
        p.radius * intensity,
        Paint()..color = color.withValues(alpha: p.opacity * intensity),
      );
      if (p.radius > 1.5 && progress > 0.6) {
        canvas.drawCircle(
          Offset(x, y),
          p.radius * 2.5,
          Paint()
            ..color = color.withValues(alpha: p.opacity * 0.15)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
