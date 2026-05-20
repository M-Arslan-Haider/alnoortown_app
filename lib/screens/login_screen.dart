//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/auth_provider.dart';
// import '../services/home_screen.dart';
// import 'forget_password.dart';
// import 'register_screen.dart';
//
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _obscurePassword = true;
//
//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _handleLogin() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     final success = await authProvider.signIn(
//       email: _emailController.text.trim(),
//       password: _passwordController.text,
//     );
//
//     if (success && mounted) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const HomeScreen()),
//       );
//     } else if (mounted && authProvider.errorMessage != null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(authProvider.errorMessage!),
//           backgroundColor: Colors.red,
//           behavior: SnackBarBehavior.floating,
//         ),
//       );
//       authProvider.clearError();
//     }
//   }
//
//   Future<void> _handleGoogleSignIn() async {
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     final success = await authProvider.signInWithGoogle();
//
//     if (success && mounted) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const HomeScreen()),
//       );
//     } else if (mounted && authProvider.errorMessage != null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(authProvider.errorMessage!),
//           backgroundColor: Colors.red,
//           behavior: SnackBarBehavior.floating,
//         ),
//       );
//       authProvider.clearError();
//     }
//   }
//
//   void _navigateToForgotPassword() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const SizedBox(height: 60),
//               // Logo/Header
//               Icon(
//                 Icons.lock_open_rounded,
//                 size: 80,
//                 color: Theme.of(context).primaryColor,
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 'Welcome Back!',
//                 style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 'Sign in to continue',
//                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                   color: Colors.grey[600],
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 40),
//               // Form
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     // Email Field
//                     TextFormField(
//                       controller: _emailController,
//                       keyboardType: TextInputType.emailAddress,
//                       decoration: InputDecoration(
//                         labelText: 'Email',
//                         hintText: 'Enter your email',
//                         prefixIcon: const Icon(Icons.email_outlined),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         filled: true,
//                         fillColor: Colors.grey[50],
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your email';
//                         }
//                         if (!value.contains('@') || !value.contains('.')) {
//                           return 'Please enter a valid email';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 16),
//                     // Password Field
//                     TextFormField(
//                       controller: _passwordController,
//                       obscureText: _obscurePassword,
//                       decoration: InputDecoration(
//                         labelText: 'Password',
//                         hintText: 'Enter your password',
//                         prefixIcon: const Icon(Icons.lock_outline),
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             _obscurePassword
//                                 ? Icons.visibility_off
//                                 : Icons.visibility,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _obscurePassword = !_obscurePassword;
//                             });
//                           },
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         filled: true,
//                         fillColor: Colors.grey[50],
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your password';
//                         }
//                         if (value.length < 6) {
//                           return 'Password must be at least 6 characters';
//                         }
//                         return null;
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 8),
//               // Forgot Password Link
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: TextButton(
//                   onPressed: _navigateToForgotPassword,
//                   child: const Text(
//                     'Forgot Password?',
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 24),
//               // Login Button
//               Consumer<AuthProvider>(
//                 builder: (context, authProvider, child) {
//                   return ElevatedButton(
//                     onPressed: authProvider.isLoading ? null : _handleLogin,
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: authProvider.isLoading
//                         ? const SizedBox(
//                       height: 20,
//                       width: 20,
//                       child: CircularProgressIndicator(
//                         strokeWidth: 2,
//                         valueColor: AlwaysStoppedAnimation<Color>(
//                             Colors.white),
//                       ),
//                     )
//                         : const Text(
//                       'Sign In',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   );
//                 },
//               ),
//               const SizedBox(height: 16),
//               // OR Divider
//               Row(
//                 children: [
//                   Expanded(child: Divider(color: Colors.grey[300])),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     child: Text(
//                       'OR',
//                       style: TextStyle(color: Colors.grey[600]),
//                     ),
//                   ),
//                   Expanded(child: Divider(color: Colors.grey[300])),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               // Google Sign In Button
//               OutlinedButton.icon(
//                 onPressed: _handleGoogleSignIn,
//                 icon: Image.network(
//                   'https://www.google.com/favicon.ico',
//                   height: 24,
//                   width: 24,
//                 ),
//                 label: const Text('Continue with Google'),
//                 style: OutlinedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               // Register Link
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Don't have an account?",
//                     style: TextStyle(color: Colors.grey[600]),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const RegisterScreen(),
//                         ),
//                       );
//                     },
//                     child: const Text('Sign Up'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../services/home_screen.dart';
import 'register_screen.dart';

