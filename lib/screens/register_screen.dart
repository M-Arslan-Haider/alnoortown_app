//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/auth_provider.dart';
// import '../services/home_screen.dart';
// import 'login_screen.dart';
//
// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});
//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }
//
// class _RegisterScreenState extends State<RegisterScreen> with TickerProviderStateMixin {
//   final _formKey                   = GlobalKey<FormState>();
//   final _nameController            = TextEditingController();
//   final _emailController           = TextEditingController();
//   final _passwordController        = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   bool _obscurePassword            = true;
//   bool _obscureConfirmPassword     = true;
//
//   late final AnimationController _fadeCtrl;
//   late final Animation<double>   _fadeAnim;
//   late final AnimationController _slideCtrl;
//   late final Animation<Offset>   _slideAnim;
//
//   @override
//   void initState() {
//     super.initState();
//     _fadeCtrl  = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
//     _fadeAnim  = CurvedAnimation(parent: _fadeCtrl,  curve: Curves.easeOut);
//     _slideCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
//     _slideAnim = Tween<Offset>(begin: const Offset(0, 0.07), end: Offset.zero)
//         .animate(CurvedAnimation(parent: _slideCtrl, curve: Curves.easeOut));
//     _fadeCtrl.forward();
//     _slideCtrl.forward();
//   }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     _fadeCtrl.dispose();
//     _slideCtrl.dispose();
//     super.dispose();
//   }
//
//   void _goBack() {
//     if (Navigator.canPop(context)) {
//       Navigator.pop(context);
//     } else {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const LoginScreen()),
//       );
//     }
//   }
//
//   Future<void> _handleRegister() async {
//     if (!_formKey.currentState!.validate()) return;
//     final auth = Provider.of<AuthProvider>(context, listen: false);
//     final ok   = await auth.signUp(
//       name: _nameController.text.trim(),
//       email: _emailController.text.trim(),
//       password: _passwordController.text,
//     );
//     if (!mounted) return;
//     if (ok) {
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
//     } else if (auth.errorMessage != null) {
//       _showError(auth.errorMessage!);
//       auth.clearError();
//     }
//   }
//
//   void _showError(String msg) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(msg,
//           style: const TextStyle(fontFamily: 'Cormorant', fontSize: 14, color: AppColors.white)),
//       backgroundColor: AppColors.error,
//       behavior: SnackBarBehavior.floating,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       margin: const EdgeInsets.all(16),
//     ));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       // ── Use built-in AppBar for proper system back support ──
//       appBar: AppBar(
//         backgroundColor: AppColors.white,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         automaticallyImplyLeading: false,
//         leading: GestureDetector(
//           onTap: _goBack,
//           child: Container(
//             margin: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               border: Border.all(color: AppColors.gold.withOpacity(0.5), width: 1.2),
//               color: AppColors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: AppColors.gold.withOpacity(0.10),
//                   blurRadius: 8,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: const Icon(
//               Icons.arrow_back_ios_new_rounded,
//               color: AppColors.gold,
//               size: 16,
//             ),
//           ),
//         ),
//         // Top gold accent bar
//         flexibleSpace: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Container(
//               height: 5,
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [AppColors.goldDark, AppColors.goldLight, AppColors.goldDark],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Stack(
//         children: [
//           // ── Ornament circles ──
//           Positioned(
//             top: -60, right: -60,
//             child: Container(
//               width: 200, height: 200,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: AppColors.gold.withOpacity(0.06),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: -55, left: -55,
//             child: Container(
//               width: 170, height: 170,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: AppColors.gold.withOpacity(0.06),
//               ),
//             ),
//           ),
//
//           // ── Main content ──
//           FadeTransition(
//             opacity: _fadeAnim,
//             child: SlideTransition(
//               position: _slideAnim,
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     const SizedBox(height: 10),
//
//                     // Logo
//                     const Center(child: _LogoWidget(size: 90)),
//
//                     const SizedBox(height: 22),
//
//                     // Heading
//                     const Text(
//                       'Create Account',
//                       style: TextStyle(
//                         fontFamily: 'Cormorant',
//                         fontSize: 34,
//                         fontWeight: FontWeight.w700,
//                         color: AppColors.charcoal,
//                         letterSpacing: 0.4,
//                         height: 1.1,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 6),
//                     const Text(
//                       'Join us and get started today',
//                       style: TextStyle(
//                         fontFamily: 'Cormorant', fontSize: 17,
//                         color: AppColors.grey, letterSpacing: 0.2,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//
//                     const SizedBox(height: 24),
//                     const _GoldDivider(),
//                     const SizedBox(height: 26),
//
//                     // Form
//                     Form(
//                       key: _formKey,
//                       child: Column(
//                         children: [
//                           _GoldInputField(
//                             controller: _nameController,
//                             label: 'Full Name',
//                             hint: 'John Doe',
//                             icon: Icons.person_outline_rounded,
//                             validator: (v) {
//                               if (v == null || v.isEmpty) return 'Name is required';
//                               if (v.length < 2) return 'Minimum 2 characters';
//                               return null;
//                             },
//                           ),
//                           const SizedBox(height: 16),
//                           _GoldInputField(
//                             controller: _emailController,
//                             label: 'Email Address',
//                             hint: 'your@email.com',
//                             icon: Icons.alternate_email_rounded,
//                             keyboardType: TextInputType.emailAddress,
//                             validator: (v) {
//                               if (v == null || v.isEmpty) return 'Email is required';
//                               if (!v.contains('@') || !v.contains('.')) return 'Enter a valid email';
//                               return null;
//                             },
//                           ),
//                           const SizedBox(height: 16),
//                           _GoldInputField(
//                             controller: _passwordController,
//                             label: 'Password',
//                             hint: '••••••••',
//                             icon: Icons.lock_outline_rounded,
//                             obscureText: _obscurePassword,
//                             suffixIcon: IconButton(
//                               icon: Icon(
//                                 _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
//                                 color: AppColors.gold, size: 20,
//                               ),
//                               onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
//                             ),
//                             validator: (v) {
//                               if (v == null || v.isEmpty) return 'Password is required';
//                               if (v.length < 6) return 'Minimum 6 characters';
//                               return null;
//                             },
//                           ),
//                           const SizedBox(height: 16),
//                           _GoldInputField(
//                             controller: _confirmPasswordController,
//                             label: 'Confirm Password',
//                             hint: '••••••••',
//                             icon: Icons.lock_outline_rounded,
//                             obscureText: _obscureConfirmPassword,
//                             suffixIcon: IconButton(
//                               icon: Icon(
//                                 _obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
//                                 color: AppColors.gold, size: 20,
//                               ),
//                               onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
//                             ),
//                             validator: (v) {
//                               if (v == null || v.isEmpty) return 'Please confirm your password';
//                               if (v != _passwordController.text) return 'Passwords do not match';
//                               return null;
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     const SizedBox(height: 30),
//
//                     // Sign Up Button
//                     Consumer<AuthProvider>(
//                       builder: (_, auth, __) => _GoldButton(
//                         label: 'Create Account',
//                         isLoading: auth.isLoading,
//                         onPressed: auth.isLoading ? null : _handleRegister,
//                       ),
//                     ),
//
//                     const SizedBox(height: 24),
//
//                     // Password hint
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                       decoration: BoxDecoration(
//                         color: AppColors.gold.withOpacity(0.06),
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(color: AppColors.gold.withOpacity(0.18), width: 1),
//                       ),
//                       child: Row(
//                         children: [
//                           const Icon(Icons.info_outline_rounded, color: AppColors.gold, size: 16),
//                           const SizedBox(width: 10),
//                           const Expanded(
//                             child: Text(
//                               'Use at least 6 characters with letters and numbers for a strong password.',
//                               style: TextStyle(
//                                 fontFamily: 'Cormorant', fontSize: 13,
//                                 color: AppColors.grey, height: 1.4,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     const SizedBox(height: 28),
//
//                     // Login link
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text('Already have an account?  ',
//                             style: TextStyle(fontFamily: 'Cormorant', fontSize: 16, color: AppColors.grey)),
//                         GestureDetector(
//                           onTap: _goBack,
//                           child: const Text('Sign In',
//                             style: TextStyle(
//                               fontFamily: 'Cormorant', fontSize: 16,
//                               fontWeight: FontWeight.w700, color: AppColors.gold,
//                               letterSpacing: 0.3,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────────────────────
// //  SHARED WIDGETS
// // ─────────────────────────────────────────────────────────────
//
// class _LogoWidget extends StatelessWidget {
//   final double size;
//   const _LogoWidget({this.size = 114});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: size,
//       height: size,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: AppColors.white,
//         border: Border.all(color: AppColors.gold, width: 1.8),
//         boxShadow: [
//           BoxShadow(color: AppColors.gold.withOpacity(0.22), blurRadius: 28, spreadRadius: 2),
//           BoxShadow(color: AppColors.gold.withOpacity(0.08), blurRadius: 8),
//         ],
//       ),
//       child: ClipOval(
//         child: Padding(
//           padding: EdgeInsets.all(size * 0.12),
//           child: Image.asset(
//             'assets/images/logo.png',
//             fit: BoxFit.contain,
//             errorBuilder: (_, __, ___) =>
//                 Icon(Icons.diamond_outlined, color: AppColors.gold, size: size * 0.45),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _GoldDivider extends StatelessWidget {
//   const _GoldDivider();
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: Container(
//             height: 1,
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(colors: [Colors.transparent, AppColors.goldLight]),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Transform.rotate(
//             angle: 0.7854,
//             child: Container(
//               width: 7, height: 7,
//               decoration: BoxDecoration(
//                 color: AppColors.gold,
//                 borderRadius: BorderRadius.circular(1.5),
//                 boxShadow: [BoxShadow(color: AppColors.gold.withOpacity(0.5), blurRadius: 6)],
//               ),
//             ),
//           ),
//         ),
//         Expanded(
//           child: Container(
//             height: 1,
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(colors: [AppColors.goldLight, Colors.transparent]),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _GoldInputField extends StatelessWidget {
//   final TextEditingController controller;
//   final String label;
//   final String hint;
//   final IconData icon;
//   final bool obscureText;
//   final Widget? suffixIcon;
//   final TextInputType? keyboardType;
//   final String? Function(String?)? validator;
//
//   const _GoldInputField({
//     required this.controller,
//     required this.label,
//     required this.hint,
//     required this.icon,
//     this.obscureText = false,
//     this.suffixIcon,
//     this.keyboardType,
//     this.validator,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       obscureText: obscureText,
//       keyboardType: keyboardType,
//       validator: validator,
//       style: const TextStyle(
//         fontFamily: 'Cormorant', fontSize: 16,
//         color: AppColors.charcoal, fontWeight: FontWeight.w600,
//       ),
//       cursorColor: AppColors.gold,
//       decoration: InputDecoration(
//         labelText: label,
//         hintText: hint,
//         labelStyle: const TextStyle(
//             fontFamily: 'Cormorant', fontSize: 14, color: AppColors.grey, letterSpacing: 0.3),
//         hintStyle: TextStyle(
//             fontFamily: 'Cormorant', fontSize: 15, color: AppColors.grey.withOpacity(0.5)),
//         errorStyle: const TextStyle(
//             fontFamily: 'Cormorant', fontSize: 13, color: AppColors.error),
//         prefixIcon: Icon(icon, color: AppColors.gold, size: 20),
//         suffixIcon: suffixIcon,
//         filled: true,
//         fillColor: AppColors.inputFill,
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
//         border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: AppColors.divider, width: 1)),
//         enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: AppColors.divider, width: 1)),
//         focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: AppColors.gold, width: 1.6)),
//         errorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: AppColors.error, width: 1.2)),
//         focusedErrorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: AppColors.error, width: 1.6)),
//       ),
//     );
//   }
// }
//
// class _GoldButton extends StatelessWidget {
//   final String label;
//   final bool isLoading;
//   final VoidCallback? onPressed;
//   const _GoldButton({required this.label, required this.isLoading, this.onPressed});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         height: 56,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(13),
//           gradient: onPressed != null
//               ? const LinearGradient(
//               colors: [AppColors.goldDark, AppColors.gold, AppColors.goldLight],
//               stops: [0.0, 0.5, 1.0])
//               : LinearGradient(colors: [
//             AppColors.gold.withOpacity(0.5),
//             AppColors.goldLight.withOpacity(0.5),
//           ]),
//           boxShadow: onPressed != null
//               ? [
//             BoxShadow(color: AppColors.gold.withOpacity(0.35), blurRadius: 18, offset: const Offset(0, 6)),
//             BoxShadow(color: AppColors.gold.withOpacity(0.15), blurRadius: 6, offset: const Offset(0, 2)),
//           ]
//               : [],
//         ),
//         child: Center(
//           child: isLoading
//               ? const SizedBox(
//               width: 22, height: 22,
//               child: CircularProgressIndicator(
//                 strokeWidth: 2,
//                 valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
//               ))
//               : Text(label,
//               style: const TextStyle(
//                 fontFamily: 'Cormorant', fontSize: 18,
//                 fontWeight: FontWeight.w700, color: AppColors.white,
//                 letterSpacing: 1.5,
//               )),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/app_colors.dart';
import '../core/app_widgets.dart';
import '../providers/auth_provider.dart';
import '../services/home_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  final _formKey                   = GlobalKey<FormState>();
  final _nameController            = TextEditingController();
  final _emailController           = TextEditingController();
  final _passwordController        = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword            = true;
  bool _obscureConfirmPassword     = true;

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
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fadeCtrl.dispose();
    _slideCtrl.dispose();
    super.dispose();
  }

  void _goBack() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    }
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final ok   = await auth.signUp(
      name:     _nameController.text.trim(),
      email:    _emailController.text.trim(),
      password: _passwordController.text,
    );
    if (!mounted) return;
    if (ok) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    } else if (auth.errorMessage != null) {
      AppSnackbar.error(context, auth.errorMessage!);
      auth.clearError();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: _goBack,
          child: Container(
            margin: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: AppColors.gold.withOpacity(0.5), width: 1.2),
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.gold.withOpacity(0.10),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: AppColors.gold, size: 16),
          ),
        ),
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 5,
              decoration: const BoxDecoration(
                  gradient: AppColors.goldAccentBar),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // ── Ornament circles ──
          Positioned(
            top: -60, right: -60,
            child: Container(
              width: 200, height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.gold.withOpacity(0.06),
              ),
            ),
          ),
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
          FadeTransition(
            opacity: _fadeAnim,
            child: SlideTransition(
              position: _slideAnim,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 28, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),

                    const Center(child: AppLogoWidget(size: 90)),

                    const SizedBox(height: 22),

                    const Text(
                      'Create Account',
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
                      'Join us and get started today',
                      style: TextStyle(
                        fontFamily: 'Cormorant',
                        fontSize: 17,
                        color: AppColors.grey,
                        letterSpacing: 0.2,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 24),
                    const AppGoldDivider(),
                    const SizedBox(height: 26),

                    // ── Form ──
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          AppGoldInputField(
                            controller: _nameController,
                            label: 'Full Name',
                            hint: 'John Doe',
                            icon: Icons.person_outline_rounded,
                            validator: (v) {
                              if (v == null || v.isEmpty)
                                return 'Name is required';
                              if (v.length < 2)
                                return 'Minimum 2 characters';
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          AppGoldInputField(
                            controller: _emailController,
                            label: 'Email Address',
                            hint: 'your@email.com',
                            icon: Icons.alternate_email_rounded,
                            keyboardType: TextInputType.emailAddress,
                            validator: (v) {
                              if (v == null || v.isEmpty)
                                return 'Email is required';
                              if (!v.contains('@') || !v.contains('.'))
                                return 'Enter a valid email';
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          AppGoldInputField(
                            controller: _passwordController,
                            label: 'Password',
                            hint: '••••••••',
                            icon: Icons.lock_outline_rounded,
                            obscureText: _obscurePassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: AppColors.gold,
                                size: 20,
                              ),
                              onPressed: () => setState(
                                      () => _obscurePassword = !_obscurePassword),
                            ),
                            validator: (v) {
                              if (v == null || v.isEmpty)
                                return 'Password is required';
                              if (v.length < 6)
                                return 'Minimum 6 characters';
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          AppGoldInputField(
                            controller: _confirmPasswordController,
                            label: 'Confirm Password',
                            hint: '••••••••',
                            icon: Icons.lock_outline_rounded,
                            obscureText: _obscureConfirmPassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: AppColors.gold,
                                size: 20,
                              ),
                              onPressed: () => setState(() =>
                              _obscureConfirmPassword =
                              !_obscureConfirmPassword),
                            ),
                            validator: (v) {
                              if (v == null || v.isEmpty)
                                return 'Please confirm your password';
                              if (v != _passwordController.text)
                                return 'Passwords do not match';
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    Consumer<AuthProvider>(
                      builder: (_, auth, __) => AppGoldButton(
                        label: 'Create Account',
                        isLoading: auth.isLoading,
                        onPressed:
                        auth.isLoading ? null : _handleRegister,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ── Password hint ──
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.gold.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: AppColors.gold.withOpacity(0.18),
                            width: 1),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.info_outline_rounded,
                              color: AppColors.gold, size: 16),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Use at least 6 characters with letters and numbers for a strong password.',
                              style: TextStyle(
                                fontFamily: 'Cormorant',
                                fontSize: 13,
                                color: AppColors.grey,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ── Login link ──
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?  ',
                          style: TextStyle(
                              fontFamily: 'Cormorant',
                              fontSize: 16,
                              color: AppColors.grey),
                        ),
                        GestureDetector(
                          onTap: _goBack,
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              fontFamily: 'Cormorant',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.gold,
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
        ],
      ),
    );
  }
}