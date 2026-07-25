import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'dart:ui';
import '../data/word_bank.dart';
import 'game_timer_page.dart';

// ═════════════════════════════════════════════════════════════════════════════
// GAME PHASE
// ═════════════════════════════════════════════════════════════════════════════

enum _GamePhase { loading, cardName, cardReveal, passing, complete }

// ═════════════════════════════════════════════════════════════════════════════
// CARD THEME DATA
// ═════════════════════════════════════════════════════════════════════════════

class _CardTheme {
  final String name;
  final Color color1;
  final Color color2;
  final Color accent;
  final Color textColor;
  final String emoji;
  final Color glowColor;

  const _CardTheme({
    required this.name,
    required this.color1,
    required this.color2,
    required this.accent,
    required this.textColor,
    required this.emoji,
    required this.glowColor,
  });
}

// 10 light themes for players
const _playerThemes = [
  _CardTheme(name: 'Aurora', color1: Color(0xFF00D9FF), color2: Color(0xFF36F1CD), accent: Color(0xFF00D9FF), textColor: Color(0xFF0A2540), emoji: '✨', glowColor: Color(0xFF00D9FF)),
  _CardTheme(name: 'Sunset', color1: Color(0xFFFFD93D), color2: Color(0xFFFF6B35), accent: Color(0xFFFF6B35), textColor: Color(0xFF3D1500), emoji: '🌅', glowColor: Color(0xFFFF6B35)),
  _CardTheme(name: 'Blossom', color1: Color(0xFFFF85A1), color2: Color(0xFFFFB5C2), accent: Color(0xFFFF85A1), textColor: Color(0xFF4A0020), emoji: '🌸', glowColor: Color(0xFFFF85A1)),
  _CardTheme(name: 'Ocean', color1: Color(0xFF0EA5E9), color2: Color(0xFF7DD3FC), accent: Color(0xFF0EA5E9), textColor: Color(0xFF0C2D48), emoji: '🌊', glowColor: Color(0xFF0EA5E9)),
  _CardTheme(name: 'Meadow', color1: Color(0xFF4ADE80), color2: Color(0xFF86EFAC), accent: Color(0xFF4ADE80), textColor: Color(0xFF0A3D1E), emoji: '🌿', glowColor: Color(0xFF4ADE80)),
  _CardTheme(name: 'Cobalt', color1: Color(0xFF2563EB), color2: Color(0xFF93C5FD), accent: Color(0xFF2563EB), textColor: Color(0xFF0F172A), emoji: '💙', glowColor: Color(0xFF2563EB)),
  _CardTheme(name: 'Peach', color1: Color(0xFFFB923C), color2: Color(0xFFFDBA74), accent: Color(0xFFFB923C), textColor: Color(0xFF3D1D00), emoji: '🍑', glowColor: Color(0xFFFB923C)),
  _CardTheme(name: 'Sky', color1: Color(0xFF38BDF8), color2: Color(0xFFBAE6FD), accent: Color(0xFF38BDF8), textColor: Color(0xFF0C3251), emoji: '☁️', glowColor: Color(0xFF38BDF8)),
  _CardTheme(name: 'Mint', color1: Color(0xFF2DD4BF), color2: Color(0xFF99F6E4), accent: Color(0xFF2DD4BF), textColor: Color(0xFF0A3D34), emoji: '🍃', glowColor: Color(0xFF2DD4BF)),
  _CardTheme(name: 'Honey', color1: Color(0xFFFBBF24), color2: Color(0xFFFDE68A), accent: Color(0xFFFBBF24), textColor: Color(0xFF3D2E00), emoji: '🍯', glowColor: Color(0xFFFBBF24)),
];

