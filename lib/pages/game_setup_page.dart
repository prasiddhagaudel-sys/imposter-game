import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';
import 'game_settings_page.dart';

class GameSetupPage extends StatefulWidget {
  const GameSetupPage({super.key});

  @override
  State<GameSetupPage> createState() => _GameSetupPageState();
}

class _GameSetupPageState extends State<GameSetupPage>
    with TickerProviderStateMixin {
  late AnimationController _particleController;
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  final List<_SetupParticle> _particles = [];
  final Random _random = Random();
  final ScrollController _scrollController = ScrollController();

  // Player management
  final List<_PlayerEntry> _players = [];
  final int _minPlayers = 3;
  final int _maxPlayers = 10;

  // Next button hover state
  bool _isNextHovered = false;
  late AnimationController _morphController;
  late Animation<double> _morphAnimation;
  late AnimationController _haloController;
  late Animation<double> _haloAnimation;

  @override
  void initState() {
    super.initState();

    // Start with 3 default players
    for (int i = 0; i < 3; i++) {
      _players.add(_PlayerEntry(
        controller: TextEditingController(),
        focusNode: FocusNode(),
        index: i,
      ));
    }

    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -6.0, end: 6.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    // Morph controller for angel → devil transition
    _morphController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _morphAnimation = CurvedAnimation(
      parent: _morphController,
      curve: Curves.easeInOut,
    );

    // Halo / flame pulse animation
    _haloController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _haloAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _haloController, curve: Curves.easeInOut),
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

    for (int i = 0; i < 35; i++) {
      _particles.add(_SetupParticle(
        x: _random.nextDouble() * 1000,
        y: _random.nextDouble() * 2000,
        speedX: (_random.nextDouble() - 0.5) * 0.6,
        speedY: (_random.nextDouble() - 0.5) * 0.4,
        radius: _random.nextDouble() * 2.5 + 0.5,
        color: colors[_random.nextInt(colors.length)],
        opacity: _random.nextDouble() * 0.3 + 0.05,
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

  void _addPlayer() {
    if (_players.length >= _maxPlayers) return;
    setState(() {
      _players.add(_PlayerEntry(
        controller: TextEditingController(),
        focusNode: FocusNode(),
        index: _players.length,
      ));
    });
  }

  void _removePlayer(int index) {
    if (_players.length <= _minPlayers) return;
    setState(() {
      _players[index].controller.dispose();
      _players[index].focusNode.dispose();
      _players.removeAt(index);
      // Re-index
      for (int i = 0; i < _players.length; i++) {
        _players[i].index = i;
      }
    });
  }

  void _onNextHover(bool hovering) {
    setState(() {
      _isNextHovered = hovering;
    });
    if (hovering) {
      _morphController.forward();
    } else {
      _morphController.reverse();
    }
  }

  @override
  void dispose() {
    _particleController.dispose();
    _floatController.dispose();
    _morphController.dispose();
    _haloController.dispose();
    _scrollController.dispose();
    for (var p in _players) {
      p.controller.dispose();
      p.focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A1A),
      body: Stack(
        children: [
          // Particle background
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _particleController,
              builder: (context, _) {
                return CustomPaint(
                  painter: _SetupParticlePainter(particles: _particles),
                );
              },
            ),
          ),

          // Background orbs
          ..._buildBackgroundOrbs(),

          // Main content
          SafeArea(
            child: Column(
              children: [
                // Top bar
                _buildTopBar(context),

                // Scrollable player list
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        _buildPlayerCountHeader(),
                        const SizedBox(height: 28),
                        _buildPlayerList(),
                        const SizedBox(height: 20),
                        _buildAddPlayerButton(),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),

                // Bottom section with the Next button
                _buildBottomSection(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Top Bar ──────────────────────────────────────────────────────────────

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Back button
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white.withValues(alpha: 0.06),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    borderRadius: BorderRadius.circular(12),
                    splashColor: Colors.white.withValues(alpha: 0.1),
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white70,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Title
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
                'GAME SETUP',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFF1F5F9),
                  letterSpacing: 4,
                  shadows: [
                    Shadow(offset: Offset(0, 2), blurRadius: 12, color: Color(0xFF2563EB)),
                    Shadow(offset: Offset(0, 4), blurRadius: 16, color: Colors.black54),
                  ],
                ),
              ),
            ),
          ),

          // Player count badge
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white.withValues(alpha: 0.06),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.groups_rounded,
                      color: Color(0xFF7B61FF),
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${_players.length}',
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
          ),
        ],
      ),
    );
  }

  // ─── Player Count Header ──────────────────────────────────────────────────

  Widget _buildPlayerCountHeader() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withValues(alpha: 0.05),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),
          child: Column(
            children: [
              const Text(
                '👥',
                style: TextStyle(fontSize: 32),
              ),
              const SizedBox(height: 12),
              const Text(
                'PLAYERS',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Add $_minPlayers-$_maxPlayers players and set their nicknames',
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: 20),

              // Player count indicator dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_maxPlayers, (i) {
                  final isActive = i < _players.length;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    width: isActive ? 28 : 10,
                    height: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: isActive
                          ? const LinearGradient(
                              colors: [
                                Color(0xFFFF3D71),
                                Color(0xFF7B61FF),
                              ],
                            )
                          : null,
                      color: isActive
                          ? null
                          : Colors.white.withValues(alpha: 0.1),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Player List ──────────────────────────────────────────────────────────

  Widget _buildPlayerList() {
    return Column(
      children: List.generate(_players.length, (index) {
        return _buildPlayerCard(index);
      }),
    );
  }

  Widget _buildPlayerCard(int index) {
    final player = _players[index];
    final canRemove = _players.length > _minPlayers;

    // Cycle through accent colors per player
    final accentColors = [
      const Color(0xFFFF3D71),
      const Color(0xFF7B61FF),
      const Color(0xFF00D9FF),
      const Color(0xFF36F1CD),
      const Color(0xFFFF6B35),
      const Color(0xFFFFD93D),
      const Color(0xFFFF85A1),
      const Color(0xFF6FFFE9),
      const Color(0xFFA78BFA),
      const Color(0xFFFB923C),
    ];
    final accent = accentColors[index % accentColors.length];

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white.withValues(alpha: 0.04),
              border: Border.all(
                color: accent.withValues(alpha: 0.15),
              ),
            ),
            child: Row(
              children: [
                // Player avatar
                Container(
                  width: 48,
                  height: 48,
                  margin: const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [
                        accent.withValues(alpha: 0.3),
                        accent.withValues(alpha: 0.1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                      color: accent.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: accent,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Nickname input
                Expanded(
                  child: TextField(
                    controller: player.controller,
                    focusNode: player.focusNode,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Player ${index + 1}',
                      hintStyle: TextStyle(
                        color: Colors.white.withValues(alpha: 0.25),
                        fontWeight: FontWeight.w400,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 14,
                      ),
                    ),
                    cursorColor: accent,
                  ),
                ),

                // Remove button
                if (canRemove)
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _removePlayer(index),
                      borderRadius: BorderRadius.circular(10),
                      splashColor: const Color(0xFFFF3D71).withValues(alpha: 0.2),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          Icons.close_rounded,
                          size: 18,
                          color: Colors.white.withValues(alpha: 0.3),
                        ),
                      ),
                    ),
                  ),

                if (!canRemove) const SizedBox(width: 38),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─── Add Player Button ────────────────────────────────────────────────────

  Widget _buildAddPlayerButton() {
    final canAdd = _players.length < _maxPlayers;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: canAdd ? 1.0 : 0.3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: canAdd ? _addPlayer : null,
              borderRadius: BorderRadius.circular(16),
              splashColor: const Color(0xFF7B61FF).withValues(alpha: 0.15),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF7B61FF).withValues(alpha: 0.2),
                    width: 1.5,
                  ),
                  color: const Color(0xFF7B61FF).withValues(alpha: 0.05),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_add_rounded,
                      size: 20,
                      color: const Color(0xFF7B61FF).withValues(alpha: 0.7),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      canAdd
                          ? 'ADD PLAYER'
                          : 'MAX PLAYERS REACHED',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF7B61FF).withValues(alpha: 0.7),
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

  // ─── Bottom Section (Angel ↔ Devil Next Button) ───────────────────────────

  Widget _buildBottomSection(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_morphAnimation, _haloAnimation]),
      builder: (context, _) {
        final morphValue = _morphAnimation.value;
        final haloValue = _haloAnimation.value;

        // Interpolate colors from angel to devil
        final buttonColor1 = Color.lerp(
          const Color(0xFFE8F0FE), // Angelic soft blue-white
          const Color(0xFFFF3D71), // Devilish red
          morphValue,
        )!;
        final buttonColor2 = Color.lerp(
          const Color(0xFFBBDEFB), // Angelic sky blue
          const Color(0xFF9C1B30), // Deep blood red
          morphValue,
        )!;
        final textColor = Color.lerp(
          const Color(0xFF1A237E), // Deep serene blue
          Colors.white, // White on dark devil
          morphValue,
        )!;
        final iconColor = Color.lerp(
          const Color(0xFFFFD700), // Golden
          const Color(0xFFFF3D71), // Red
          morphValue,
        )!;

        // Halo / flame ring size
        final ringScale = 1.0 + haloValue * 0.08;
        final ringOpacity = (0.3 + haloValue * 0.25).clamp(0.0, 1.0);

        return Container(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Divider
              Container(
                width: 60,
                height: 2,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1),
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.white.withValues(alpha: 0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              // The morphing button
              MouseRegion(
                onEnter: (_) => _onNextHover(true),
                onExit: (_) => _onNextHover(false),
                child: GestureDetector(
                  onTap: () {
                    final playerNames = _players.map((p) {
                      final name = p.controller.text.trim();
                      return name.isEmpty ? 'Player ${p.index + 1}' : name;
                    }).toList();

                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder:
                            (context, animation, secondaryAnimation) =>
                                GameSettingsPage(playerNames: playerNames),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0, 0.05),
                                end: Offset.zero,
                              ).animate(CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeOut,
                              )),
                              child: child,
                            ),
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 500),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Outer halo / flame ring
                        Transform.scale(
                          scale: ringScale,
                          child: Container(
                            width: double.infinity,
                            height: 62,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),

                        // Angel wings / devil horns decorations (small accent marks)
                        Positioned(
                          top: morphValue < 0.5 ? -4 : -2,
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 200),
                            opacity: ringOpacity * 0.7,
                            child: Text(
                              morphValue < 0.5 ? '👼' : '🔥',
                              style: TextStyle(
                                fontSize: 16 + morphValue * 4,
                              ),
                            ),
                          ),
                        ),

                        // Main button body
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              width: double.infinity,
                              height: 58,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                gradient: LinearGradient(
                                  colors: [buttonColor1, buttonColor2],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                border: Border.all(
                                  color: Color.lerp(
                                    const Color(0xFFFFD700).withValues(alpha: 0.3),
                                    const Color(0xFFFF3D71).withValues(alpha: 0.4),
                                    morphValue,
                                  )!,
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Morphing icon
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    layoutBuilder: (currentChild, previousChildren) {
                                      return Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          ...previousChildren,
                                          ?currentChild,
                                        ],
                                      );
                                    },
                                    transitionBuilder: (child, animation) {
                                      return ScaleTransition(
                                        scale: animation,
                                        child: child,
                                      );
                                    },
                                    child: Icon(
                                      _isNextHovered
                                          ? Icons.local_fire_department_rounded
                                          : Icons.auto_awesome_rounded,
                                      key: ValueKey('icon_${_isNextHovered}_$morphValue'),
                                      size: 22,
                                      color: iconColor,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    _isNextHovered
                                        ? 'LET THE CHAOS BEGIN'
                                        : 'NEXT',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: textColor,
                                      letterSpacing: 3,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    layoutBuilder: (currentChild, previousChildren) {
                                      return Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          ...previousChildren,
                                          ?currentChild,
                                        ],
                                      );
                                    },
                                    transitionBuilder: (child, animation) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                    child: Text(
                                      _isNextHovered ? '😈' : '😇',
                                      key: ValueKey('emoji_${_isNextHovered}_$morphValue'),
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Subtitle hint
              Text(
                _isNextHovered
                    ? 'Deception awaits...'
                    : '${_players.length} players ready',
                style: TextStyle(
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  color: Color.lerp(
                    Colors.white.withValues(alpha: 0.4),
                    const Color(0xFFFF3D71).withValues(alpha: 0.8),
                    morphValue,
                  ),
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ─── Background Orbs ──────────────────────────────────────────────────────

  List<Widget> _buildBackgroundOrbs() {
    return [
      Positioned(
        top: -80,
        right: -60,
        child: Container(
          width: 280,
          height: 280,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                const Color(0xFF7B61FF).withValues(alpha: 0.12),
                Colors.transparent,
              ],
            ),
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
            gradient: RadialGradient(
              colors: [
                const Color(0xFFFF3D71).withValues(alpha: 0.08),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    ];
  }
}

// ─── Particle System ────────────────────────────────────────────────────────

class _SetupParticle {
  double x, y, speedX, speedY, radius, opacity;
  Color color;

  _SetupParticle({
    required this.x,
    required this.y,
    required this.speedX,
    required this.speedY,
    required this.radius,
    required this.color,
    required this.opacity,
  });
}

class _SetupParticlePainter extends CustomPainter {
  final List<_SetupParticle> particles;

  _SetupParticlePainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    for (var p in particles) {
      final x = (p.x / 1000) * size.width;
      final y = (p.y / 2000) * size.height;

      final paint = Paint()
        ..color = p.color.withValues(alpha: p.opacity)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), p.radius, paint);

      if (p.radius > 1.8) {
        final glowPaint = Paint()
          ..color = p.color.withValues(alpha: p.opacity * 0.25)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
        canvas.drawCircle(Offset(x, y), p.radius * 2, glowPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ─── Player Entry Model ─────────────────────────────────────────────────────

class _PlayerEntry {
  TextEditingController controller;
  FocusNode focusNode;
  int index;

  _PlayerEntry({
    required this.controller,
    required this.focusNode,
    required this.index,
  });
}
