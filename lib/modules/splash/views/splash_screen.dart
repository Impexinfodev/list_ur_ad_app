import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

/// ListUrAd Splash Screen
/// A beautiful animated splash screen with:
/// - Dynamic moving dot pattern background
/// - Radial vignette effect
/// - Animated greeting text cycling through multiple languages
/// - Pulsing brand dot
/// - Progress bar
/// - Footer with encrypted session branding

class SplashScreen extends StatefulWidget {
  final VoidCallback? onFinishLoading;
  final String? logoAssetPath;

  const SplashScreen({
    super.key,
    this.onFinishLoading,
    this.logoAssetPath = 'assets/images/logo.png',
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // Greetings data
  static const List<Map<String, String>> greetings = [
    {'text': 'Hello', 'lang': 'English'},
    {'text': 'नमस्ते', 'lang': 'Hindi'},
    {'text': 'Bonjour', 'lang': 'French'},
    {'text': 'Hola', 'lang': 'Spanish'},
    {'text': 'Ciao', 'lang': 'Italian'},
    {'text': 'سلام', 'lang': 'Persian'},
    {'text': 'Welcome', 'lang': 'Universal'},
  ];

  int _currentIndex = 0;
  bool _isExiting = false;

  // Animation Controllers
  late AnimationController _dotPatternController;
  late AnimationController _textSlideController;
  late AnimationController _brandDotController;
  late AnimationController _progressController;
  late AnimationController _fadeInController;
  late AnimationController _exitController;

  // Animations
  late Animation<double> _dotPatternAnimation;
  late Animation<Offset> _textSlideInAnimation;
  late Animation<Offset> _textSlideOutAnimation;
  late Animation<double> _textOpacityAnimation;
  late Animation<double> _brandDotScaleAnimation;
  late Animation<double> _progressAnimation;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _exitAnimation;

  Timer? _greetingTimer;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startGreetingCycle();
  }

  void _initializeAnimations() {
    // Dot pattern animation (20 seconds loop)
    _dotPatternController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
    _dotPatternAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _dotPatternController, curve: Curves.linear),
    );

    // Text slide animation
    _textSlideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    // Apple-style smooth easing curve
    const appleEasing = Cubic(0.76, 0, 0.24, 1);