// ─────────────────────────────────────────────────────────────
//  APP COLORS  (move to app_colors.dart)
// ─────────────────────────────────────────────────────────────
class AppColors {
  static const Color white     = Color(0xFFFFFFFF);
  static const Color offWhite  = Color(0xFFF9F6F0);
  static const Color inputFill = Color(0xFFFAF8F4);
  static const Color divider   = Color(0xFFE8E2D6);
  static const Color gold      = Color(0xFFC9A84C);
  static const Color goldLight = Color(0xFFE2C97E);
  static const Color goldDark  = Color(0xFF9E7D35);
  static const Color charcoal  = Color(0xFF1E1E1E);
  static const Color grey      = Color(0xFF888888);
  static const Color greyLight = Color(0xFFD5D0C8);
  static const Color error     = Color(0xFFB94040);
}

// ─────────────────────────────────────────────────────────────
//  LOGIN SCREEN
// ─────────────────────────────────────────────────────────────
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  final _formKey             = GlobalKey<FormState>();
  final _emailController     = TextEditingController();
  final _passwordController  = TextEditingController();
  bool _obscurePassword      = true;

  late final AnimationController _fadeCtrl;
  late final Animation<double>   _fadeAnim;
  late final AnimationController _slideCtrl;
  late final Animation<Offset>   _slideAnim;

  @override
  void initState() {
    super.initState();
    _fadeCtrl  = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnim  = CurvedAnimation(parent: _fadeCtrl,  curve: Curves.easeOut);
    _slideCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.07), end: Offset.zero)
        .animate(CurvedAnimation(parent: _slideCtrl, curve: Curves.easeOut));
    _fadeCtrl.forward();
    _slideCtrl.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fadeCtrl.dispose();
    _slideCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final ok   = await auth.signIn(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
    if (!mounted) return;
    if (ok) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    } else if (auth.errorMessage != null) {
      _showError(auth.errorMessage!);
      auth.clearError();
    }
  }

  Future<void> _handleGoogleSignIn() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final ok   = await auth.signInWithGoogle();
    if (!mounted) return;
    if (ok) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    } else if (auth.errorMessage != null) {
      _showError(auth.errorMessage!);
      auth.clearError();
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg, style: const TextStyle(fontFamily: 'Cormorant', fontSize: 14, color: AppColors.white)),
      backgroundColor: AppColors.error,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(16),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // ── Top gold accent bar ──
          Positioned(
            top: 0, left: 0, right: 0,
            child: Container(
              height: 5,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.goldDark, AppColors.goldLight, AppColors.goldDark],
                ),
              ),
            ),
          ),
          // ── Subtle top-right circle ornament ──
          Positioned(
            top: -70, right: -70,
            child: Container(
              width: 210, height: 210,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.gold.withOpacity(0.06),
              ),
            ),
          ),
          // ── Subtle bottom-left circle ornament ──
          Positioned(
            bottom: -55, left: -55,
            child: Container(
              width: 170, height: 170,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.gold.withOpacity(0.06),
              ),
            ),
          ),

          // ── Main content ──
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: SlideTransition(
                position: _slideAnim,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 30),

                      // Logo
                      const Center(child: _LogoWidget()),

                      const SizedBox(height: 30),

                      // Heading
                      const Text(
                        'Welcome Back',
                        style: TextStyle(
                          fontFamily: 'Cormorant',
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                          color: AppColors.charcoal,
                          letterSpacing: 0.4,
                          height: 1.1,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Sign in to your account',
                        style: TextStyle(
                          fontFamily: 'Cormorant',
                          fontSize: 17,
                          color: AppColors.grey,
                          letterSpacing: 0.2,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 28),
                      const _GoldDivider(),
                      const SizedBox(height: 30),

                      // Form
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _GoldInputField(
                              controller: _emailController,
                              label: 'Email Address',
                              hint: 'your@email.com',
                              icon: Icons.alternate_email_rounded,
                              keyboardType: TextInputType.emailAddress,
                              validator: (v) {
                                if (v == null || v.isEmpty) return 'Email is required';
                                if (!v.contains('@') || !v.contains('.')) return 'Enter a valid email';
                                return null;
                              },
                            ),
                            const SizedBox(height: 18),
                            _GoldInputField(
                              controller: _passwordController,
                              label: 'Password',
                              hint: '••••••••',
                              icon: Icons.lock_outline_rounded,
                              obscureText: _obscurePassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                  color: AppColors.gold, size: 20,
                                ),
                                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                              ),
                              validator: (v) {
                                if (v == null || v.isEmpty) return 'Password is required';
                                if (v.length < 6) return 'Minimum 6 characters';
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),

                      // Forgot password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontFamily: 'Cormorant',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.gold,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 22),

                      // Sign In Button
                      Consumer<AuthProvider>(
                        builder: (_, auth, __) => _GoldButton(
                          label: 'Sign In',
                          isLoading: auth.isLoading,
                          onPressed: auth.isLoading ? null : _handleLogin,
                        ),
                      ),

                      const SizedBox(height: 22),

                      // OR divider
                      Row(
                        children: [
                          Expanded(child: Divider(color: AppColors.greyLight, thickness: 1)),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14),
                            child: Text('OR',
                              style: TextStyle(
                                fontFamily: 'Cormorant', fontSize: 13,
                                color: AppColors.grey, letterSpacing: 2,
                              ),
                            ),
                          ),
                          Expanded(child: Divider(color: AppColors.greyLight, thickness: 1)),
                        ],
                      ),

                      const SizedBox(height: 18),

                      // Google Button
                      _OutlineButton(
                        onPressed: _handleGoogleSignIn,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network('https://www.google.com/favicon.ico',
                              height: 20, width: 20,
                              errorBuilder: (_, __, ___) =>
                              const Icon(Icons.g_mobiledata_rounded, color: AppColors.gold, size: 22),
                            ),
                            const SizedBox(width: 10),
                            const Text('Continue with Google',
                              style: TextStyle(
                                fontFamily: 'Cormorant', fontSize: 16,
                                fontWeight: FontWeight.w600, color: AppColors.charcoal,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 36),

                      // Register link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?  ",
                              style: TextStyle(fontFamily: 'Cormorant', fontSize: 16, color: AppColors.grey)),
                          GestureDetector(
                            onTap: () => Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) => const RegisterScreen())),
                            child: const Text('Sign Up',
                              style: TextStyle(
                                fontFamily: 'Cormorant', fontSize: 16,
                                fontWeight: FontWeight.w700, color: AppColors.gold,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  SHARED WIDGETS  (can extract to shared_widgets.dart)
// ─────────────────────────────────────────────────────────────

class _LogoWidget extends StatelessWidget {
  const _LogoWidget();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 114,
      height: 114,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white,
        border: Border.all(color: AppColors.gold, width: 1.8),
        boxShadow: [
          BoxShadow(color: AppColors.gold.withOpacity(0.22), blurRadius: 30, spreadRadius: 2),
          BoxShadow(color: AppColors.gold.withOpacity(0.08), blurRadius: 8),
        ],
      ),
      child: ClipOval(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Image.asset(
            'assets/images/logo.png',
          ),
        ),
      ),
    );
  }
}

