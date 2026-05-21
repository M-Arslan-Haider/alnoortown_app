//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'login_screen.dart';
//
// class AppColors {
//   static const Color white = Color(0xFFFFFFFF);
//   static const Color gold = Color(0xFFC9A84C);
//   static const Color goldLight = Color(0xFFDEC46A);
//   static const Color goldDark = Color(0xFFA07C2E);
//   static const Color charcoal = Color(0xFF2C2C2C);
// }
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//
//   late final AnimationController _fadeController;
//   late final Animation<double> _fadeAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//         statusBarIconBrightness: Brightness.light,
//       ),
//     );
//
//     _fadeController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1000),
//     );
//
//     _fadeAnimation = CurvedAnimation(
//       parent: _fadeController,
//       curve: Curves.easeIn,
//     );
//
//     _fadeController.forward();
//
//     Future.delayed(const Duration(milliseconds: 2000), _navigate);
//   }
//
//   void _navigate() {
//     if (!mounted) return;
//     Navigator.pushReplacement(
//       context,
//       PageRouteBuilder(
//         transitionDuration: const Duration(milliseconds: 400),
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
//     _fadeController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [AppColors.goldDark, AppColors.gold, AppColors.goldLight],
//           ),
//         ),
//         child: Stack(
//           children: [
//             // Subtle background circles
//             Positioned(
//               top: -80,
//               right: -80,
//               child: Container(
//                 width: 220,
//                 height: 220,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: AppColors.white.withOpacity(0.08),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: -60,
//               left: -60,
//               child: Container(
//                 width: 180,
//                 height: 180,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: AppColors.white.withOpacity(0.06),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: MediaQuery.of(context).size.height * 0.4,
//               left: -40,
//               child: Container(
//                 width: 120,
//                 height: 120,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: AppColors.white.withOpacity(0.04),
//                 ),
//               ),
//             ),
//
//             // Main content
//             SafeArea(
//               child: FadeTransition(
//                 opacity: _fadeAnimation,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // Logo (centered vertically)
//                     Expanded(
//                       child: Center(
//                         child: Container(
//                           width: 140,
//                           height: 140,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: AppColors.white,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: AppColors.charcoal.withOpacity(0.15),
//                                 blurRadius: 30,
//                                 spreadRadius: 5,
//                               ),
//                             ],
//                           ),
//                           child: ClipOval(
//                             child: Padding(
//                               padding: const EdgeInsets.all(24),
//                               child: Image.asset(
//                                 'assets/images/logo.png',
//                                 fit: BoxFit.contain,
//                                 errorBuilder: (_, __, ___) => const Icon(
//                                   Icons.apartment_rounded,
//                                   size: 60,
//                                   color: AppColors.gold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     // App Name at bottom
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 50),
//                       child: Column(
//                         children: [
//                           const Text(
//                             'AL NOOR TOWN',
//                             style: TextStyle(
//                               fontFamily: 'Cormorant',
//                               fontSize: 28,
//                               fontWeight: FontWeight.w700,
//                               color: AppColors.white,
//                               letterSpacing: 5,
//                             ),
//                           ),
//                           const SizedBox(height: 12),
//                           // Loading dots
//                           _LoadingDots(),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _LoadingDots extends StatefulWidget {
//   @override
//   State<_LoadingDots> createState() => _LoadingDotsState();
// }
//
// class _LoadingDotsState extends State<_LoadingDots>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 900),
//     )..repeat();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: List.generate(3, (index) {
//         return AnimatedBuilder(
//           animation: _controller,
//           builder: (context, child) {
//             final value = _controller.value;
//             final delay = index * 0.3;
//             final opacity = ((value + delay) % 1.0);
//             return Container(
//               margin: const EdgeInsets.symmetric(horizontal: 5),
//               width: 8,
//               height: 8,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: AppColors.white.withOpacity(opacity),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }

// screens/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_screen.dart';
import '../main.dart'; // AuthWrapper

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
        pageBuilder: (_, __, ___) => const AuthWrapper(),
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
