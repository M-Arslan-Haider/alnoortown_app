// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/auth_provider.dart';
// import 'login_screen.dart';
//
// class ForgotPasswordScreen extends StatefulWidget {
//   const ForgotPasswordScreen({super.key});
//
//   @override
//   State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
// }
//
// class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   bool _emailSent = false;
//
//   @override
//   void dispose() {
//     _emailController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _handleResetPassword() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     final success = await authProvider.sendPasswordResetEmail(
//       _emailController.text.trim(),
//     );
//
//     if (success && mounted) {
//       setState(() {
//         _emailSent = true;
//       });
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
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Reset Password'),
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         elevation: 2,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const SizedBox(height: 40),
//
//               // Icon
//               Icon(
//                 Icons.lock_reset,
//                 size: 100,
//                 color: Theme.of(context).primaryColor,
//               ),
//               const SizedBox(height: 24),
//
//               // Title
//               Text(
//                 _emailSent ? 'Check Your Email' : 'Forgot Password?',
//                 style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 12),
//
//               // Description
//               Text(
//                 _emailSent
//                     ? 'We have sent a password reset link to your email address. Please check your inbox and follow the instructions.'
//                     : 'Enter your email address and we\'ll send you a link to reset your password.',
//                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                   color: Colors.grey[600],
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 40),
//
//               if (!_emailSent) ...[
//                 // Email Field
//                 Form(
//                   key: _formKey,
//                   child: TextFormField(
//                     controller: _emailController,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: InputDecoration(
//                       labelText: 'Email Address',
//                       hintText: 'Enter your registered email',
//                       prefixIcon: const Icon(Icons.email_outlined),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       filled: true,
//                       fillColor: Colors.grey[50],
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your email';
//                       }
//                       if (!value.contains('@') || !value.contains('.')) {
//                         return 'Please enter a valid email';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 32),
//
//                 // Send Reset Link Button
//                 Consumer<AuthProvider>(
//                   builder: (context, authProvider, child) {
//                     return ElevatedButton(
//                       onPressed: authProvider.isLoading ? null : _handleResetPassword,
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: authProvider.isLoading
//                           ? const SizedBox(
//                         height: 20,
//                         width: 20,
//                         child: CircularProgressIndicator(
//                           strokeWidth: 2,
//                           valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                         ),
//                       )
//                           : const Text(
//                         'Send Reset Link',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//
//               if (_emailSent) ...[
//                 // Success message with icon
//                 Container(
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Colors.green[50],
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(color: Colors.green[200]!),
//                   ),
//                   child: Column(
//                     children: [
//                       const Icon(
//                         Icons.check_circle,
//                         color: Colors.green,
//                         size: 60,
//                       ),
//                       const SizedBox(height: 16),
//                       Text(
//                         'Reset link sent to:',
//                         style: TextStyle(color: Colors.grey[600]),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         _emailController.text,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//
//                 // Return to Login Button
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (context) => const LoginScreen()),
//                     );
//                   },
//                   icon: const Icon(Icons.arrow_back),
//                   label: const Text('Back to Login'),
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     backgroundColor: Colors.grey[300],
//                     foregroundColor: Colors.black87,
//                   ),
//                 ),
//               ],
//
//               const SizedBox(height: 16),
//
//               // Back to Login Link (only when not email sent)
//               if (!_emailSent)
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Text('Back to Login'),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// screens/forget_password.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'login_screen.dart'; // for AppColors

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with TickerProviderStateMixin {
  final _formKey        = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _emailSent       = false;

  late final AnimationController _fadeCtrl;
  late final Animation<double>   _fadeAnim;
  late final AnimationController _slideCtrl;
  late final Animation<Offset>   _slideAnim;

  @override
  void initState() {
    super.initState();
    _fadeCtrl  = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _fadeAnim  = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _slideCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.07), end: Offset.zero)
        .animate(CurvedAnimation(parent: _slideCtrl, curve: Curves.easeOut));
    _fadeCtrl.forward();
    _slideCtrl.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _fadeCtrl.dispose();
    _slideCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleResetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    final auth    = Provider.of<AuthProvider>(context, listen: false);
    final success = await auth.sendPasswordResetEmail(_emailController.text.trim());

    if (success && mounted) {
      setState(() => _emailSent = true);
    } else if (mounted && auth.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          auth.errorMessage!,
          style: const TextStyle(fontFamily: 'Cormorant', fontSize: 14, color: AppColors.white),
        ),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ));
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
        centerTitle: true,
        title: const Text(
          'RESET PASSWORD',
          style: TextStyle(
            fontFamily: 'Cormorant', fontSize: 18, fontWeight: FontWeight.w700,
            color: AppColors.charcoal, letterSpacing: 3,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.gold),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: AppColors.divider),
        ),
      ),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: SlideTransition(
            position: _slideAnim,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(28, 40, 28, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  // ── Icon ──
                  Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.offWhite,
                        border: Border.all(color: AppColors.gold, width: 1.5),
                        boxShadow: [
                          BoxShadow(color: AppColors.gold.withOpacity(0.18), blurRadius: 28, spreadRadius: 2),
                        ],
                      ),
                      child: Icon(
                        _emailSent ? Icons.mark_email_read_outlined : Icons.lock_reset_outlined,
                        size: 46,
                        color: AppColors.gold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),
                  const Center(child: _GoldDivider()),
                  const SizedBox(height: 24),

                  // ── Title ──
                  Text(
                    _emailSent ? 'Check Your Email' : 'Forgot Password?',
                    style: const TextStyle(
                      fontFamily: 'Cormorant', fontSize: 28, fontWeight: FontWeight.w700,
                      color: AppColors.charcoal, letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _emailSent
                        ? 'A password reset link has been sent to your email address. Please check your inbox and follow the instructions.'
                        : 'Enter your registered email address and we\'ll send you a secure link to reset your password.',
                    style: const TextStyle(
                      fontFamily: 'Cormorant', fontSize: 15,
                      color: AppColors.grey, height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 36),

                  // ── Form or Success ──
                  if (!_emailSent) ...[
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(
                          fontFamily: 'Cormorant', fontSize: 16,
                          color: AppColors.charcoal, fontWeight: FontWeight.w600,
                        ),
                        cursorColor: AppColors.gold,
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          hintText: 'Enter your registered email',
                          labelStyle: const TextStyle(fontFamily: 'Cormorant', fontSize: 14, color: AppColors.grey),
                          hintStyle: TextStyle(fontFamily: 'Cormorant', fontSize: 15, color: AppColors.grey.withOpacity(0.5)),
                          errorStyle: const TextStyle(fontFamily: 'Cormorant', fontSize: 13, color: AppColors.error),
                          prefixIcon: const Icon(Icons.email_outlined, color: AppColors.gold, size: 20),
                          filled: true,
                          fillColor: AppColors.inputFill,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppColors.divider),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppColors.divider),
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
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Please enter your email';
                          if (!v.contains('@') || !v.contains('.')) return 'Please enter a valid email';
                          return null;
                        },
                      ),
                    ),

                    const SizedBox(height: 32),

                    Consumer<AuthProvider>(
                      builder: (context, auth, _) => _GoldButton(
                        label: 'SEND RESET LINK',
                        isLoading: auth.isLoading,
                        onPressed: auth.isLoading ? null : _handleResetPassword,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Center(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'Back to Login',
                          style: TextStyle(
                            fontFamily: 'Cormorant', fontSize: 15,
                            color: AppColors.gold, fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],

                  if (_emailSent) ...[
                    // ── Success Card ──
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4FAF6),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFF9ACBA9)),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 64, height: 64,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF2E7D4F).withOpacity(0.12),
                            ),
                            child: const Icon(Icons.check_circle_outline, color: Color(0xFF2E7D4F), size: 36),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Reset link sent to',
                            style: TextStyle(fontFamily: 'Cormorant', fontSize: 14, color: AppColors.grey),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            _emailController.text,
                            style: const TextStyle(
                              fontFamily: 'Cormorant', fontSize: 16,
                              fontWeight: FontWeight.w700, color: AppColors.charcoal,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    _GoldButton(
                      label: 'BACK TO LOGIN',
                      isLoading: false,
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                        );
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Gold Button ────────────────────────────────────────────────
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
              : LinearGradient(colors: [AppColors.gold.withOpacity(0.5), AppColors.goldLight.withOpacity(0.5)]),
          boxShadow: onPressed != null
              ? [BoxShadow(color: AppColors.gold.withOpacity(0.35), blurRadius: 18, offset: const Offset(0, 6))]
              : [],
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
            width: 22, height: 22,
            child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(AppColors.white)),
          )
              : Text(
            label,
            style: const TextStyle(
              fontFamily: 'Cormorant', fontSize: 18,
              fontWeight: FontWeight.w700, color: AppColors.white, letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Gold Divider ───────────────────────────────────────────────
class _GoldDivider extends StatelessWidget {
  const _GoldDivider();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container(height: 1, decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent, AppColors.goldLight])))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Transform.rotate(
            angle: 0.7854,
            child: Container(width: 6, height: 6, decoration: BoxDecoration(color: AppColors.gold, borderRadius: BorderRadius.circular(1.5))),
          ),
        ),
        Expanded(child: Container(height: 1, decoration: const BoxDecoration(gradient: LinearGradient(colors: [AppColors.goldLight, Colors.transparent])))),
      ],
    );
  }
}