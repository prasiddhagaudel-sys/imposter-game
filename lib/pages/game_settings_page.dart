import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';
import 'game_play_page.dart';

class GameSettingsPage extends StatefulWidget {
  final List<String> playerNames;

  const GameSettingsPage({super.key, required this.playerNames});

  @override
  State<GameSettingsPage> createState() => _GameSettingsPageState();
}

class _GameSettingsPageState extends State<GameSettingsPage>
    with TickerProviderStateMixin {
  // ─── Settings State ─────────────────────────────────────────────────────
  int _imposterCount = 1;
  int _hintCount = 1;
  String _selectedCategory = 'Random';
  double _timerMinutes = 3.0; // 1.0 to 15.0, step 0.5

  final List<String> _categories = [
    'Random',
    'Food & Drinks',
    'Culture & Festivals',
    'Everyday Objects',
    'Places & Travel',
    'Animals',
    'Movies & TV',
    'Sports',
    'Occupations',
    'Technology',
    'Nature',
  ];

  // ─── Category Icons ─────────────────────────────────────────────────────
  final Map<String, String> _categoryEmojis = {
    'Random': '🎲',
    'Food & Drinks': '🍕',
    'Culture & Festivals': '🪔',
    'Everyday Objects': '🔑',
    'Places & Travel': '🌍',
    'Animals': '🐾',
    'Movies & TV': '🎬',
    'Sports': '⚽',
    'Occupations': '👔',
    'Technology': '💻',
    'Nature': '🌿',
  };

  // ─── Animations ─────────────────────────────────────────────────────────
  late AnimationController _particleController;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  final List<_SettingsParticle> _particles = [];
  final Random _random = Random();

  static const double _timerSize = 240.0;

  int get _maxImposters => max(1, widget.playerNames.length ~/ 3);

  @override
  void initState() {
    super.initState();

    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -5.0, end: 5.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _initParticles();
    _particleController.addListener(() {
      _updateParticles();
    });
  }

  void _initParticles() {
    final colors = [
      const Color(0xFF9C1B30), // Blood Red
      const Color(0xFF2563EB), // Calm Royal Blue
      const Color(0xFF3B82F6), // Calm Sky Blue
      const Color(0xFF36F1CD),
    ];
    for (int i = 0; i < 30; i++) {
      _particles.add(_SettingsParticle(
        x: _random.nextDouble() * 1000,
        y: _random.nextDouble() * 2500,
        speedX: (_random.nextDouble() - 0.5) * 0.5,
        speedY: (_random.nextDouble() - 0.5) * 0.3,
        radius: _random.nextDouble() * 2.5 + 0.5,
        color: colors[_random.nextInt(colors.length)],
        opacity: _random.nextDouble() * 0.25 + 0.05,
      ));
    }
  }

  void _updateParticles() {
    for (var p in _particles) {
      p.x += p.speedX;
      p.y += p.speedY;
      if (p.x < 0) p.x = 1000;
      if (p.x > 1000) p.x = 0;
      if (p.y < 0) p.y = 2500;
      if (p.y > 2500) p.y = 0;
    }
  }

  @override
  void dispose() {
    _particleController.dispose();
    _pulseController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  // ─── Spook Helpers ──────────────────────────────────────────────────────

  double get _spookLevel => ((_timerMinutes - 1) / 14).clamp(0.0, 1.0);

  Color _getSpookColor(double level) {
    if (level < 0.3) {
      return Color.lerp(
        const Color(0xFF00D9FF),
        const Color(0xFF7B61FF),
        level / 0.3,
      )!;
    } else if (level < 0.6) {
      return Color.lerp(
        const Color(0xFF7B61FF),
        const Color(0xFFFF6B35),
        (level - 0.3) / 0.3,
      )!;
    } else {
      return Color.lerp(
        const Color(0xFFFF6B35),
        const Color(0xFF9C1B30),
        (level - 0.6) / 0.4,
      )!;
    }
  }

  String _getMoodLabel(double level) {
    if (level < 0.2) return '❄️ Chill';
    if (level < 0.45) return '🌙 Eerie';
    if (level < 0.7) return '🔥 Intense';
    return '💀 Nightmare';
  }

  String _getMoodEmoji(double level) {
    if (level < 0.2) return '❄️';
    if (level < 0.45) return '🌙';
    if (level < 0.7) return '🔥';
    return '💀';
  }

  String _formatTime(double minutes) {
    int m = minutes.floor();
    int s = ((minutes - m) * 60).round();
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  // ─── Timer Drag ─────────────────────────────────────────────────────────

  void _handleTimerDrag(Offset localPosition, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final dx = localPosition.dx - center.dx;
    final dy = localPosition.dy - center.dy;

    // Angle from top (12 o'clock), clockwise
    double angle = atan2(dx, -dy);
    if (angle < 0) angle += 2 * pi;

    // Map angle to time (1 to 15 minutes)
    double time = 1.0 + (angle / (2 * pi)) * 14.0;

    // Round to nearest 30 seconds
    time = (time * 2).round() / 2.0;
    time = time.clamp(1.0, 15.0);

    setState(() {
      _timerMinutes = time;
    });
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
              animation: _particleController,
              builder: (context, _) {
                return CustomPaint(
                  painter: _SettingsParticlePainter(particles: _particles),
                );
              },
            ),
          ),

          // Background orbs
          ..._buildBackgroundOrbs(),

          // Content
          SafeArea(
            child: Column(
              children: [
                _buildTopBar(context),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        _buildImposterCard(),
                        const SizedBox(height: 16),
                        _buildHintCard(),
                        const SizedBox(height: 16),
                        _buildCategoryCard(context),
                        const SizedBox(height: 28),
                        _buildTimerSection(),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
                _buildBeginButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Top Bar ────────────────────────────────────────────────────────────

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          _buildGlassIconButton(
            icon: Icons.arrow_back_rounded,
            onTap: () => Navigator.of(context).pop(),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: AnimatedBuilder(
              animation: _floatAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _floatAnimation.value * 0.3),
                  child: child,
                );
              },
              child: const Text(
                'GAME SETTINGS',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFFFD700),
                  letterSpacing: 4,
                  shadows: [
                    Shadow(offset: Offset(0, 2), blurRadius: 8, color: Color(0xFFFF8C00)),
                    Shadow(offset: Offset(0, 4), blurRadius: 14, color: Colors.black54),
                  ],
                ),
              ),
            ),
          ),
          // Player count badge
          _buildGlassBadge(
            icon: Icons.groups_rounded,
            label: '${widget.playerNames.length}',
          ),
        ],
      ),
    );
  }

  // ─── Imposter Counter Card ──────────────────────────────────────────────

  Widget _buildImposterCard() {
    return _buildGlassCard(
      child: Row(
        children: [
          // Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: const LinearGradient(
                colors: [Color(0xFFFF3D71), Color(0xFFFF6B35)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Text('😈', style: TextStyle(fontSize: 22)),
            ),
          ),
          const SizedBox(width: 16),

          // Label
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Imposters',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Max $_maxImposters for ${widget.playerNames.length} players',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.4),
                  ),
                ),
              ],
            ),
          ),

          // Counter
          _buildCounter(
            value: _imposterCount,
            min: 1,
            max: _maxImposters,
            accentColor: const Color(0xFFFF3D71),
            onChanged: (v) => setState(() => _imposterCount = v),
          ),
        ],
      ),
    );
  }

  // ─── Hint Counter Card ──────────────────────────────────────────────────

  Widget _buildHintCard() {
    return _buildGlassCard(
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: const LinearGradient(
                colors: [Color(0xFF7B61FF), Color(0xFF00D9FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Text('🔍', style: TextStyle(fontSize: 22)),
            ),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hints for Imposters',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _hintCount == 1
                      ? 'One vague clue'
                      : '$_hintCount clues to help blend in',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.4),
                  ),
                ),
              ],
            ),
          ),

          _buildCounter(
            value: _hintCount,
            min: 1,
            max: 3,
            accentColor: const Color(0xFF7B61FF),
            onChanged: (v) => setState(() => _hintCount = v),
          ),
        ],
      ),
    );
  }

  // ─── Category Selector Card ─────────────────────────────────────────────

  Widget _buildCategoryCard(BuildContext context) {
    return GestureDetector(
      onTap: () => _showCategorySheet(context),
      child: _buildGlassCard(
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: const LinearGradient(
                  colors: [Color(0xFF36F1CD), Color(0xFF00D9FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Text(
                  _categoryEmojis[_selectedCategory] ?? '🎲',
                  style: const TextStyle(fontSize: 22),
                ),
              ),
            ),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _selectedCategory,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF36F1CD),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.expand_more_rounded,
              color: Colors.white.withValues(alpha: 0.4),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  void _showCategorySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.6,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFF141428),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(top: 12, bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.white.withValues(alpha: 0.15),
                ),
              ),
              // Title
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  'SELECT CATEGORY',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white.withValues(alpha: 0.5),
                    letterSpacing: 3,
                  ),
                ),
              ),
              // Category list
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final cat = _categories[index];
                    final isSelected = cat == _selectedCategory;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() => _selectedCategory = cat);
                            Navigator.pop(ctx);
                          },
                          borderRadius: BorderRadius.circular(14),
                          splashColor:
                              const Color(0xFF36F1CD).withValues(alpha: 0.1),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: isSelected
                                  ? const Color(0xFF36F1CD)
                                      .withValues(alpha: 0.1)
                                  : Colors.white.withValues(alpha: 0.03),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF36F1CD)
                                        .withValues(alpha: 0.3)
                                    : Colors.white.withValues(alpha: 0.06),
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  _categoryEmojis[cat] ?? '🎲',
                                  style: const TextStyle(fontSize: 20),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Text(
                                    cat,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                      color: isSelected
                                          ? const Color(0xFF36F1CD)
                                          : Colors.white
                                              .withValues(alpha: 0.7),
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  const Icon(
                                    Icons.check_circle_rounded,
                                    color: Color(0xFF36F1CD),
                                    size: 20,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ─── Timer Section ──────────────────────────────────────────────────────

  Widget _buildTimerSection() {
    final spook = _spookLevel;
    final moodColor = _getSpookColor(spook);

    return Column(
      children: [
        // Section heading
        Text(
          'ROUND TIMER',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: const Color(0xFFF8FAFC),
            letterSpacing: 4,
            shadows: [
              Shadow(offset: const Offset(0, 2), blurRadius: 12, color: moodColor),
              const Shadow(offset: Offset(0, 4), blurRadius: 16, color: Colors.black54),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Drag around the circle to set time',
          style: TextStyle(
            fontSize: 13,
            fontStyle: FontStyle.italic,
            color: Colors.white.withValues(alpha: 0.5),
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 28),

        // The circular timer
        Center(
          child: SizedBox(
            width: _timerSize,
            height: _timerSize,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final size = constraints.biggest;
                return GestureDetector(
                  onPanStart: (d) => _handleTimerDrag(d.localPosition, size),
                  onPanUpdate: (d) => _handleTimerDrag(d.localPosition, size),
                  onTapDown: (d) => _handleTimerDrag(d.localPosition, size),
                  child: AnimatedBuilder(
                    animation: _pulseAnimation,
                    builder: (context, _) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          // Outer atmospheric glow
                          Container(
                            width: _timerSize,
                            height: _timerSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: moodColor.withValues(
                                    alpha: 0.1 +
                                        _pulseAnimation.value * 0.08 * spook,
                                  ),
                                  blurRadius: 40 + spook * 30,
                                  spreadRadius: 10 + spook * 15,
                                ),
                              ],
                            ),
                          ),

                          // Timer painter
                          CustomPaint(
                            size: Size(_timerSize, _timerSize),
                            painter: _TimerPainter(
                              timeMinutes: _timerMinutes,
                              maxMinutes: 15.0,
                              pulseValue: _pulseAnimation.value,
                              spookLevel: spook,
                            ),
                          ),

                          // Center content
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Mood emoji
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 400),
                                child: Text(
                                  _getMoodEmoji(spook),
                                  key: ValueKey(_getMoodEmoji(spook)),
                                  style: const TextStyle(fontSize: 28),
                                ),
                              ),
                              const SizedBox(height: 4),
                              // Time value
                              Text(
                                _formatTime(_timerMinutes),
                                style: TextStyle(
                                  fontSize: 38,
                                  fontWeight: FontWeight.w900,
                                  color: Color.lerp(
                                    Colors.white,
                                    moodColor,
                                    spook * 0.6,
                                  ),
                                  letterSpacing: 2,
                                ),
                              ),
                              const SizedBox(height: 2),
                              // Mood label
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 400),
                                child: Text(
                                  _getMoodLabel(spook),
                                  key: ValueKey(_getMoodLabel(spook)),
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: moodColor.withValues(alpha: 0.8),
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Quick presets
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTimePreset(2, '2m'),
            const SizedBox(width: 10),
            _buildTimePreset(5, '5m'),
            const SizedBox(width: 10),
            _buildTimePreset(10, '10m'),
            const SizedBox(width: 10),
            _buildTimePreset(15, '15m'),
          ],
        ),
      ],
    );
  }

  Widget _buildTimePreset(double minutes, String label) {
    final isSelected = (_timerMinutes - minutes).abs() < 0.1;
    final spook = ((minutes - 1) / 14).clamp(0.0, 1.0);
    final color = _getSpookColor(spook);

    return GestureDetector(
      onTap: () => setState(() => _timerMinutes = minutes),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? color.withValues(alpha: 0.15) : Colors.white.withValues(alpha: 0.04),
          border: Border.all(
            color: isSelected ? color.withValues(alpha: 0.4) : Colors.white.withValues(alpha: 0.08),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: isSelected ? color : Colors.white.withValues(alpha: 0.4),
          ),
        ),
      ),
    );
  }

  // ─── Begin Game Button ──────────────────────────────────────────────────

  Widget _buildBeginButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              final progress = _pulseAnimation.value;

              // Transition background: Calm Royal Blue (0xFF1D4ED8) -> Dark Blood Red Devil (0xFF881337)
              final bgColor = Color.lerp(
                const Color(0xFF1D4ED8),
                const Color(0xFF881337),
                progress,
              )!;

              // Border glow: Calm Sky Blue -> Burning Crimson Red
              final glowColor = Color.lerp(
                const Color(0xFF3B82F6),
                const Color(0xFFFF3D71),
                progress,
              )!;

              return Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: bgColor,
                  border: Border.all(
                    color: glowColor.withValues(alpha: 0.6),
                    width: 1.5,
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  GamePlayPage(
                                    playerNames: widget.playerNames,
                                    imposterCount: _imposterCount,
                                    hintCount: _hintCount,
                                    category: _selectedCategory,
                                    timerMinutes: _timerMinutes,
                                  ),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 600),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(18),
                    splashColor: Colors.white.withValues(alpha: 0.1),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            progress > 0.5 ? '😈' : '😇',
                            style: const TextStyle(fontSize: 22),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'BEGIN GAME',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 3,
                              shadows: [
                                Shadow(
                                  offset: const Offset(0, 2),
                                  blurRadius: 4,
                                  color: Colors.black.withValues(alpha: 0.8),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 14),
          Text(
            '${widget.playerNames.length} players · $_imposterCount imposter${_imposterCount > 1 ? "s" : ""} · ${_formatTime(_timerMinutes)}',
            style: TextStyle(
              fontSize: 11,
              color: Colors.white.withValues(alpha: 0.25),
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Reusable Components ────────────────────────────────────────────────

  Widget _buildGlassCard({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white.withValues(alpha: 0.05),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildCounter({
    required int value,
    required int min,
    required int max,
    required Color accentColor,
    required ValueChanged<int> onChanged,
  }) {
    final canDecrease = value > min;
    final canIncrease = value < max;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Minus
        _buildCounterButton(
          icon: Icons.remove_rounded,
          enabled: canDecrease,
          accentColor: accentColor,
          onTap: canDecrease ? () => onChanged(value - 1) : null,
        ),
        // Value
        Container(
          width: 44,
          alignment: Alignment.center,
          child: Text(
            '$value',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: accentColor,
            ),
          ),
        ),
        // Plus
        _buildCounterButton(
          icon: Icons.add_rounded,
          enabled: canIncrease,
          accentColor: accentColor,
          onTap: canIncrease ? () => onChanged(value + 1) : null,
        ),
      ],
    );
  }

  Widget _buildCounterButton({
    required IconData icon,
    required bool enabled,
    required Color accentColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: enabled
              ? accentColor.withValues(alpha: 0.12)
              : Colors.white.withValues(alpha: 0.03),
          border: Border.all(
            color: enabled
                ? accentColor.withValues(alpha: 0.25)
                : Colors.white.withValues(alpha: 0.06),
          ),
        ),
        child: Icon(
          icon,
          size: 18,
          color: enabled
              ? accentColor
              : Colors.white.withValues(alpha: 0.15),
        ),
      ),
    );
  }

  Widget _buildGlassIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white.withValues(alpha: 0.06),
            border:
                Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(12),
              splashColor: Colors.white.withValues(alpha: 0.1),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Icon(icon, color: Colors.white70, size: 22),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassBadge({required IconData icon, required String label}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white.withValues(alpha: 0.06),
            border:
                Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: const Color(0xFF2563EB), size: 18),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBackgroundOrbs() {
    final spook = _spookLevel;
    final orbColor1 = Color.lerp(
      const Color(0xFF2563EB).withValues(alpha: 0.14), // Calm Royal Blue
      const Color(0xFF9C1B30).withValues(alpha: 0.16), // Blood Red
      spook,
    )!;
    final orbColor2 = Color.lerp(
      const Color(0xFF3B82F6).withValues(alpha: 0.10), // Calm Sky Blue
      const Color(0xFF881337).withValues(alpha: 0.14), // Deep Crimson
      spook,
    )!;

    return [
      Positioned(
        top: -80,
        right: -60,
        child: Container(
          width: 280,
          height: 280,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(colors: [orbColor1, Colors.transparent]),
          ),
        ),
      ),
      Positioned(
        bottom: 100,
        left: -100,
        child: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(colors: [orbColor2, Colors.transparent]),
          ),
        ),
      ),
    ];
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// TIMER PAINTER
// ═════════════════════════════════════════════════════════════════════════════