    _textSlideInAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textSlideController,
      curve: appleEasing,
    ));

    _textSlideOutAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -1),
    ).animate(CurvedAnimation(
      parent: _textSlideController,
      curve: appleEasing,
    ));

    _textOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _textSlideController, curve: appleEasing),
    );

    // Brand dot pulsing animation
    _brandDotController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
    _brandDotScaleAnimation = Tween<double>(begin: 1, end: 1.2).animate(
      CurvedAnimation(parent: _brandDotController, curve: Curves.easeInOut),
    );

    // Progress bar animation
    final totalDuration =
        Duration(milliseconds: (greetings.length * 300) + 500);
    _progressController = AnimationController(
      vsync: this,
      duration: totalDuration,
    )..forward();
    _progressAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.linear),
    );

    // Fade in animation for footer
    _fadeInController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeInAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _fadeInController, curve: Curves.easeOut),
    );
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) _fadeInController.forward();
    });

    // Exit animation (curtain slide up)
    _exitController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _exitAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -1),
    ).animate(CurvedAnimation(
      parent: _exitController,
      curve: const Cubic(0.76, 0, 0.24, 1),
    ));

    // Initial text animation
    _textSlideController.forward();
  }

  void _startGreetingCycle() {
    _greetingTimer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      if (_currentIndex < greetings.length - 1) {
        _animateToNextGreeting();
      } else {
        timer.cancel();
        // Pause on "Welcome" before exit
        Future.delayed(const Duration(milliseconds: 800), () {
          if (mounted) _triggerExit();
        });
      }
    });
  }

  void _animateToNextGreeting() {
    _textSlideController.reverse().then((_) {
      if (mounted) {
        setState(() {
          _currentIndex++;
        });
        _textSlideController.forward();
      }
    });
  }

  void _triggerExit() {
    setState(() {
      _isExiting = true;
    });
    _exitController.forward().then((_) {
      widget.onFinishLoading?.call();
    });
  }

  @override
  void dispose() {
    _greetingTimer?.cancel();
    _dotPatternController.dispose();
    _textSlideController.dispose();
    _brandDotController.dispose();
    _progressController.dispose();
    _fadeInController.dispose();
    _exitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _exitAnimation,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // 1. Dynamic Moving Dot Pattern
            _buildDotPattern(),

            // 2. Radial Vignette
            _buildRadialVignette(),

            // 3. Central Content
            _buildCentralContent(context),

            // 4. Footer Branding
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildDotPattern() {
    return AnimatedBuilder(
      animation: _dotPatternAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: 0.1,
          child: CustomPaint(
            size: Size.infinite,
            painter: DotPatternPainter(
              offset: _dotPatternAnimation.value,
            ),
          ),
        );
      },
    );
  }

  Widget _buildRadialVignette() {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.0,
          colors: [
            Colors.white.withOpacity(0),
            Colors.white,
          ],
          stops: const [0.0, 0.9],
        ),
      ),
    );
  }

  Widget _buildCentralContent(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 576), // max-w-xl
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              _buildLogo(),

              const SizedBox(height: 48),

              // Greeting Text with Brand Dot
              _buildGreetingSection(isTablet),

              const SizedBox(height: 8),

              // Language Subtitle
              _buildLanguageSubtitle(),

              const SizedBox(height: 48),

              // Loading Progress Bar
              _buildProgressBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, -10 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: SizedBox(
        height: 160,
        width: 320,
        child: Image.asset(
          widget.logoAssetPath!,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            // Fallback if logo not found
            return Center(
              child: Text(
                'ListUrAd',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGreetingSection(bool isTablet) {
    final fontSize = isTablet ? 72.0 : 56.0;

    return SizedBox(
      height: isTablet ? 96 : 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Animated Greeting Text
          ClipRect(
            child: SlideTransition(
              position: _textSlideInAnimation,
              child: FadeTransition(
                opacity: _textOpacityAnimation,
                child: Text(
                  greetings[_currentIndex]['text']!,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A1A1A),
                    letterSpacing: -2,
                    height: 1,
                  ),
                ),
              ),
            ),
          ),

          // Pulsing Brand Dot
          ScaleTransition(
            scale: _brandDotScaleAnimation,
            child: Text(
              '.',
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF1877F2),
                height: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSubtitle() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: Text(
        greetings[_currentIndex]['lang']!.toUpperCase(),
        key: ValueKey(_currentIndex),
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          letterSpacing: 4,
          color: Colors.black.withOpacity(0.5),
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return SizedBox(
      width: 240,
      height: 2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(1),
        child: AnimatedBuilder(
          animation: _progressAnimation,
          builder: (context, child) {
            return LinearProgressIndicator(
              value: _progressAnimation.value,
              backgroundColor: const Color(0xFFF3F4F6),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF1877F2),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: FadeTransition(
        opacity: _fadeInAnimation,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shield,
              size: 16,
              color: const Color(0xFF1877F2),
            ),
            const SizedBox(width: 8),
            Text(
              'Encrypted Session',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
                color: const Color(0xFF9CA3AF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom painter for the animated dot pattern background
class DotPatternPainter extends CustomPainter {
  final double offset;

  DotPatternPainter({required this.offset});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1A1A1A)
      ..style = PaintingStyle.fill;

    const spacing = 32.0;
    const dotRadius = 1.0;

    // Calculate offset for animation
    final offsetX = (offset * size.width) % spacing;
    final offsetY = (offset * size.height) % spacing;

    for (double x = -spacing + offsetX; x < size.width + spacing; x += spacing) {
      for (double y = -spacing + offsetY; y < size.height + spacing; y += spacing) {
        canvas.drawCircle(Offset(x, y), dotRadius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(DotPatternPainter oldDelegate) {
    return oldDelegate.offset != offset;
  }
}

/// Helper widget for building animations
class AnimatedBuilder extends AnimatedWidget {
  final Widget Function(BuildContext context, Widget? child) builder;
  final Widget? child;

  const AnimatedBuilder({
    super.key,
    required Animation<double> animation,
    required this.builder,
    this.child,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    return builder(context, child);
  }
}

// ============================================================================
// USAGE EXAMPLE
// ============================================================================
//
// In your main.dart or wherever you want to use the splash screen:
//
// ```dart
// import 'splash_screen.dart';
//
// class MyApp extends StatefulWidget {
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   bool _showSplash = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: _showSplash
//           ? SplashScreen(
//               logoAssetPath: 'assets/images/logo.png',
//               onFinishLoading: () {
//                 setState(() {
//                   _showSplash = false;
//                 });
//               },
//             )
//           : YourHomePage(),
//     );
//   }
// }
// ```
//
// Don't forget to add your logo to pubspec.yaml:
//
// ```yaml
// flutter:
//   assets:
//     - assets/images/logo.png
// ```
// ============================================================================