class _GoldDivider extends StatelessWidget {
  const _GoldDivider();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(height: 1,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Colors.transparent, AppColors.goldLight]),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Transform.rotate(
            angle: 0.7854,
            child: Container(
              width: 7, height: 7,
              decoration: BoxDecoration(
                color: AppColors.gold,
                borderRadius: BorderRadius.circular(1.5),
                boxShadow: [BoxShadow(color: AppColors.gold.withOpacity(0.5), blurRadius: 6)],
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(height: 1,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [AppColors.goldLight, Colors.transparent]),
            ),
          ),
        ),
      ],
    );
  }
}

class _GoldInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const _GoldInputField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(
        fontFamily: 'Cormorant', fontSize: 16,
        color: AppColors.charcoal, fontWeight: FontWeight.w600,
      ),
      cursorColor: AppColors.gold,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(
          fontFamily: 'Cormorant', fontSize: 14,
          color: AppColors.grey, letterSpacing: 0.3,
        ),
        hintStyle: TextStyle(
          fontFamily: 'Cormorant', fontSize: 15,
          color: AppColors.grey.withOpacity(0.5),
        ),
        errorStyle: const TextStyle(
            fontFamily: 'Cormorant', fontSize: 13, color: AppColors.error),
        prefixIcon: Icon(icon, color: AppColors.gold, size: 20),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppColors.inputFill,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.gold, width: 1.6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 1.6),
        ),
      ),
    );
  }
}

class _GoldButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final VoidCallback? onPressed;

  const _GoldButton({required this.label, required this.isLoading, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          gradient: onPressed != null
              ? const LinearGradient(
            colors: [AppColors.goldDark, AppColors.gold, AppColors.goldLight],
            stops: [0.0, 0.5, 1.0],
          )
              : LinearGradient(colors: [
            AppColors.gold.withOpacity(0.5),
            AppColors.goldLight.withOpacity(0.5),
          ]),
          boxShadow: onPressed != null
              ? [
            BoxShadow(color: AppColors.gold.withOpacity(0.35), blurRadius: 18, offset: const Offset(0, 6)),
            BoxShadow(color: AppColors.gold.withOpacity(0.15), blurRadius: 6,  offset: const Offset(0, 2)),
          ]
              : [],
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
            width: 22, height: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
            ),
          )
              : Text(label,
            style: const TextStyle(
              fontFamily: 'Cormorant', fontSize: 18,
              fontWeight: FontWeight.w700, color: AppColors.white,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  const _OutlineButton({required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        side: const BorderSide(color: AppColors.gold, width: 1.4),
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      child: child,
    );
  }
}