class _TimerPainter extends CustomPainter {
  final double timeMinutes;
  final double maxMinutes;
  final double pulseValue;
  final double spookLevel;

  _TimerPainter({
    required this.timeMinutes,
    required this.maxMinutes,
    required this.pulseValue,
    required this.spookLevel,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 24;

    final sweepFraction = ((timeMinutes - 1) / (maxMinutes - 1)).clamp(0.0, 1.0);
    final sweepAngle = sweepFraction * 2 * pi;
    const startAngle = -pi / 2; // 12 o'clock

    final arcColor = _colorForSpook(spookLevel);
    final glowIntensity = 0.15 + spookLevel * 0.3 + pulseValue * 0.1 * spookLevel;

    // ── 1. Inner ambient glow ──
    final innerGlowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          arcColor.withValues(alpha: 0.04 + spookLevel * 0.06),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius * 0.75));
    canvas.drawCircle(center, radius * 0.75, innerGlowPaint);

    // ── 2. Background track ──
    final trackPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, trackPaint);

    // ── 3. Tick marks ──
    for (int i = 0; i <= 14; i++) {
      final tickAngle = startAngle + (i / 14) * 2 * pi;
      final isMajor = i % 5 == 0;
      final tickOuterR = radius + (isMajor ? 10 : 6);
      final tickInnerR = radius + 2;

      // Flicker effect for high spook
      double tickOpacity = isMajor ? 0.25 : 0.12;
      if (spookLevel > 0.6) {
        final flicker = sin(pulseValue * pi * 3 + i * 1.7);
        tickOpacity *= (0.5 + flicker * 0.5).clamp(0.2, 1.0);
      }

      final x1 = center.dx + cos(tickAngle) * tickInnerR;
      final y1 = center.dy + sin(tickAngle) * tickInnerR;
      final x2 = center.dx + cos(tickAngle) * tickOuterR;
      final y2 = center.dy + sin(tickAngle) * tickOuterR;

      final tickPaint = Paint()
        ..color = Color.lerp(
          Colors.white.withValues(alpha: tickOpacity),
          arcColor.withValues(alpha: tickOpacity * 1.5),
          spookLevel,
        )!
        ..strokeWidth = isMajor ? 2.0 : 1.0
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), tickPaint);
    }

    // ── 4. Arc glow (behind) ──
    if (sweepAngle > 0.01) {
      final arcGlowPaint = Paint()
        ..color = arcColor.withValues(alpha: glowIntensity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 18
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        arcGlowPaint,
      );
    }

    // ── 5. Main progress arc ──
    if (sweepAngle > 0.01) {
      final arcPaint = Paint()
        ..color = arcColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 7
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        arcPaint,
      );
    }

    // ── 6. Handle knob ──
    final handleAngle = startAngle + sweepAngle;
    final handleX = center.dx + cos(handleAngle) * radius;
    final handleY = center.dy + sin(handleAngle) * radius;

    // Knob glow
    final knobGlowPaint = Paint()
      ..color = arcColor.withValues(alpha: 0.35 + pulseValue * 0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
    canvas.drawCircle(Offset(handleX, handleY), 14, knobGlowPaint);

    // Knob fill
    canvas.drawCircle(
      Offset(handleX, handleY),
      9,
      Paint()..color = arcColor,
    );

    // Knob inner highlight
    canvas.drawCircle(
      Offset(handleX, handleY),
      4,
      Paint()..color = Colors.white.withValues(alpha: 0.6),
    );

    // Knob border
    canvas.drawCircle(
      Offset(handleX, handleY),
      9,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.25)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );

    // ── 7. Spooky particle decorations on high spook ──
    if (spookLevel > 0.5) {
      final emberCount = (spookLevel * 8).round();
      final rng = Random(42); // deterministic for stability
      for (int i = 0; i < emberCount; i++) {
        final angle = rng.nextDouble() * 2 * pi;
        final dist = radius * (0.85 + rng.nextDouble() * 0.3);
        final phase = sin(pulseValue * pi * 2 + i * 1.3);
        final ex = center.dx + cos(angle) * dist + phase * 3;
        final ey = center.dy + sin(angle) * dist - phase * 4;
        final eSize = 1.0 + rng.nextDouble() * 2 * spookLevel;
        final eOpacity =
            (0.2 + phase * 0.3).clamp(0.0, 0.5) * (spookLevel - 0.5) * 2;

        canvas.drawCircle(
          Offset(ex, ey),
          eSize,
          Paint()..color = arcColor.withValues(alpha: eOpacity),
        );
      }
    }
  }

  Color _colorForSpook(double level) {
    if (level < 0.3) {
      return Color.lerp(
          const Color(0xFF00D9FF), const Color(0xFF7B61FF), level / 0.3)!;
    } else if (level < 0.6) {
      return Color.lerp(const Color(0xFF7B61FF), const Color(0xFFFF6B35),
          (level - 0.3) / 0.3)!;
    } else {
      return Color.lerp(const Color(0xFFFF6B35), const Color(0xFF9C1B30),
          (level - 0.6) / 0.4)!;
    }
  }

  @override
  bool shouldRepaint(covariant _TimerPainter oldDelegate) {
    return oldDelegate.timeMinutes != timeMinutes ||
        oldDelegate.pulseValue != pulseValue ||
        oldDelegate.spookLevel != spookLevel;
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// PARTICLE SYSTEM
// ═════════════════════════════════════════════════════════════════════════════

class _SettingsParticle {
  double x, y, speedX, speedY, radius, opacity;
  Color color;

  _SettingsParticle({
    required this.x,
    required this.y,
    required this.speedX,
    required this.speedY,
    required this.radius,
    required this.color,
    required this.opacity,
  });
}

class _SettingsParticlePainter extends CustomPainter {
  final List<_SettingsParticle> particles;

  _SettingsParticlePainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    for (var p in particles) {
      final x = (p.x / 1000) * size.width;
      final y = (p.y / 2500) * size.height;
      canvas.drawCircle(
        Offset(x, y),
        p.radius,
        Paint()..color = p.color.withValues(alpha: p.opacity),
      );
      if (p.radius > 1.8) {
        canvas.drawCircle(
          Offset(x, y),
          p.radius * 2,
          Paint()
            ..color = p.color.withValues(alpha: p.opacity * 0.2)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
