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
  late AnimationController _sequenceController; // 0→1 over ~4s
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  late AnimationController _particleController;
  late AnimationController _shakeController;

  final List<_RevealParticle> _particles = [];
  final Random _random = Random();

  late List<String> _imposterNames;
  late Map<String, String> _imposterQuotes;

  // Multilingual Thriller & Suspense Quotes (Nepali, Hindi, English)
  final List<String> _suspenseQuotes = [
    // Nepali
    'थाहै नपाई झुक्याइदियो! 😈🔥',
    'सावधान! चोरको बुद्धि बलियो हुन्छ! 🧠⚡',
    'सबैलाई गुमराहमा राख्न सफल! 🎭',
    'म नै हो असली खेल खेलडी! 👑',
    'अन्तिम सम्म कसैले शंका गरेनन्! 👁️✨',
    'चाल बुझ्न नसक्ने साथीहरु! 🤫💥',
    'मासूम अनुहार, खतरनाक दिमाग! 🐺🖤',

    // Hindi
    'पकड़े गए या सबको उल्लू बनाया? 😈🔥',
    'सबकी नज़रों के सामने असली मुजरिम! 👁️✨',
    'मास्टरमाइंड तो यही निकला! 🧠👑',
    'धोखेबाज़ी का असली बादशाह! 🎭⚡',
    'किसी को भनक तक नहीं लगी! 🤫💥',
    'मासूम चेहरा, खतरनाक इरादा! 😈🖤',
    'गेम ओवर! असली चालबाज़ सामने है! 💥🏆',

    // English
    'The Mastermind of Deception! 🎭⚡',
    'Fooled everyone right under their noses! 🤫🔥',
    'Innocent eyes, dangerous lies! 👁️😈',
    'The Wolf among the Sheep! 🐺👑',
    'Pure chaotic genius! 🧠💥',
    'Trust was broken, chaos reigns! 🩸✨',
    'The true villain stands revealed! 🖤🔥',
  ];

  @override
  void initState() {
    super.initState();

    _imposterNames = [];
    _imposterQuotes = {};

    for (int i = 0; i < widget.playerNames.length; i++) {
      if (widget.isImposter[i]) {
        final name = widget.playerNames[i];
        _imposterNames.add(name);
        _imposterQuotes[name] =
            _suspenseQuotes[_random.nextInt(_suspenseQuotes.length)];
      }
    }

    _sequenceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    _particleController.addListener(_updateParticles);

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _initParticles();

    // Start sequence
    _sequenceController.forward();
    _sequenceController.addListener(() {
      if (_sequenceController.value > 0.58 && _sequenceController.value < 0.68) {
        if (!_shakeController.isAnimating) {
          _shakeController.forward(from: 0);
        }
      }
    });

    // Play suspense thriller audio
    AudioGenerator.playRevealSequence();
  }

  void _initParticles() {
    for (int i = 0; i < 70; i++) {
      _particles.add(_RevealParticle(
        x: _random.nextDouble() * 1000,
        y: _random.nextDouble() * 2000,
        speedX: (_random.nextDouble() - 0.5) * 1.5,
        speedY: -_random.nextDouble() * 1.2 - 0.3,
        radius: _random.nextDouble() * 3.0 + 0.8,
        opacity: _random.nextDouble() * 0.4 + 0.1,
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
    _shakeController.dispose();
    AudioGenerator.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF07040A),
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _sequenceController,
          _pulseAnimation,
          _particleController,
          _shakeController,
        ]),
        builder: (context, _) {
          final t = _sequenceController.value;
          final pulse = _pulseAnimation.value;

          // Camera shake effect during reveal climax
          double shakeOffset = 0.0;
          if (_shakeController.isAnimating) {
            shakeOffset = sin(_shakeController.value * pi * 10) * 6;
          }

          return Transform.translate(
            offset: Offset(shakeOffset, 0),
            child: Stack(
              children: [
                // Background with blood-red alarm strobe
                _buildThrillerBackground(t, pulse),

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
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Suspense text (Phase 1 & 2)
                          if (t < 0.65) _buildSuspenseText(t, pulse),

                          // Reveal content & quotes (Phase 3)
                          if (t >= 0.60) _buildRevealContent(t, pulse, context),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ─── Thriller Background ──────────────────────────────────────────────────

  Widget _buildThrillerBackground(double t, double pulse) {
    double flashIntensity = 0.0;
    if (t > 0.55 && t < 0.65) {
      final flashT = (t - 0.55) / 0.10;
      flashIntensity = flashT < 0.4
          ? flashT / 0.4
          : 1.0 - ((flashT - 0.4) / 0.6);
    }

    final bgColor = Color.lerp(
      const Color(0xFF07040A),
      Colors.white,
      flashIntensity * 0.85,
    )!;

    final revealTint = t > 0.65 ? ((t - 0.65) / 0.35).clamp(0.0, 1.0) : 0.0;

    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.4,
          colors: [
            Color.lerp(
              bgColor,
              Color.lerp(
                const Color(0xFF4A000E),
                const Color(0xFF88001B),
                pulse,
              )!,
              revealTint,
            )!,
            bgColor,
          ],
        ),
      ),
    );
  }

  // ─── Suspense Intro Text ──────────────────────────────────────────────────

  Widget _buildSuspenseText(double t, double pulse) {
    final fadeIn = ((t - 0.05) / 0.10).clamp(0.0, 1.0);
    final fadeOut = t > 0.50 ? 1.0 - ((t - 0.50) / 0.15).clamp(0.0, 1.0) : 1.0;
    final opacity = fadeIn * fadeOut;

    final drumPulseScale = _drumPulseAt(t) * 0.20;

    return Opacity(
      opacity: opacity.clamp(0.0, 1.0),
      child: Transform.scale(
        scale: 1.0 + drumPulseScale + pulse * 0.04,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('🚨', style: TextStyle(fontSize: 24)),
                SizedBox(width: 8),
                Text(
                  'UNMASKING',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white70,
                    letterSpacing: 8,
                  ),
                ),
                SizedBox(width: 8),
                Text('🚨', style: TextStyle(fontSize: 24)),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'THE IMPOSTER!',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                color: const Color(0xFFFF2A5F),
                letterSpacing: 6,
                shadows: [
                  const Shadow(
                      offset: Offset(0, 2),
                      blurRadius: 0,
                      color: Color(0xFF4A0008)),
                  Shadow(
                      offset: const Offset(0, 4),
                      blurRadius: 16 + pulse * 12,
                      color: const Color(0xFFFF2A5F)),
                  const Shadow(
                      offset: Offset(0, 8),
                      blurRadius: 24,
                      color: Colors.black),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Pulsing emergency status
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFFF3D71).withValues(alpha: 0.15),
                border: Border.all(
                  color: const Color(0xFFFF3D71).withValues(alpha: 0.3),
                ),
              ),
              child: const Text(
                'STATUS: REVEAL IN PROGRESS...',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFFF3D71),
                  letterSpacing: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _drumPulseAt(double t) {
    const drumTimes = [0.0, 0.14, 0.25, 0.34, 0.40, 0.44, 0.47, 0.49, 0.51];
    for (final dt in drumTimes) {
      final diff = (t - dt).abs();
      if (diff < 0.03) {
        return 1.0 - (diff / 0.03);
      }
    }
    return 0.0;
  }

  // ─── Reveal Content ───────────────────────────────────────────────────────

  Widget _buildRevealContent(double t, double pulse, BuildContext context) {
    final revealProgress = ((t - 0.65) / 0.15).clamp(0.0, 1.0);
    final slideUp = 50 * (1 - revealProgress);

    return Opacity(
      opacity: revealProgress,
      child: Transform.translate(
        offset: Offset(0, slideUp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title Header
            Text(
              _imposterNames.length > 1
                  ? '⚡ THE IMPOSTERS ARE REVEALED ⚡'
                  : '⚡ THE IMPOSTER IS REVEALED ⚡',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: const Color(0xFFFF3D71).withValues(alpha: 0.85),
                letterSpacing: 4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Imposter name cards with quotes
            ..._imposterNames.asMap().entries.map((entry) {
              final index = entry.key;
              final name = entry.value;
              final quote = _imposterQuotes[name] ?? 'The Mastermind of Deception!';

              final cardDelay = index * 0.05;
              final cardProgress =
                  ((revealProgress - cardDelay) / (1.0 - cardDelay))
                      .clamp(0.0, 1.0);

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Transform.scale(
                  scale: 0.75 + cardProgress * 0.25,
                  child: Opacity(
                    opacity: cardProgress,
                    child: _buildThrillerImposterCard(name, quote, pulse),
                  ),
                ),
              );
            }),

            const SizedBox(height: 24),

            // Back to home button
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

  Widget _buildThrillerImposterCard(String name, String quote, double pulse) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF3B000C),
                Color(0xFF1E0006),
                Color(0xFF0F0003),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: const Color(0xFFFF2A5F).withValues(alpha: 0.4 + pulse * 0.3),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF2A5F).withValues(alpha: 0.25 + pulse * 0.2),
                blurRadius: 30 + pulse * 20,
                spreadRadius: pulse * 6,
              ),
            ],
          ),
          child: Column(
            children: [
              // Emoji Avatar with Pulsing Aura
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFF2A5F).withValues(alpha: 0.15),
                  border: Border.all(
                    color: const Color(0xFFFF2A5F).withValues(alpha: 0.4),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF2A5F).withValues(alpha: 0.3),
                      blurRadius: 15,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text('😈', style: TextStyle(fontSize: 34)),
                ),
              ),
              const SizedBox(height: 14),

              // Player Name
              Text(
                name,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 2,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 2),
                      blurRadius: 8,
                      color: Colors.black,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              // Imposter Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFFF2A5F).withValues(alpha: 0.2),
                  border: Border.all(
                    color: const Color(0xFFFF2A5F).withValues(alpha: 0.4),
                  ),
                ),
                child: const Text(
                  'IMPOSTER',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFFF2A5F),
                    letterSpacing: 4,
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // Multilingual Suspense Quote Badge
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.black.withValues(alpha: 0.4),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
                child: Text(
                  '"$quote"',
                  style: const TextStyle(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFF8FAFC),
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
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
            color: Colors.white.withValues(alpha: 0.08),
            border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              borderRadius: BorderRadius.circular(16),
              splashColor: const Color(0xFFFF2A5F).withValues(alpha: 0.2),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.home_rounded, color: Colors.white70, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'BACK TO HOME',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
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
    final intensity = progress > 0.6 ? 1.6 : 0.7;

    for (var p in particles) {
      final x = (p.x / 1000) * size.width;
      final y = (p.y / 2000) * size.height;
      final color = Color.lerp(
        const Color(0xFF9C1B30),
        const Color(0xFFFF2A5F),
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
            ..color = color.withValues(alpha: p.opacity * 0.2)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
