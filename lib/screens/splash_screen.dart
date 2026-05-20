// // screens/splash_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'login_screen.dart'; // for AppColors + LoginScreen
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//
//   // ── Animation Controllers ──────────────────────────────────
//   late final AnimationController _bgCtrl;
//   late final AnimationController _ringCtrl;
//   late final AnimationController _logoCtrl;
//   late final AnimationController _textCtrl;
//   late final AnimationController _taglineCtrl;
//   late final AnimationController _shimmerCtrl;
//   late final AnimationController _dividerCtrl;
//
//   // ── Animations ─────────────────────────────────────────────
//   late final Animation<double>  _bgAnim;
//   late final Animation<double>  _ringScale;
//   late final Animation<double>  _ringOpacity;
//   late final Animation<double>  _logoScale;
//   late final Animation<double>  _logoOpacity;
//   late final Animation<Offset>  _textSlide;
//   late final Animation<double>  _textOpacity;
//   late final Animation<double>  _taglineOpacity;
//   late final Animation<double>  _shimmerAnim;
//   late final Animation<double>  _dividerWidth;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Status bar: light icons on gold bg
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: Brightness.light,
//     ));
//
//     // ── Controllers ──
//     _bgCtrl      = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
//     _ringCtrl    = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
//     _logoCtrl    = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
//     _textCtrl    = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
//     _taglineCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
//     _shimmerCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1800))..repeat();
//     _dividerCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
//
//     // ── Curves ──
//     _bgAnim = CurvedAnimation(parent: _bgCtrl, curve: Curves.easeIn);
//
//     _ringScale = Tween<double>(begin: 0.4, end: 1.0)
//         .animate(CurvedAnimation(parent: _ringCtrl, curve: Curves.elasticOut));
//     _ringOpacity = Tween<double>(begin: 0.0, end: 1.0)
//         .animate(CurvedAnimation(parent: _ringCtrl, curve: const Interval(0.0, 0.4, curve: Curves.easeIn)));
//
//     _logoScale = Tween<double>(begin: 0.5, end: 1.0)
//         .animate(CurvedAnimation(parent: _logoCtrl, curve: Curves.easeOutBack));
//     _logoOpacity = Tween<double>(begin: 0.0, end: 1.0)
//         .animate(CurvedAnimation(parent: _logoCtrl, curve: const Interval(0.0, 0.5, curve: Curves.easeIn)));
//
//     _textSlide = Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero)
//         .animate(CurvedAnimation(parent: _textCtrl, curve: Curves.easeOut));
//     _textOpacity = Tween<double>(begin: 0.0, end: 1.0)
//         .animate(CurvedAnimation(parent: _textCtrl, curve: Curves.easeIn));
//
//     _taglineOpacity = Tween<double>(begin: 0.0, end: 1.0)
//         .animate(CurvedAnimation(parent: _taglineCtrl, curve: Curves.easeIn));
//
//     _shimmerAnim = Tween<double>(begin: -1.5, end: 2.5)
//         .animate(CurvedAnimation(parent: _shimmerCtrl, curve: Curves.easeInOut));
//
//     _dividerWidth = Tween<double>(begin: 0.0, end: 1.0)
//         .animate(CurvedAnimation(parent: _dividerCtrl, curve: Curves.easeOut));
//
//     // ── Sequence ──
//     _runSequence();
//   }
//
//   Future<void> _runSequence() async {
//     await Future.delayed(const Duration(milliseconds: 100));
//     _bgCtrl.forward();
//
//     await Future.delayed(const Duration(milliseconds: 300));
//     _ringCtrl.forward();
//
//     await Future.delayed(const Duration(milliseconds: 250));
//     _logoCtrl.forward();
//
//     await Future.delayed(const Duration(milliseconds: 300));
//     _dividerCtrl.forward();
//     _textCtrl.forward();
//
//     await Future.delayed(const Duration(milliseconds: 250));
//     _taglineCtrl.forward();
//
//     // Navigate after total ~2.4s
//     await Future.delayed(const Duration(milliseconds: 1400));
//     _navigate();
//   }
//
//   void _navigate() {
//     if (!mounted) return;
//     Navigator.pushReplacement(
//       context,
//       PageRouteBuilder(
//         transitionDuration: const Duration(milliseconds: 600),
//         pageBuilder: (_, __, ___) => const LoginScreen(),
//         transitionsBuilder: (_, animation, __, child) {
//           return FadeTransition(opacity: animation, child: child);
//         },
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _bgCtrl.dispose();
//     _ringCtrl.dispose();
//     _logoCtrl.dispose();
//     _textCtrl.dispose();
//     _taglineCtrl.dispose();
//     _shimmerCtrl.dispose();
//     _dividerCtrl.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AnimatedBuilder(
//         animation: Listenable.merge([
//           _bgCtrl, _ringCtrl, _logoCtrl,
//           _textCtrl, _taglineCtrl, _shimmerCtrl, _dividerCtrl,
//         ]),
//         builder: (context, _) {
//           return Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: const [AppColors.goldDark, AppColors.gold, AppColors.goldLight],
//                 stops: const [0.0, 0.55, 1.0],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//
//                 // ── Background shimmer sweep ──
//                 Positioned.fill(
//                   child: Opacity(
//                     opacity: 0.18,
//                     child: Transform.translate(
//                       offset: Offset(
//                         _shimmerAnim.value * MediaQuery.of(context).size.width,
//                         0,
//                       ),
//                       child: Transform.rotate(
//                         angle: -0.4,
//                         child: Container(
//                           width: 120,
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: [
//                                 Colors.transparent,
//                                 AppColors.white.withOpacity(0.9),
//                                 Colors.transparent,
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 // ── Outer decorative ring ──
//                 Transform.scale(
//                   scale: _ringScale.value,
//                   child: Opacity(
//                     opacity: (_ringOpacity.value * 0.25).clamp(0.0, 1.0),
//                     child: Container(
//                       width: 240,
//                       height: 240,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(color: AppColors.white, width: 1),
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 // ── Inner ring ──
//                 Transform.scale(
//                   scale: _ringScale.value,
//                   child: Opacity(
//                     opacity: (_ringOpacity.value * 0.4).clamp(0.0, 1.0),
//                     child: Container(
//                       width: 186,
//                       height: 186,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(color: AppColors.white, width: 1.2),
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 // ── Logo circle ──
//                 Transform.scale(
//                   scale: _logoScale.value,
//                   child: Opacity(
//                     opacity: _logoOpacity.value,
//                     child: Container(
//                       width: 140,
//                       height: 140,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: AppColors.white,
//                         boxShadow: [
//                           BoxShadow(
//                             color: AppColors.goldDark.withOpacity(0.4),
//                             blurRadius: 40,
//                             spreadRadius: 4,
//                             offset: const Offset(0, 8),
//                           ),
//                         ],
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(20),
//                         child: Image.asset(
//                           'assets/images/logo.png',
//                           fit: BoxFit.contain,
//                           errorBuilder: (_, __, ___) => const Icon(
//                             Icons.apartment_rounded,
//                             size: 64,
//                             color: AppColors.gold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 // ── Text block (below center) ──
//                 Positioned(
//                   bottom: MediaQuery.of(context).size.height * 0.28,
//                   child: Column(
//                     children: [
//                       // Divider
//                       AnimatedBuilder(
//                         animation: _dividerCtrl,
//                         builder: (_, __) => SizedBox(
//                           width: 180 * _dividerWidth.value,
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: Container(
//                                   height: 1,
//                                   color: AppColors.white.withOpacity(0.5),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 8),
//                                 child: Transform.rotate(
//                                   angle: 0.7854,
//                                   child: Container(
//                                     width: 5,
//                                     height: 5,
//                                     decoration: BoxDecoration(
//                                       color: AppColors.white,
//                                       borderRadius: BorderRadius.circular(1),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Container(
//                                   height: 1,
//                                   color: AppColors.white.withOpacity(0.5),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//
//                       const SizedBox(height: 18),
//
//                       // App name
//                       SlideTransition(
//                         position: _textSlide,
//                         child: FadeTransition(
//                           opacity: _textOpacity,
//                           child: const Text(
//                             'AL NOOR TOWN',
//                             style: TextStyle(
//                               fontFamily: 'Cormorant',
//                               fontSize: 28,
//                               fontWeight: FontWeight.w700,
//                               color: AppColors.white,
//                               letterSpacing: 5,
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       const SizedBox(height: 8),
//
//                       // Tagline
//                       FadeTransition(
//                         opacity: _taglineOpacity,
//                         child: Text(
//                           'Community Management System',
//                           style: TextStyle(
//                             fontFamily: 'Cormorant',
//                             fontSize: 13,
//                             color: AppColors.white.withOpacity(0.8),
//                             letterSpacing: 1.5,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 // ── Bottom loading dots ──
//                 Positioned(
//                   bottom: 52,
//                   child: FadeTransition(
//                     opacity: _taglineOpacity,
//                     child: _LoadingDots(),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// // ── Animated loading dots ──────────────────────────────────────
// class _LoadingDots extends StatefulWidget {
//   @override
//   State<_LoadingDots> createState() => _LoadingDotsState();
// }
//
// class _LoadingDotsState extends State<_LoadingDots>
//     with TickerProviderStateMixin {
//   final List<AnimationController> _controllers = [];
//   final List<Animation<double>> _anims = [];
//
//   @override
//   void initState() {
//     super.initState();
//     for (int i = 0; i < 3; i++) {
//       final ctrl = AnimationController(
//         vsync: this,
//         duration: const Duration(milliseconds: 600),
//       );
//       final anim = Tween<double>(begin: 0.3, end: 1.0).animate(
//         CurvedAnimation(parent: ctrl, curve: Curves.easeInOut),
//       );
//       _controllers.add(ctrl);
//       _anims.add(anim);
//
//       Future.delayed(Duration(milliseconds: i * 1800), () {
//         if (mounted) ctrl.repeat(reverse: true);
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     for (final c in _controllers) c.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: List.generate(3, (i) {
//         return AnimatedBuilder(
//           animation: _anims[i],
//           builder: (_, __) => Container(
//             margin: const EdgeInsets.symmetric(horizontal: 4),
//             width: 6,
//             height: 6,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: AppColors.white.withOpacity(_anims[i].value),
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }

// screens/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_screen.dart';

class AppColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color gold = Color(0xFFC9A84C);
  static const Color goldLight = Color(0xFFDEC46A);
  static const Color goldDark = Color(0xFFA07C2E);
  static const Color charcoal = Color(0xFF2C2C2C);
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    _fadeController.forward();

    Future.delayed(const Duration(milliseconds: 2000), _navigate);
  }

  void _navigate() {
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) => const LoginScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.goldDark, AppColors.gold, AppColors.goldLight],
          ),
        ),
        child: Stack(
          children: [
            // Subtle background circles
            Positioned(
              top: -80,
              right: -80,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white.withOpacity(0.08),
                ),
              ),
            ),
            Positioned(
              bottom: -60,
              left: -60,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white.withOpacity(0.06),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.4,
              left: -40,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white.withOpacity(0.04),
                ),
              ),
            ),

            // Main content
            SafeArea(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo (centered vertically)
                    Expanded(
                      child: Center(
                        child: Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.white,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.charcoal.withOpacity(0.15),
                                blurRadius: 30,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Image.asset(
                                'assets/images/logo.png',
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) => const Icon(
                                  Icons.apartment_rounded,
                                  size: 60,
                                  color: AppColors.gold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // App Name at bottom
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Column(
                        children: [
                          const Text(
                            'AL NOOR TOWN',
                            style: TextStyle(
                              fontFamily: 'Cormorant',
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                              letterSpacing: 5,
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Loading dots
                          _LoadingDots(),
                        ],
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
}

class _LoadingDots extends StatefulWidget {
  @override
  State<_LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<_LoadingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final value = _controller.value;
            final delay = index * 0.3;
            final opacity = ((value + delay) % 1.0);
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white.withOpacity(opacity),
              ),
            );
          },
        );
      }),
    );
  }
}