// 5 dark themes for imposters
const _imposterThemes = [
  _CardTheme(name: 'Blood Moon', color1: Color(0xFF9C1B30), color2: Color(0xFF4A0000), accent: Color(0xFFFF3D71), textColor: Color(0xFFFFE0E6), emoji: '🩸', glowColor: Color(0xFFFF3D71)),
  _CardTheme(name: 'Navy Shadow', color1: Color(0xFF1E3A8A), color2: Color(0xFF0F172A), accent: Color(0xFF60A5FA), textColor: Color(0xFFEFF6FF), emoji: '🌑', glowColor: Color(0xFF2563EB)),
  _CardTheme(name: 'Inferno', color1: Color(0xFF7C2D12), color2: Color(0xFF431407), accent: Color(0xFFF97316), textColor: Color(0xFFFFF7ED), emoji: '🔥', glowColor: Color(0xFFF97316)),
  _CardTheme(name: 'Abyss', color1: Color(0xFF1C1917), color2: Color(0xFF0C0A09), accent: Color(0xFF78716C), textColor: Color(0xFFF5F5F4), emoji: '🕳️', glowColor: Color(0xFF57534E)),
  _CardTheme(name: 'Crimson', color1: Color(0xFF881337), color2: Color(0xFF4C0519), accent: Color(0xFFFB7185), textColor: Color(0xFFFFE4E6), emoji: '💀', glowColor: Color(0xFFFB7185)),
];

// ═════════════════════════════════════════════════════════════════════════════
// GAME PLAY PAGE
// ═════════════════════════════════════════════════════════════════════════════

class GamePlayPage extends StatefulWidget {
  final List<String> playerNames;
  final int imposterCount;
  final int hintCount;
  final String category;
  final double timerMinutes;

  const GamePlayPage({
    super.key,
    required this.playerNames,
    required this.imposterCount,
    required this.hintCount,
    required this.category,
    required this.timerMinutes,
  });

  @override
  State<GamePlayPage> createState() => _GamePlayPageState();
}

