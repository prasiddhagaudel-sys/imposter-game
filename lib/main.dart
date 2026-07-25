import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/game_setup_page.dart';
import 'dart:math';
import 'dart:ui';
import 'dart:io';
import 'dart:async';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFF3D71),
          secondary: Color(0xFF2563EB),
          surface: Color(0xFF1A1A2E),
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

  // Settings & Toggles
  bool _animationsEnabled = true;
  bool _soundEnabled = true;
  double _soundVolume = 0.8;

  // Easter egg states
  int _logoTapCount = 0;
  bool _glitchMode = false;
  int _devTapCount = 0;
  final List<_FloatingEmoji> _floatingEmojis = [];
  int _emojiIdCounter = 0;

  // Multilingual Homepage Taglines (Nepali, Hindi, English)
  final List<String> _homepageTaglines = [
    // Nepali
    'को छ त असली इम्पोस्टर? 🕵️‍♂️🔥',
    'सबै भन्दा ठुलो धोका साथीबाटै हुन्छ! 🤫💥',
    'कुरा चपाउनुस्, रहस्य लुकाउनुस्! 🎭✨',
    'शंका नगरि कसैलाई नपत्याउनुस्! 👁️⚡',
    'एकजना झुट बोल्दैछ... पहिचान गर्नुहोस्! 😈💣',

    // Hindi
    'कौन है तुम्हारे बीच का गद्दार? 🕵️‍♂️🔥',
    'शक्ल से मासूम, दिमाग से शैतान! 😈⚡',
    'बातों में फुसलाओ, राज़ छुपाओ! 🤫✨',
    'सब पर शक करो, किसी पर भरोसा नहीं! 👁️💥',
    'एक झूठा पकड़ा जाएगा! 🎭👑',

    // English
    'Blend in. Deceive. Survive. 😈🔥',
    'Trust no one. Not even your best friend! 🤫⚡',
    'One lie can ruin your whole crew! 👁️💥',
    'Find the wolf among the sheep! 🐺✨',
    'The ultimate game of lies and suspicion! 🎭👑',
  ];

  late String _currentHomepageTagline;
  Timer? _sloganTimer;

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

    _currentHomepageTagline =
        _homepageTaglines[_random.nextInt(_homepageTaglines.length)];

    // Automatically change homepage slogan every 4 seconds
    _sloganTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (mounted) {
        setState(() {
          _currentHomepageTagline =
              _homepageTaglines[_random.nextInt(_homepageTaglines.length)];
        });
      }
    });

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
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Floating animation for logo
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _floatAnimation = Tween<double>(begin: -8.0, end: 8.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    // Glitch animation controller
    _glitchController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _initParticles();
    _particleController.addListener(_updateParticles);
  }

  void _initParticles() {
    final colors = [
      const Color(0xFF9C1B30),
      const Color(0xFF2563EB),
      const Color(0xFF3B82F6),
      const Color(0xFF36F1CD),
    ];

    for (int i = 0; i < 40; i++) {
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
    if (!_animationsEnabled) return;
    for (var p in _particles) {
      p.x += p.speedX;
      p.y += p.speedY;

      if (p.x < 0) p.x = 1000;
      if (p.x > 1000) p.x = 0;
      if (p.y < 0) p.y = 3000;
      if (p.y > 3000) p.y = 0;
    }
    _updateFloatingEmojis();
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

  // Tap subtitle to rotate random multilingual taglines
  void _onSecretTap() {
    setState(() {
      _currentHomepageTagline =
          _homepageTaglines[_random.nextInt(_homepageTaglines.length)];
    });
  }

  // Easter Egg: Developer Prasiddha credit tap
  void _onDevTap() {
    _devTapCount++;
    if (_devTapCount >= 5) {
      _devTapCount = 0;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Text('👑', style: TextStyle(fontSize: 22)),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'DEVELOPER MODE: Created with passion by Prasiddha!',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
          backgroundColor: const Color(0xFF2563EB),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  // Easter Egg: Spawn single floating emoji on click
  void _spawnEmoji(Offset position) {
    if (!_animationsEnabled) return;
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
    _sloganTimer?.cancel();
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
            if (_animationsEnabled)
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

            // Main Hero Content
            Positioned.fill(
              child: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: _buildHeroSection(context),
                  ),
                ),
              ),
            ),

            // Settings Gear Button (Pinned top-right)
            Positioned(
              top: 16,
              right: 16,
              child: SafeArea(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _openSettingsDialog(context),
                    borderRadius: BorderRadius.circular(30),
                    splashColor: const Color(0xFFFF3D71).withValues(alpha: 0.3),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.08),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.15),
                          width: 1.2,
                        ),
                      ),
                      child: const Icon(
                        Icons.settings_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Floating emojis overlay (easter egg)
            if (_animationsEnabled)
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
                const Color(0xFF9C1B30).withValues(alpha: 0.18),
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
                const Color(0xFF2563EB).withValues(alpha: 0.16),
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
                const Color(0xFF3B82F6).withValues(alpha: 0.12),
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
    final logoSize = (screenWidth * 0.45).clamp(160.0, 310.0);
    final titleFontSize = (screenWidth * 0.11).clamp(32.0, 54.0);
    final letterSpacing = (screenWidth * 0.025).clamp(4.0, 14.0);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth > 600 ? 48 : 20,
        vertical: isSmallMobile ? 12 : 24,
      ),
      child: AnimatedBuilder(
        animation: _floatAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _animationsEnabled ? _floatAnimation.value : 0),
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

            // Multilingual Random Subtitle Accent
            GestureDetector(
              onTap: _onSecretTap,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  key: ValueKey(_currentHomepageTagline),
                  _currentHomepageTagline,
                  style: TextStyle(
                    fontSize: isSmallMobile ? 14 : 17,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withValues(alpha: 0.9),
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // INCREASED TOP SPACING BEFORE START GAME BUTTON
            SizedBox(height: isSmallMobile ? 36 : 48),

            // Dark Red Portal Start Button
            _buildDarkRedPortalButton(),

            const SizedBox(height: 32),

            // Developer Prasiddha Credit
            GestureDetector(
              onTap: _onDevTap,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withValues(alpha: 0.04),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('❤️', style: TextStyle(fontSize: 13)),
                    const SizedBox(width: 6),
                    Text(
                      'Developed by Integrators',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withValues(alpha: 0.7),
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Settings Gear Dialog ─────────────────────────────────────────────────

  void _openSettingsDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.88,
              decoration: const BoxDecoration(
                color: Color(0xFF0F0F23),
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                border: Border(
                  top: BorderSide(color: Color(0xFF2563EB), width: 2),
                ),
              ),
              child: Column(
                children: [
                  // Handle bar
                  Container(
                    margin: const EdgeInsets.only(top: 12, bottom: 8),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  // Header title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Text('⚙️', style: TextStyle(fontSize: 22)),
                            SizedBox(width: 10),
                            Text(
                              'SETTINGS & GUIDE',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.close_rounded, color: Colors.white70),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),

                  const Divider(color: Colors.white10, height: 1),

                  // Modal Body Content
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        // --- 1. Video & Performance Settings ---
                        _buildSettingsHeader('🎥', 'VIDEO & ANIMATIONS'),
                        const SizedBox(height: 10),
                        _buildSettingsTile(
                          icon: Icons.animation_rounded,
                          title: 'Animations & Visual Effects',
                          subtitle: 'Turn off background particles & floating effects for low-end devices',
                          trailing: Switch(
                            value: _animationsEnabled,
                            activeTrackColor: const Color(0xFF2563EB),
                            onChanged: (val) {
                              setState(() => _animationsEnabled = val);
                              setModalState(() {});
                            },
                          ),
                        ),

                        const SizedBox(height: 24),

                        // --- 2. Audio & Sound Control ---
                        _buildSettingsHeader('🎵', 'AUDIO & SOUND'),
                        const SizedBox(height: 10),
                        _buildSettingsTile(
                          icon: _soundEnabled ? Icons.volume_up_rounded : Icons.volume_off_rounded,
                          title: 'Sound Effects',
                          subtitle: 'Enable or disable in-game audio cues',
                          trailing: Switch(
                            value: _soundEnabled,
                            activeTrackColor: const Color(0xFF2563EB),
                            onChanged: (val) {
                              setState(() => _soundEnabled = val);
                              setModalState(() {});
                            },
                          ),
                        ),
                        if (_soundEnabled) ...[
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                const Icon(Icons.volume_down_rounded, size: 18, color: Colors.white54),
                                Expanded(
                                  child: Slider(
                                    value: _soundVolume,
                                    activeColor: const Color(0xFF2563EB),
                                    inactiveColor: Colors.white12,
                                    onChanged: (val) {
                                      setState(() => _soundVolume = val);
                                      setModalState(() {});
                                    },
                                  ),
                                ),
                                const Icon(Icons.volume_up_rounded, size: 18, color: Colors.white54),
                              ],
                            ),
                          ),
                        ],

                        const SizedBox(height: 24),

                        // --- 3. How to Play & Game Overview (Full Content) ---
                        _buildSettingsHeader('📖', 'HOW TO PLAY & GAME GUIDE'),
                        const SizedBox(height: 12),
                        _buildGameOverviewSection(context),
                        const SizedBox(height: 16),
                        _buildHowToPlaySection(context),
                        const SizedBox(height: 16),
                        _buildRolesSection(context),

                        const SizedBox(height: 24),

                        // --- 4. Privacy Policy ---
                        _buildSettingsHeader('🔒', 'PRIVACY POLICY'),
                        const SizedBox(height: 10),
                        _buildPrivacyPolicyCard(),

                        const SizedBox(height: 24),

                        // --- 5. Exit Game Button ---
                        _buildExitButton(context),

                        const SizedBox(height: 24),

                        // --- 6. Developer Credit ---
                        _buildDeveloperCredit(context),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSettingsHeader(String emoji, String title) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: Color(0xFF2563EB),
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
  }) {
    return _buildGlassCard(
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          trailing,
        ],
      ),
    );
  }

  Widget _buildPrivacyPolicyCard() {
    return _buildGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.verified_user_rounded, color: Color(0xFF36F1CD), size: 20),
              SizedBox(width: 8),
              Text(
                '100% Offline & Private',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF36F1CD),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Imposter does not collect, store, or transmit any personal data. '
            'Zero internet connectivity is required. All game settings and states '
            'remain strictly on your local device.',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withValues(alpha: 0.7),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExitButton(BuildContext context) {
    return _buildGlassCard(
      borderColor: const Color(0xFFFF3D71).withValues(alpha: 0.4),
      child: InkWell(
        onTap: () {
          SystemNavigator.pop();
          if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
            exit(0);
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.power_settings_new_rounded, color: Color(0xFFFF3D71)),
              SizedBox(width: 10),
              Text(
                'EXIT GAME',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFFF3D71),
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeveloperCredit(BuildContext context) {
    return GestureDetector(
      onTap: _onDevTap,
      child: Center(
        child: Column(
          children: [
            Text(
              'Developed with ❤️ by Integrators',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white.withValues(alpha: 0.6),
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'v1.0.1 Release • Master of Deception',
              style: TextStyle(
                fontSize: 11,
                color: Colors.white.withValues(alpha: 0.3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Game Overview Section ────────────────────────────────────────────────

  Widget _buildGameOverviewSection(BuildContext context) {
    return _buildGlassCard(
      child: Column(
        children: [
          const Text('🎭', style: TextStyle(fontSize: 40)),
          const SizedBox(height: 14),
          Text(
            'A social deduction party game where trust is your greatest weapon — and your biggest vulnerability.',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white.withValues(alpha: 0.85),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          _buildDivider(),
          const SizedBox(height: 16),
          Text(
            'Players receive a secret word. Imposters only get a vague hint. '
            'Through clever conversation and sharp observation, figure out who\'s faking it '
            '— before they figure out the word.',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withValues(alpha: 0.6),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ─── How To Play Section ──────────────────────────────────────────────────

  Widget _buildHowToPlaySection(BuildContext context) {
    final steps = [
      _HowToPlayStep(
        icon: '👥',
        title: 'Gather Your Crew',
        description: 'Get 3-20 players together. Choose how many imposters will infiltrate the group.',
        number: '01',
      ),
      _HowToPlayStep(
        icon: '📱',
        title: 'Pass The Phone',
        description: 'Each player secretly views their role. Civilians see the word. Imposters see only a hint.',
        number: '02',
      ),
      _HowToPlayStep(
        icon: '🗣️',
        title: 'Discuss & Deceive',
        description: 'Take turns describing the word. Imposters must bluff convincingly without knowing the exact word.',
        number: '03',
      ),
      _HowToPlayStep(
        icon: '🗳️',
        title: 'Vote & Eliminate',
        description: 'After discussion, vote on who you think the imposter is. Get it right, or the imposter wins!',
        number: '04',
      ),
    ];

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: _buildGlassCard(
        child: Material(
          color: Colors.transparent,
          child: ExpansionTile(
            initiallyExpanded: false,
            tilePadding: EdgeInsets.zero,
            childrenPadding: const EdgeInsets.only(top: 14),
            iconColor: const Color(0xFF2563EB),
            collapsedIconColor: Colors.white70,
            title: const Row(
              children: [
                Text('📖', style: TextStyle(fontSize: 20)),
                SizedBox(width: 10),
                Text(
                  'How To Play Rules',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
            children: steps.map((step) => _buildStepCard(step)).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildStepCard(_HowToPlayStep step) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: _buildGlassCard(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFF26263A),
                border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
              ),
              child: Center(
                child: Text(
                  step.number,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(step.icon, style: const TextStyle(fontSize: 18)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          step.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    step.description,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.6),
                      height: 1.5,
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
    return Column(
      children: [
        _buildRoleCard(isImposter: false),
        const SizedBox(height: 12),
        _buildRoleCard(isImposter: true),
      ],
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
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: isImposter
                    ? [const Color(0xFFFF3D71), const Color(0xFFFF6B35)]
                    : [const Color(0xFF36F1CD), const Color(0xFF00D9FF)],
              ),
            ),
            child: Center(
              child: Text(
                isImposter ? '😈' : '😇',
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            isImposter ? 'IMPOSTER' : 'PLAYER',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
              color: isImposter
                  ? const Color(0xFFFF3D71)
                  : const Color(0xFF36F1CD),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isImposter
                ? 'You only receive a vague hint. Blend in with the crowd, fake your knowledge, and avoid getting caught!'
                : 'You know the secret word. Describe it cleverly without giving it away to the imposter!',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withValues(alpha: 0.6),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
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
        final pulse = _animationsEnabled ? _pulseAnimation.value : 1.0;

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
                  Color(0xFF881337),
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
                        angle: _animationsEnabled ? _floatController.value * pi * 2 : 0,
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
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withValues(alpha: 0.05),
            border: Border.all(
              color: borderColor ?? Colors.white.withValues(alpha: 0.08),
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 60,
      height: 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: Colors.white.withValues(alpha: 0.15),
      ),
    );
  }
}

// ─── Custom Particle Painter ────────────────────────────────────────────────

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final bool glitchMode;

  _ParticlePainter({
    required this.particles,
    required this.glitchMode,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (var p in particles) {
      final paint = Paint()
        ..color = glitchMode
            ? const Color(0xFFFF3D71).withValues(alpha: p.opacity * 0.8)
            : p.color.withValues(alpha: p.opacity);

      final offset = Offset(
        (p.x / 1000) * size.width,
        (p.y / 3000) * size.height,
      );

      canvas.drawCircle(offset, p.radius, paint);
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
