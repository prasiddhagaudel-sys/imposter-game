import 'package:flutter/material.dart';
import 'pages/game_setup_page.dart';
import 'dart:math';
import 'dart:ui';

void main() {
  runApp(const ImposterApp());
}

class ImposterApp extends StatelessWidget {
  const ImposterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Imposter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFFFF3D71),
          secondary: const Color(0xFF7B61FF),
          surface: const Color(0xFF1A1A2E),
        ),
        scaffoldBackgroundColor: const Color(0xFF0A0A1A),
      ),
      home: const LandingPage(),
    );
  }
}

// ─── Floating Particle Model ────────────────────────────────────────────────

class _Particle {
  double x;
  double y;
  double speedX;
  double speedY;
  double radius;
  Color color;
  double opacity;

  _Particle({
    required this.x,
    required this.y,
    required this.speedX,
    required this.speedY,
    required this.radius,
    required this.color,
    required this.opacity,
  });
}

// ─── Landing Page ───────────────────────────────────────────────────────────

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  late AnimationController _particleController;
  late AnimationController _pulseController;
  late AnimationController _floatController;
  late AnimationController _glitchController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _floatAnimation;

  final List<_Particle> _particles = [];
  final Random _random = Random();
  final ScrollController _scrollController = ScrollController();

  // Easter egg states
  int _logoTapCount = 0;
  bool _glitchMode = false;
  bool _secretRevealed = false;
  int _secretTapCount = 0;
  final List<_FloatingEmoji> _floatingEmojis = [];
  int _emojiIdCounter = 0;

  // Suspicious & playful emojis for the click easter egg
  final List<String> _suspiciousWords = [
    '🔍', '👀', '🤫', '❓', '🕵️', '😈', '🎭', '👁️', '💀', '💣',
    '🔥', '🔪', '🚨', '🩸', '👻', '🤡', '🤯', '👺', '🛸', '⚡',
    '🗝️', '🧬', '🔮', '🎉', '🏆', '👾', '🎲', '💥', '🏴‍☠️', '🎯',
    '📍', '💡', '‼️', '🍕', '🐺', '🦊', '🐉', '☣️', '✨', '👑',
    '🥳', '😎', '😜', '🚀', '⭐', '💎', '🍿', '🎸', '🎮', '🧩',
    '🤖', '👽', '🦄', '🦁', '🦉', '🦈', '🌋', '🎃', '🧿', '📜',
    '⚖️', '🧭', '⏳', '🛡️', '⚔️', '🏹', '🎩', '🔮', '💫', '🎆'
  ];

  @override
  void initState() {
    super.initState();

    // Particle animation controller
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    // Pulse animation for the start button
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.08,
    ).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));

    // Float animation for hero section
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(
      begin: -8.0,
      end: 8.0,
    ).animate(CurvedAnimation(parent: _floatController, curve: Curves.easeInOut));

    // Glitch controller for easter egg
    _glitchController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    // Initialize particles
    _initParticles();

    _particleController.addListener(() {
      _updateParticles();
      _updateFloatingEmojis();
    });
  }

  void _initParticles() {
    final colors = [
      const Color(0xFFFF3D71),
      const Color(0xFF7B61FF),
      const Color(0xFF00D9FF),
      const Color(0xFFFF6B35),
      const Color(0xFF36F1CD),
    ];

    for (int i = 0; i < 50; i++) {
      _particles.add(_Particle(
        x: _random.nextDouble() * 1000,
        y: _random.nextDouble() * 3000,
        speedX: (_random.nextDouble() - 0.5) * 0.8,
        speedY: (_random.nextDouble() - 0.5) * 0.5,
        radius: _random.nextDouble() * 3 + 1,
        color: colors[_random.nextInt(colors.length)],
        opacity: _random.nextDouble() * 0.4 + 0.1,
      ));
    }
  }

  void _updateParticles() {
    for (var p in _particles) {
      p.x += p.speedX;
      p.y += p.speedY;
      if (p.x < 0) p.x = 1000;
      if (p.x > 1000) p.x = 0;
      if (p.y < 0) p.y = 3000;
      if (p.y > 3000) p.y = 0;
    }
  }

  void _updateFloatingEmojis() {
    for (var emoji in _floatingEmojis) {
      emoji.x += emoji.vx;
      emoji.y -= emoji.speed;
      emoji.opacity -= 0.005;
      emoji.rotation += emoji.rotationSpeed;
    }
    _floatingEmojis.removeWhere((e) => e.opacity <= 0 || e.y < -50);
  }

  // Easter Egg: Logo tap triggers glitch
  void _onLogoTap() {
    _logoTapCount++;

    if (_logoTapCount >= 5) {
      setState(() {
        _glitchMode = !_glitchMode;
        _logoTapCount = 0;
      });
      _glitchController.forward(from: 0);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _glitchMode ? '👁️ The imposter is watching...' : '😌 Back to normal... or is it?',
            style: const TextStyle(
              fontFamily: 'Courier',
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: const Color(0xFFFF3D71).withValues(alpha: 0.9),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  // Easter Egg: Triple tap the subtitle to reveal a secret
  void _onSecretTap() {
    _secretTapCount++;
    if (_secretTapCount >= 3) {
      setState(() {
        _secretRevealed = !_secretRevealed;
        _secretTapCount = 0;
      });
    }
  }

  // Easter Egg: Spawn single floating emoji on click
  void _spawnEmoji(Offset position) {
    setState(() {
      _floatingEmojis.add(_FloatingEmoji(
        id: _emojiIdCounter++,
        x: position.dx,
        y: position.dy,
        vx: (_random.nextDouble() - 0.5) * 1.0,
        emoji: _suspiciousWords[_random.nextInt(_suspiciousWords.length)],
        speed: _random.nextDouble() * 1.5 + 0.8,
        opacity: 1.0,
        rotation: _random.nextDouble() * pi * 2,
        rotationSpeed: (_random.nextDouble() - 0.5) * 0.08,
      ));
    });
  }

  @override
  void dispose() {
    _particleController.dispose();
    _pulseController.dispose();
    _floatController.dispose();
    _glitchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A1A),
      body: GestureDetector(
        onTapDown: (details) => _spawnEmoji(details.globalPosition),
        child: Stack(
          children: [
            // Animated background particles
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _particleController,
                builder: (context, _) {
                  return CustomPaint(
                    painter: _ParticlePainter(
                      particles: _particles,
                      glitchMode: _glitchMode,
                    ),
                  );
                },
              ),
            ),

            // Background gradient orbs
            ..._buildBackgroundOrbs(),

            // Main scrollable content
            Positioned.fill(
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _buildHeroSection(context),
                    _buildGameOverviewSection(context),
                    _buildHowToPlaySection(context),
                    _buildRolesSection(context),
                    _buildFooterSection(context),
                  ],
                ),
              ),
            ),

            // Floating emojis overlay (easter egg)
            ...(_floatingEmojis.map((emoji) => Positioned(
                  key: ValueKey('emoji_${emoji.id}'),
                  left: emoji.x - 15,
                  top: emoji.y - 15,
                  child: AnimatedBuilder(
                    animation: _particleController,
                    builder: (context, _) {
                      return Opacity(
                        opacity: emoji.opacity.clamp(0.0, 1.0),
                        child: Transform.rotate(
                          angle: emoji.rotation,
                          child: Text(
                            emoji.emoji,
                            style: const TextStyle(fontSize: 28),
                          ),
                        ),
                      );
                    },
                  ),
                ))),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBackgroundOrbs() {
    return [
      Positioned(
        top: -100,
        left: -100,
        child: Container(
          width: 350,
          height: 350,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                const Color(0xFF9C1B30).withValues(alpha: 0.18), // Blood Red
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
      Positioned(
        top: 400,
        right: -150,
        child: Container(
          width: 400,
          height: 400,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                const Color(0xFF2563EB).withValues(alpha: 0.16), // Calm Royal Blue
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 200,
        left: -80,
        child: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                const Color(0xFF3B82F6).withValues(alpha: 0.12), // Calm Sky Blue
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    ];
  }

  // ─── Hero Section ────────────────────────────────────────────────────────

  Widget _buildHeroSection(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final isSmallMobile = screenWidth < 480;

    // Dynamic responsive sizing
    final logoSize = (screenWidth * 0.45).clamp(160.0, 320.0);
    final titleFontSize = (screenWidth * 0.11).clamp(32.0, 54.0);
    final letterSpacing = (screenWidth * 0.025).clamp(4.0, 14.0);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: screenWidth > 600 ? 48 : 20,
        right: screenWidth > 600 ? 48 : 20,
        top: isSmallMobile ? 8 : 16,
        bottom: 32,
      ),
      child: AnimatedBuilder(
        animation: _floatAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _floatAnimation.value),
            child: child,
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo with easter egg
            Center(
              child: GestureDetector(
                onTap: _onLogoTap,
                child: AnimatedBuilder(
                  animation: _glitchController,
                  builder: (context, child) {
                    final glitchOffset = _glitchMode
                        ? sin(_glitchController.value * pi * 8) * 3
                        : 0.0;
                    return Transform.translate(
                      offset: Offset(glitchOffset, 0),
                      child: child,
                    );
                  },
                  child: SizedBox(
                    width: logoSize,
                    height: logoSize,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Text(
                            '😈',
                            style: TextStyle(fontSize: logoSize * 0.5),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: isSmallMobile ? 4 : 8),

            // Dynamic Responsive Title
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'IMPOSTER',
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF9C1B30),
                  letterSpacing: letterSpacing,
                  height: 1.0,
                  shadows: const [
                    Shadow(offset: Offset(0, 2), blurRadius: 0, color: Color(0xFF4A0008)),
                    Shadow(offset: Offset(0, 4), blurRadius: 8, color: Color(0xFF9C1B30)),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 8),

            // Cursive Subtitle Accent
            GestureDetector(
              onTap: _onSecretTap,
              child: Text(
                _secretRevealed
                    ? '🤫 Trust no one. Not even yourself.'
                    : 'Blend in. Deceive. Survive.',
                style: TextStyle(
                  fontSize: isSmallMobile ? 14 : 17,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  color: _secretRevealed
                      ? const Color(0xFFFF3D71)
                      : Colors.white.withValues(alpha: 0.85),
                  letterSpacing: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 24),

            // Dark Red Portal Start Button
            _buildDarkRedPortalButton(),

            const SizedBox(height: 24),

            // Scroll hint
            AnimatedBuilder(
              animation: _floatController,
              builder: (context, _) {
                return Opacity(
                  opacity: (sin(_floatController.value * pi) * 0.5 + 0.5)
                      .clamp(0.3, 0.7),
                  child: Column(
                    children: [
                      Text(
                        'Scroll to explore',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.3),
                          fontSize: 12,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.white.withValues(alpha: 0.3),
                        size: 24,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ─── Game Overview Section ────────────────────────────────────────────────

  Widget _buildGameOverviewSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth > 600 ? 48 : 24,
        vertical: 60,
      ),
      child: Column(
        children: [
          _buildSectionTitle('WHAT IS IMPOSTER?'),
          const SizedBox(height: 32),

          // Glass card for overview
          _buildGlassCard(
            child: Column(
              children: [
                const Text(
                  '🎭',
                  style: TextStyle(fontSize: 48),
                ),
                const SizedBox(height: 20),
                Text(
                  'A social deduction party game where trust is your greatest weapon — and your biggest vulnerability.',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white.withValues(alpha: 0.85),
                    height: 1.7,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                _buildDivider(),
                const SizedBox(height: 24),
                Text(
                  'Players receive a secret word. Imposters only get a vague hint. '
                  'Through clever conversation and sharp observation, figure out who\'s faking it '
                  '— before they figure out the word.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white.withValues(alpha: 0.6),
                    height: 1.7,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Feature cards
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              _buildFeatureChip(Icons.groups_rounded, '3-10 Players'),
              _buildFeatureChip(Icons.timer_rounded, '5 Min Rounds'),
              _buildFeatureChip(Icons.phone_android_rounded, '1 Device'),
              _buildFeatureChip(Icons.wifi_off_rounded, 'No Internet'),
            ],
          ),
        ],
      ),
    );
  }

  // ─── How To Play Section ──────────────────────────────────────────────────

  Widget _buildHowToPlaySection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final steps = [
      _HowToPlayStep(
        icon: '👥',
        title: 'Gather Your Crew',
        description:
            'Get 3-10 players together. Choose how many imposters will infiltrate the group.',
        number: '01',
      ),
      _HowToPlayStep(
        icon: '📱',
        title: 'Pass The Phone',
        description:
            'Each player secretly views their role. Players see the word. Imposters see only a hint.',
        number: '02',
      ),
      _HowToPlayStep(
        icon: '🗣️',
        title: 'Discuss & Deceive',
        description:
            'Take turns describing the word. Imposters must bluff convincingly without knowing the exact word.',
        number: '03',
      ),
      _HowToPlayStep(
        icon: '🗳️',
        title: 'Vote & Eliminate',
        description:
            'After discussion, vote on who you think the imposter is. Get it right, or the imposter wins!',
        number: '04',
      ),
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth > 600 ? 48 : 24,
        vertical: 60,
      ),
      child: Column(
        children: [
          _buildSectionTitle('HOW TO PLAY'),
          const SizedBox(height: 40),
          ...steps.map((step) => _buildStepCard(step)),
        ],
      ),
    );
  }

  Widget _buildStepCard(_HowToPlayStep step) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: _buildGlassCard(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step number (Grey background)
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: const Color(0xFF26263A),
                border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
              ),
              child: Center(
                child: Text(
                  step.number,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(step.icon, style: const TextStyle(fontSize: 20)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          step.title,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    step.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.6),
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Roles Section ────────────────────────────────────────────────────────

  Widget _buildRolesSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth > 600 ? 48 : 24,
        vertical: 60,
      ),
      child: Column(
        children: [
          _buildSectionTitle('THE ROLES'),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 500) {
                return Row(
                  children: [
                    Expanded(child: _buildRoleCard(isImposter: false)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildRoleCard(isImposter: true)),
                  ],
                );
              }
              return Column(
                children: [
                  _buildRoleCard(isImposter: false),
                  const SizedBox(height: 16),
                  _buildRoleCard(isImposter: true),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRoleCard({required bool isImposter}) {
    return _buildGlassCard(
      borderColor: isImposter
          ? const Color(0xFFFF3D71).withValues(alpha: 0.3)
          : const Color(0xFF36F1CD).withValues(alpha: 0.3),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: isImposter
                    ? [const Color(0xFFFF3D71), const Color(0xFFFF6B35)]
                    : [const Color(0xFF36F1CD), const Color(0xFF00D9FF)],
              ),
              boxShadow: [
                BoxShadow(
                  color: (isImposter
                          ? const Color(0xFFFF3D71)
                          : const Color(0xFF36F1CD))
                      .withValues(alpha: 0.3),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: Text(
                isImposter ? '😈' : '😇',
                style: const TextStyle(fontSize: 28),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            isImposter ? 'IMPOSTER' : 'PLAYER',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              letterSpacing: 3,
              color: isImposter
                  ? const Color(0xFFFF3D71)
                  : const Color(0xFF36F1CD),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            isImposter
                ? 'You only receive a vague hint. Blend in with the crowd, fake your knowledge, and avoid getting caught!'
                : 'You know the secret word. Describe it cleverly without giving it away to the imposter!',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withValues(alpha: 0.6),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: (isImposter
                      ? const Color(0xFFFF3D71)
                      : const Color(0xFF36F1CD))
                  .withValues(alpha: 0.1),
              border: Border.all(
                color: (isImposter
                        ? const Color(0xFFFF3D71)
                        : const Color(0xFF36F1CD))
                    .withValues(alpha: 0.2),
              ),
            ),
            child: Text(
              isImposter ? 'Gets: A Hint 🔍' : 'Gets: The Word 📝',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isImposter
                    ? const Color(0xFFFF3D71)
                    : const Color(0xFF36F1CD),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Footer Section ───────────────────────────────────────────────────────

  Widget _buildFooterSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth > 600 ? 48 : 24,
        vertical: 60,
      ),
      child: Column(
        children: [
          _buildGlassCard(
            child: Column(
              children: [
                const Text(
                  '🚀',
                  style: TextStyle(fontSize: 40),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Ready to find the imposter?',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Gather your friends and start the chaos.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                _buildLavaButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder:
                            (context, animation, secondaryAnimation) =>
                                const GameSetupPage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 500),
                      ),
                    );
                  },
                  width: screenWidth > 400 ? 260 : screenWidth * 0.75,
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          // Hidden easter egg text
          GestureDetector(
            onLongPress: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    '🕵️ You found a secret! The imposter was here all along...',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  backgroundColor:
                      const Color(0xFFFF3D71).withValues(alpha: 0.9),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  duration: const Duration(seconds: 3),
                ),
              );
            },
            child: Text(
              'made with 🤫 and suspicion',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withValues(alpha: 0.15),
                letterSpacing: 2,
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // ─── Reusable Components ──────────────────────────────────────────────────

  Widget _buildDarkRedPortalButton() {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth > 400 ? 300.0 : screenWidth * 0.85;

    return AnimatedBuilder(
      animation: Listenable.merge([_pulseController, _floatController]),
      builder: (context, child) {
        final pulse = _pulseAnimation.value;

        return Transform.scale(
          scale: pulse,
          child: Container(
            width: buttonWidth,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              gradient: const RadialGradient(
                center: Alignment.center,
                radius: 1.2,
                colors: [
                  Color(0xFF881337), // Dark red inside
                  Color(0xFF4A0008),
                  Color(0xFF1E0003),
                ],
                stops: [0.0, 0.6, 1.0],
              ),
              border: Border.all(
                color: const Color(0xFFFF3D71).withValues(alpha: 0.85),
                width: 2,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const GameSetupPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 500),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(32),
                splashColor: const Color(0xFFFF3D71).withValues(alpha: 0.2),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.rotate(
                        angle: _floatController.value * pi * 2,
                        child: const Text('🌀', style: TextStyle(fontSize: 22)),
                      ),
                      const SizedBox(width: 14),
                      const Text(
                        'START GAME',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 4,
                          shadows: [
                            Shadow(
                              offset: Offset(0, 2),
                              blurRadius: 8,
                              color: Color(0xFF4A0008),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLavaButton({
    required VoidCallback onPressed,
    double? width,
  }) {
    return AnimatedBuilder(
      animation: Listenable.merge([_pulseController, _floatController]),
      builder: (context, child) {
        final floatVal = sin(_floatController.value * pi * 2);
        final pulse = _pulseAnimation.value;

        return Transform.scale(
          scale: pulse,
          child: Container(
            width: width ?? 260,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                colors: const [
                  Color(0xFFFF8C00), // Molten Orange
                  Color(0xFFFF4500), // Fiery Magma Red
                  Color(0xFFB71C1C), // Deep Lava Crimson
                  Color(0xFF4A0000), // Dark Volcanic Crust
                ],
                begin: Alignment(-1.0 + floatVal * 0.3, -1.0),
                end: Alignment(1.0 - floatVal * 0.3, 1.0),
              ),
              border: Border.all(
                color: Color.lerp(
                  const Color(0xFFFFD700),
                  const Color(0xFFFF4500),
                  (floatVal + 1) / 2,
                )!,
                width: 2.2,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onPressed,
                borderRadius: BorderRadius.circular(30),
                splashColor: const Color(0xFFFFD700).withValues(alpha: 0.3),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('🌋', style: TextStyle(fontSize: 22)),
                      SizedBox(width: 10),
                      Text(
                        'START GAME',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 3,
                          shadows: [
                            Shadow(
                              offset: Offset(0, 2),
                              blurRadius: 6,
                              color: Color(0xFF4A0000),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: Color(0xFFF8FAFC),
            letterSpacing: 5,
            shadows: [
              Shadow(offset: Offset(0, 2), blurRadius: 12, color: Color(0xFF2563EB)),
              Shadow(offset: Offset(0, 4), blurRadius: 20, color: Colors.black),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Container(
          width: 60,
          height: 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colors.white.withValues(alpha: 0.85),
          ),
        ),
      ],
    );
  }

  Widget _buildGlassCard({
    required Widget child,
    Color? borderColor,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withValues(alpha: 0.05),
            border: Border.all(
              color: borderColor ?? Colors.white.withValues(alpha: 0.08),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildFeatureChip(IconData icon, String label) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white.withValues(alpha: 0.06),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: const Color(0xFF7B61FF)),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withValues(alpha: 0.7),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 80,
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Colors.white.withValues(alpha: 0.2),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}

// ─── Particle Painter ───────────────────────────────────────────────────────

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final bool glitchMode;

  _ParticlePainter({required this.particles, required this.glitchMode});

  @override
  void paint(Canvas canvas, Size size) {
    for (var p in particles) {
      final x = (p.x / 1000) * size.width;
      final y = (p.y / 3000) * size.height;

      final paint = Paint()
        ..color = (glitchMode ? const Color(0xFFFF3D71) : p.color)
            .withValues(alpha: p.opacity)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), p.radius, paint);

      // Draw a subtle glow around larger particles
      if (p.radius > 2) {
        final glowPaint = Paint()
          ..color = p.color.withValues(alpha: p.opacity * 0.3)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
        canvas.drawCircle(Offset(x, y), p.radius * 2.5, glowPaint);
      }
    }

    // Draw connection lines between nearby particles
    for (int i = 0; i < particles.length; i++) {
      for (int j = i + 1; j < particles.length; j++) {
        final x1 = (particles[i].x / 1000) * size.width;
        final y1 = (particles[i].y / 3000) * size.height;
        final x2 = (particles[j].x / 1000) * size.width;
        final y2 = (particles[j].y / 3000) * size.height;

        final distance = sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));

        if (distance < 100) {
          final opacity = (1 - distance / 100) * 0.15;
          final linePaint = Paint()
            ..color = Colors.white.withValues(alpha: opacity)
            ..strokeWidth = 0.5;
          canvas.drawLine(Offset(x1, y1), Offset(x2, y2), linePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ─── Data Models ────────────────────────────────────────────────────────────

class _HowToPlayStep {
  final String icon;
  final String title;
  final String description;
  final String number;

  _HowToPlayStep({
    required this.icon,
    required this.title,
    required this.description,
    required this.number,
  });
}

class _FloatingEmoji {
  int id;
  double x;
  double y;
  double vx;
  String emoji;
  double speed;
  double opacity;
  double rotation;
  double rotationSpeed;

  _FloatingEmoji({
    required this.id,
    required this.x,
    required this.y,
    this.vx = 0.0,
    required this.emoji,
    required this.speed,
    required this.opacity,
    required this.rotation,
    required this.rotationSpeed,
  });
}