class _GamePlayPageState extends State<GamePlayPage>
    with TickerProviderStateMixin {
  // ─── Game State ─────────────────────────────────────────────────────────
  _GamePhase _phase = _GamePhase.loading;
  int _currentPlayerIndex = 0;
  late List<bool> _isImposter; // true = imposter
  late String _word;
  late List<String> _hints;
  late List<_CardTheme> _assignedPlayerThemes;
  late List<_CardTheme> _assignedImposterThemes;
  late List<int> _imposterHintIndices; // which hint each imposter gets

  // ─── Animation Controllers ──────────────────────────────────────────────
  late AnimationController _loadingController;
  late AnimationController _cardAppearController;
  late AnimationController _revealController;
  late AnimationController _pulseController;
  late AnimationController _particleController;

  late Animation<double> _cardAppearAnimation;
  late Animation<double> _revealAnimation;
  late Animation<double> _pulseAnimation;

  Timer? _holdTimer;
  bool _isHolding = false;
  bool _isDiscussionHovered = false;

  final Random _random = Random();
  final List<_GameParticle> _particles = [];

  @override
  void initState() {
    super.initState();

    _setupGame();
    _initParticles();

    // Loading: 4 second transition
    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );

    // Card slide-in
    _cardAppearController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _cardAppearAnimation = CurvedAnimation(
      parent: _cardAppearController,
      curve: Curves.easeOutBack,
    );

    // Card reveal (flip/transform)
    _revealController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _revealAnimation = CurvedAnimation(
      parent: _revealController,
      curve: Curves.easeOutCubic,
    );

    // Glow pulse
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Particle animation
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    _particleController.addListener(_updateParticles);

    // Start loading sequence
    _loadingController.forward();
    _loadingController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _phase = _GamePhase.cardName);
        _cardAppearController.forward(from: 0);
      }
    });
  }

  // ─── Game Setup ─────────────────────────────────────────────────────────

  void _setupGame() {
    final playerCount = widget.playerNames.length;

    // 1. Assign roles
    _isImposter = List.filled(playerCount, false);
    final indices = List.generate(playerCount, (i) => i)..shuffle(_random);
    for (int i = 0; i < widget.imposterCount; i++) {
      _isImposter[indices[i]] = true;
    }

    // 2. Pick a word
    String category = widget.category;
    if (category == 'Random') {
      final cats = wordBank.keys.toList();
      category = cats[_random.nextInt(cats.length)];
    }
    final words = wordBank[category] ?? wordBank.values.first;
    final entry = words[_random.nextInt(words.length)];
    _word = entry.word;
    _hints = entry.hints;

    // 3. Assign card themes
    final pThemes = List<_CardTheme>.from(_playerThemes)..shuffle(_random);
    _assignedPlayerThemes = pThemes;

    final iThemes = List<_CardTheme>.from(_imposterThemes)..shuffle(_random);
    _assignedImposterThemes = iThemes;

    // 4. Distribute hints among imposters
    _imposterHintIndices = [];
    int hintIdx = 0;
    for (int i = 0; i < playerCount; i++) {
      if (_isImposter[i]) {
        _imposterHintIndices.add(hintIdx % _hints.length);
        hintIdx++;
        if (hintIdx >= widget.hintCount) hintIdx = 0;
      }
    }
  }

  // ─── Particles ──────────────────────────────────────────────────────────

  void _initParticles() {
    for (int i = 0; i < 40; i++) {
      _particles.add(_GameParticle(
        x: _random.nextDouble() * 1000,
        y: _random.nextDouble() * 2000,
        speedX: (_random.nextDouble() - 0.5) * 0.6,
        speedY: (_random.nextDouble() - 0.5) * 0.4,
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

  // ─── Interaction ────────────────────────────────────────────────────────

  void _onPointerDown(PointerDownEvent event) {
    if (_phase != _GamePhase.cardName) return;
    _isHolding = true;
    _holdTimer?.cancel();
    _holdTimer = Timer(const Duration(milliseconds: 700), () {
      if (_isHolding && _phase == _GamePhase.cardName) {
        setState(() => _phase = _GamePhase.cardReveal);
        _revealController.forward(from: 0);
      }
    });
  }

  void _onPointerUp(PointerUpEvent event) {
    _isHolding = false;
    _holdTimer?.cancel();
    if (_phase == _GamePhase.cardReveal) {
      _revealController.reverse().then((_) {
        if (_currentPlayerIndex < widget.playerNames.length - 1) {
          setState(() => _phase = _GamePhase.passing);
        } else {
          setState(() => _phase = _GamePhase.complete);
          _cardAppearController.forward(from: 0);
        }
      });
    }
  }

  void _goToNextPlayer() {
    setState(() {
      _currentPlayerIndex++;
      _phase = _GamePhase.cardName;
    });
    _cardAppearController.forward(from: 0);
  }

  // ─── Helpers ────────────────────────────────────────────────────────────

  _CardTheme _getThemeForPlayer(int index) {
    if (_isImposter[index]) {
      int imposterNum = 0;
      for (int i = 0; i < index; i++) {
        if (_isImposter[i]) imposterNum++;
      }
      return _assignedImposterThemes[imposterNum % _assignedImposterThemes.length];
    } else {
      int playerNum = 0;
      for (int i = 0; i < index; i++) {
        if (!_isImposter[i]) playerNum++;
      }
      return _assignedPlayerThemes[playerNum % _assignedPlayerThemes.length];
    }
  }

  String _getHintForImposter(int playerIndex) {
    int imposterNum = 0;
    for (int i = 0; i < playerIndex; i++) {
      if (_isImposter[i]) imposterNum++;
    }
    final hintIdx = _imposterHintIndices[imposterNum];
    return _hints[hintIdx];
  }

  @override
  void dispose() {
    _holdTimer?.cancel();
    _loadingController.dispose();
    _cardAppearController.dispose();
    _revealController.dispose();
    _pulseController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  // ═════════════════════════════════════════════════════════════════════════
  // BUILD
  // ═════════════════════════════════════════════════════════════════════════

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A1A),
      body: Stack(
        children: [
          // Animated particle background
          Positioned.fill(
            child: AnimatedBuilder(
              animation: Listenable.merge([_particleController, _loadingController]),
              builder: (context, _) {
                final loadProgress = _phase == _GamePhase.loading
                    ? _loadingController.value
                    : 1.0;
                return CustomPaint(
                  painter: _GameParticlePainter(
                    particles: _particles,
                    loadProgress: loadProgress,
                  ),
                );
              },
            ),
          ),

          // Phase-specific content
          if (_phase == _GamePhase.loading) _buildLoadingPhase(),
          if (_phase == _GamePhase.cardName || _phase == _GamePhase.cardReveal)
            _buildCardPhase(context),
          if (_phase == _GamePhase.passing) _buildPassingPhase(context),
          if (_phase == _GamePhase.complete) _buildCompletePhase(context),
        ],
      ),
    );
  }

  // ═════════════════════════════════════════════════════════════════════════
  // LOADING PHASE
  // ═════════════════════════════════════════════════════════════════════════

  Widget _buildLoadingPhase() {
    return AnimatedBuilder(
      animation: _loadingController,
      builder: (context, _) {
        final t = _loadingController.value; // 0 → 1 over 4 seconds

        // Background gradient transitions: cool → dark
        final bgColor1 = Color.lerp(
          const Color(0xFF0EA5E9), // cyan
          const Color(0xFF0A0A1A), // near black
          t,
        )!;
        final bgColor2 = Color.lerp(
          const Color(0xFF36F1CD), // teal
          const Color(0xFF1A0A0A), // dark red-black
          t,
        )!;

        // Text progression
        String text;
        String emoji;
        Color textColor;
        if (t < 0.35) {
          text = 'The game begins...';
          emoji = '✨';
          textColor = Colors.white;
        } else if (t < 0.65) {
          text = 'Assigning roles...';
          emoji = '🌙';
          textColor = Color.lerp(Colors.white, const Color(0xFFC084FC), (t - 0.35) / 0.3)!;
        } else {
          text = 'Trust no one.';
          emoji = '😈';
          textColor = Color.lerp(const Color(0xFFC084FC), const Color(0xFFFF3D71), (t - 0.65) / 0.35)!;
        }

        // Center glow
        final glowColor = Color.lerp(
          const Color(0xFF00D9FF),
          const Color(0xFFFF3D71),
          t,
        )!;

        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.2,
              colors: [
                bgColor1.withValues(alpha: 0.3),
                bgColor2,
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Animated glow orb
                Container(
                  width: 80 + t * 20,
                  height: 80 + t * 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: glowColor.withValues(alpha: 0.3 + t * 0.2),
                        blurRadius: 40 + t * 30,
                        spreadRadius: 10 + t * 15,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      emoji,
                      style: TextStyle(fontSize: 40 + t * 10),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 20),
                // Progress bar
                SizedBox(
                  width: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: t,
                      backgroundColor: Colors.white.withValues(alpha: 0.1),
                      valueColor: AlwaysStoppedAnimation(glowColor),
                      minHeight: 3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ═════════════════════════════════════════════════════════════════════════
  // CARD PHASE (NAME + REVEAL)
  // ═════════════════════════════════════════════════════════════════════════

  Widget _buildCardPhase(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = (screenWidth * 0.85).clamp(280.0, 400.0);
    final playerName = widget.playerNames[_currentPlayerIndex];
    final isImp = _isImposter[_currentPlayerIndex];
    final theme = _getThemeForPlayer(_currentPlayerIndex);

    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _cardAppearAnimation,
          _revealAnimation,
          _pulseAnimation,
        ]),
        builder: (context, _) {
          final appear = _cardAppearAnimation.value;
          final reveal = _revealAnimation.value;
          final pulse = _pulseAnimation.value;

          // Background darkens/colorizes during reveal
          final bgOverlay = isImp
              ? theme.color2.withValues(alpha: reveal * 0.3)
              : theme.color1.withValues(alpha: reveal * 0.15);

          return Container(
            color: bgOverlay,
            child: SafeArea(
              child: Column(
                children: [
                  // Top progress indicator
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                    child: Row(
                      children: List.generate(widget.playerNames.length, (i) {
                        final isComplete = i < _currentPlayerIndex;
                        final isCurrent = i == _currentPlayerIndex;
                        return Expanded(
                          child: Container(
                            height: 3,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: isComplete
                                  ? const Color(0xFF36F1CD)
                                  : isCurrent
                                      ? Colors.white.withValues(alpha: 0.5)
                                      : Colors.white.withValues(alpha: 0.1),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                  // Player count label
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      'Player ${_currentPlayerIndex + 1} of ${widget.playerNames.length}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.4),
                        letterSpacing: 2,
                      ),
                    ),
                  ),

                  // Card
                  Expanded(
                    child: Center(
                      child: Transform.translate(
                        offset: Offset(0, 30 * (1 - appear)),
                        child: Opacity(
                          opacity: appear.clamp(0.0, 1.0),
                          child: Transform.scale(
                            scale: 0.9 + 0.1 * appear + reveal * 0.02,
                            child: SizedBox(
                              width: cardWidth,
                              child: _buildCard(
                                playerName: playerName,
                                isImposter: isImp,
                                theme: theme,
                                revealProgress: reveal,
                                pulseValue: pulse,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Instruction
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        _phase == _GamePhase.cardReveal
                            ? 'Release to continue'
                            : 'Hold to reveal your role',
                        key: ValueKey('instr_${_phase.name}'),
                        style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: _phase == _GamePhase.cardReveal
                              ? theme.accent.withValues(alpha: 0.8)
                              : Colors.white.withValues(alpha: 0.5),
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ─── The Card Widget ────────────────────────────────────────────────────

  Widget _buildCard({
    required String playerName,
    required bool isImposter,
    required _CardTheme theme,
    required double revealProgress,
    required double pulseValue,
  }) {
    // Colors morph from neutral dark → themed
    final cardColor1 = Color.lerp(
      const Color(0xFF1A1A2E),
      theme.color1,
      revealProgress,
    )!;
    final cardColor2 = Color.lerp(
      const Color(0xFF16162A),
      theme.color2,
      revealProgress,
    )!;
    final borderColor = Color.lerp(
      Colors.white.withValues(alpha: 0.08),
      theme.accent.withValues(alpha: 0.4),
      revealProgress,
    )!;
    final glowAlpha = revealProgress * (0.2 + pulseValue * 0.15);

    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: LinearGradient(
              colors: [cardColor1, cardColor2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: borderColor, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: theme.glowColor.withValues(alpha: glowAlpha),
                blurRadius: 30 + revealProgress * 30,
                spreadRadius: revealProgress * 10,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Theme emoji decoration (fades in on reveal)
              Opacity(
                opacity: revealProgress,
                child: Text(
                  theme.emoji,
                  style: const TextStyle(fontSize: 36),
                ),
              ),
              SizedBox(height: revealProgress * 16),

              // Role badge (fades in on reveal)
              Opacity(
                opacity: revealProgress,
                child: Transform.scale(
                  scale: 0.7 + revealProgress * 0.3,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: theme.accent.withValues(alpha: 0.15 + revealProgress * 0.1),
                      border: Border.all(
                        color: theme.accent.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      isImposter ? '😈 IMPOSTER' : '😇 PLAYER',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: theme.accent,
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Player name (always visible)
              Text(
                playerName,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Color.lerp(
                    Colors.white,
                    isImposter ? theme.textColor : theme.textColor,
                    revealProgress * 0.7,
                  ),
                  letterSpacing: 1,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              // Solid white underline divider
              Container(
                width: 60,
                height: 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1),
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),

              const SizedBox(height: 20),

              // Content: hidden state vs revealed
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: revealProgress > 0.4
                    ? _buildRevealedContent(
                        isImposter: isImposter,
                        theme: theme,
                        revealProgress: revealProgress,
                      )
                    : _buildHiddenContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHiddenContent() {
    return Column(
      key: const ValueKey('hidden'),
      children: [
        Icon(
          Icons.lock_rounded,
          size: 40,
          color: Colors.white.withValues(alpha: 0.15),
        ),
        const SizedBox(height: 12),
        Text(
          'HOLD TO REVEAL',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white.withValues(alpha: 0.2),
            letterSpacing: 3,
          ),
        ),
      ],
    );
  }

  Widget _buildRevealedContent({
    required bool isImposter,
    required _CardTheme theme,
    required double revealProgress,
  }) {
    final contentOpacity = ((revealProgress - 0.4) / 0.6).clamp(0.0, 1.0);
    final content = isImposter
        ? _getHintForImposter(_currentPlayerIndex)
        : _word;
    final label = isImposter ? 'YOUR HINT' : 'THE WORD';

    return Opacity(
      opacity: contentOpacity,
      child: Column(
        key: ValueKey('revealed_$isImposter'),
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: theme.accent.withValues(alpha: 0.7),
              letterSpacing: 4,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              fontSize: isImposter ? 20 : 32,
              fontWeight: FontWeight.w900,
              color: isImposter ? theme.textColor : theme.textColor,
              letterSpacing: isImposter ? 1 : 3,
              fontStyle: isImposter ? FontStyle.italic : FontStyle.normal,
            ),
            textAlign: TextAlign.center,
          ),
          if (isImposter) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: theme.accent.withValues(alpha: 0.08),
                border: Border.all(
                  color: theme.accent.withValues(alpha: 0.15),
                ),
              ),
              child: Text(
                '🤫 Blend in. Don\'t get caught.',
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: theme.accent.withValues(alpha: 0.8),
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ═════════════════════════════════════════════════════════════════════════
  // PASSING PHASE
  // ═════════════════════════════════════════════════════════════════════════

  Widget _buildPassingPhase(BuildContext context) {
    final nextName = widget.playerNames[_currentPlayerIndex + 1];

    return GestureDetector(
      onTap: _goToNextPlayer,
      child: Container(
        color: Colors.transparent,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🤫', style: TextStyle(fontSize: 56)),
              const SizedBox(height: 24),
              Text(
                'PASS THE DEVICE TO',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withValues(alpha: 0.4),
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                nextName,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 32),
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.white.withValues(alpha: 0.06),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Text(
                      'TAP WHEN READY',
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
            ],
          ),
        ),
      ),
    );
  }

  // ═════════════════════════════════════════════════════════════════════════
  // COMPLETE PHASE
  // ═════════════════════════════════════════════════════════════════════════

  Widget _buildCompletePhase(BuildContext context) {
    return AnimatedBuilder(
      animation: _cardAppearAnimation,
      builder: (context, _) {
        final appear = _cardAppearAnimation.value;
        return Opacity(
          opacity: appear.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - appear)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('🎭', style: TextStyle(fontSize: 64)),
                    const SizedBox(height: 24),
                    const Text(
                      'ALL ROLES ASSIGNED',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF36F1CD),
                        letterSpacing: 4,
                        shadows: [
                          Shadow(offset: Offset(0, 2), blurRadius: 0, color: Color(0xFF0A3D34)),
                          Shadow(offset: Offset(0, 4), blurRadius: 10, color: Color(0xFF36F1CD)),
                          Shadow(offset: Offset(0, 8), blurRadius: 20, color: Colors.black),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'The imposters are among you.\nStart the discussion!',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white.withValues(alpha: 0.5),
                        height: 1.6,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    // Start discussion timer button (Plain Blue -> Dark Red on hover)
                    MouseRegion(
                      onEnter: (_) => setState(() => _isDiscussionHovered = true),
                      onExit: (_) => setState(() => _isDiscussionHovered = false),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: _isDiscussionHovered
                              ? const Color(0xFF881337) // Dark Red on hover
                              : const Color(0xFF2563EB), // Plain Blue
                          border: Border.all(
                            color: _isDiscussionHovered
                                ? const Color(0xFFFF3D71).withValues(alpha: 0.6)
                                : const Color(0xFF60A5FA).withValues(alpha: 0.6),
                            width: 1.5,
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondary) =>
                                      GameTimerPage(
                                        timerMinutes: widget.timerMinutes,
                                        playerNames: widget.playerNames,
                                        isImposter: _isImposter,
                                      ),
                                  transitionsBuilder:
                                      (context, animation, secondary, child) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                                  transitionDuration:
                                      const Duration(milliseconds: 600),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(16),
                            splashColor: Colors.white.withValues(alpha: 0.2),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 36, vertical: 16),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('⏱️', style: TextStyle(fontSize: 18)),
                                  SizedBox(width: 12),
                                  Text(
                                    'START DISCUSSION',
                                    style: TextStyle(
                                      fontSize: 15,
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
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// PARTICLE SYSTEM
// ═════════════════════════════════════════════════════════════════════════════

class _GameParticle {
  double x, y, speedX, speedY, radius, opacity;

  _GameParticle({
    required this.x,
    required this.y,
    required this.speedX,
    required this.speedY,
    required this.radius,
    required this.opacity,
  });
}

class _GameParticlePainter extends CustomPainter {
  final List<_GameParticle> particles;
  final double loadProgress;

  _GameParticlePainter({required this.particles, required this.loadProgress});

  @override
  void paint(Canvas canvas, Size size) {
    // Particle color transitions from cool to dark during loading
    final particleColor = Color.lerp(
      const Color(0xFF00D9FF),
      const Color(0xFFFF3D71),
      loadProgress,
    )!;

    for (var p in particles) {
      final x = (p.x / 1000) * size.width;
      final y = (p.y / 2000) * size.height;
      canvas.drawCircle(
        Offset(x, y),
        p.radius,
        Paint()..color = particleColor.withValues(alpha: p.opacity),
      );
      if (p.radius > 1.8) {
        canvas.drawCircle(
          Offset(x, y),
          p.radius * 2,
          Paint()
            ..color = particleColor.withValues(alpha: p.opacity * 0.2)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
