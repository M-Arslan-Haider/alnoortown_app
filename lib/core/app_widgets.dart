import 'package:flutter/material.dart';
import 'app_colors.dart';

/// ─────────────────────────────────────────────────────────────
///  APP WIDGETS  –  shared, reusable UI components
///
///  Usage:
///    import '../core/app_widgets.dart';
///
///  Exports:
///    AppGoldButton       – full-width animated gradient CTA button
///    AppOutlineButton    – gold-bordered outline button (e.g. Google Sign-In)
///    AppGoldDivider      – decorative gold diamond divider
///    AppGoldInputField   – styled text-form-field with gold accents
///    AppLogoWidget       – circular logo badge with gold border & glow
///    AppSectionCard      – labelled white card with inner gold divider
///    AppInfoRow          – icon + label + value row (read-only data display)
///    AppSnackbar         – factory helpers for success / error snack bars
/// ─────────────────────────────────────────────────────────────

// ═════════════════════════════════════════════════════════════
//  1.  GOLD BUTTON
// ═════════════════════════════════════════════════════════════

/// Full-width animated gradient button.
///
/// ```dart
/// AppGoldButton(
///   label: 'SIGN IN',
///   isLoading: auth.isLoading,
///   onPressed: auth.isLoading ? null : _handleLogin,
/// )
/// ```
class AppGoldButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final VoidCallback? onPressed;

  const AppGoldButton({
    super.key,
    required this.label,
    required this.isLoading,
    this.onPressed,
  });

  bool get _enabled => onPressed != null && !isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _enabled ? onPressed : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          gradient: _enabled
              ? AppColors.goldGradient
              : LinearGradient(colors: [
            AppColors.gold.withOpacity(0.5),
            AppColors.goldLight.withOpacity(0.5),
          ]),
          boxShadow: _enabled
              ? [
            BoxShadow(
              color: AppColors.gold.withOpacity(0.35),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
            BoxShadow(
              color: AppColors.gold.withOpacity(0.15),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ]
              : const [],
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor:
              AlwaysStoppedAnimation<Color>(AppColors.white),
            ),
          )
              : Text(
            label,
            style: const TextStyle(
              fontFamily: 'Cormorant',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════
//  2.  OUTLINE BUTTON  (e.g. Google Sign-In)
// ═════════════════════════════════════════════════════════════

/// Gold-bordered outline button. Pass any [child] widget (row, text, etc.).
///
/// ```dart
/// AppOutlineButton(
///   onPressed: _handleGoogleSignIn,
///   child: Row(children: [ ... ]),
/// )
/// ```
class AppOutlineButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  const AppOutlineButton({
    super.key,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13)),
        side: const BorderSide(color: AppColors.gold, width: 1.4),
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      child: child,
    );
  }
}

// ═════════════════════════════════════════════════════════════
//  3.  GOLD DIVIDER
// ═════════════════════════════════════════════════════════════

/// Decorative divider: fading gold lines with a rotated diamond centre.
///
/// ```dart
/// const AppGoldDivider()
/// ```
class AppGoldDivider extends StatelessWidget {
  const AppGoldDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.transparent, AppColors.goldLight]),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Transform.rotate(
            angle: 0.7854, // 45°
            child: Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: AppColors.gold,
                borderRadius: BorderRadius.circular(1.5),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.gold.withOpacity(0.5),
                      blurRadius: 6),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [AppColors.goldLight, Colors.transparent]),
            ),
          ),
        ),
      ],
    );
  }
}

// ═════════════════════════════════════════════════════════════
//  4.  GOLD INPUT FIELD
// ═════════════════════════════════════════════════════════════

/// Styled [TextFormField] with gold borders, prefix icon, and
/// Cormorant typography.
///
/// ```dart
/// AppGoldInputField(
///   controller: _emailController,
///   label: 'Email Address',
///   hint: 'you@example.com',
///   icon: Icons.alternate_email_rounded,
///   keyboardType: TextInputType.emailAddress,
///   validator: (v) => v!.isEmpty ? 'Required' : null,
/// )
/// ```
class AppGoldInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool enabled;
  final int? maxLines;

  const AppGoldInputField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
    this.enabled = true,
    this.maxLines = 1,
  });

  static OutlineInputBorder _border(Color color, {double width = 1}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: color, width: width),
      );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      enabled: enabled,
      maxLines: maxLines,
      style: const TextStyle(
        fontFamily: 'Cormorant',
        fontSize: 16,
        color: AppColors.charcoal,
        fontWeight: FontWeight.w600,
      ),
      cursorColor: AppColors.gold,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(
          fontFamily: 'Cormorant',
          fontSize: 14,
          color: AppColors.grey,
          letterSpacing: 0.3,
        ),
        hintStyle: TextStyle(
          fontFamily: 'Cormorant',
          fontSize: 15,
          color: AppColors.grey.withOpacity(0.5),
        ),
        errorStyle: const TextStyle(
          fontFamily: 'Cormorant',
          fontSize: 13,
          color: AppColors.error,
        ),
        prefixIcon: Icon(icon, color: AppColors.gold, size: 20),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppColors.inputFill,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        border: _border(AppColors.divider),
        enabledBorder: _border(AppColors.divider),
        focusedBorder: _border(AppColors.gold, width: 1.6),
        errorBorder: _border(AppColors.error, width: 1.2),
        focusedErrorBorder: _border(AppColors.error, width: 1.6),
        disabledBorder: _border(AppColors.divider),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════
//  5.  LOGO WIDGET
// ═════════════════════════════════════════════════════════════

/// Circular logo badge with gold border, glow shadow and fallback icon.
///
/// ```dart
/// const AppLogoWidget()          // default 114 px
/// AppLogoWidget(size: 90)        // custom size
/// ```
class AppLogoWidget extends StatelessWidget {
  final double size;

  const AppLogoWidget({super.key, this.size = 114});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white,
        border: Border.all(color: AppColors.gold, width: 1.8),
        boxShadow: [
          BoxShadow(
            color: AppColors.gold.withOpacity(0.22),
            blurRadius: 28,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: AppColors.gold.withOpacity(0.08),
            blurRadius: 8,
          ),
        ],
      ),
      child: ClipOval(
        child: Padding(
          padding: EdgeInsets.all(size * 0.12),
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => Icon(
              Icons.diamond_outlined,
              color: AppColors.gold,
              size: size * 0.45,
            ),
          ),
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════
//  6.  SECTION CARD
// ═════════════════════════════════════════════════════════════

/// White rounded card with an uppercase section label and gold divider.
///
/// ```dart
/// AppSectionCard(
///   title: 'PERSONAL INFORMATION',
///   child: Column(children: [ ... ]),
/// )
/// ```
class AppSectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const AppSectionCard({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Cormorant',
              fontSize: 11,
              color: AppColors.grey,
              letterSpacing: 2.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          const AppGoldDivider(),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════
//  7.  INFO ROW  (read-only display)
// ═════════════════════════════════════════════════════════════

/// Icon + label + value display row. Turns red when [isMissing] is true.
///
/// ```dart
/// AppInfoRow(
///   icon: Icons.phone_outlined,
///   label: 'Phone',
///   value: _phoneNumber,
///   isMissing: _phoneNumber.isEmpty,
/// )
/// ```
class AppInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isMissing;

  const AppInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.isMissing = false,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isMissing ? AppColors.error : AppColors.charcoal;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isMissing
            ? AppColors.error.withOpacity(0.05)
            : AppColors.inputFill,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isMissing
              ? AppColors.error.withOpacity(0.3)
              : AppColors.divider,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: isMissing ? AppColors.error : AppColors.gold,
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Cormorant',
                fontSize: 12,
                color: isMissing ? AppColors.error : AppColors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? 'Missing — update profile' : value,
              style: TextStyle(
                fontFamily: 'Cormorant',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (isMissing)
            const Icon(
              Icons.warning_amber_rounded,
              size: 14,
              color: AppColors.error,
            ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════
//  8.  SNACKBAR HELPERS
// ═════════════════════════════════════════════════════════════

/// Factory helpers for consistent snack-bar styling across the app.
///
/// ```dart
/// AppSnackbar.success(context, 'Profile saved!');
/// AppSnackbar.error(context, 'Something went wrong.');
/// ```
abstract class AppSnackbar {
  static void show(
      BuildContext context,
      String message, {
        required Color backgroundColor,
      }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontFamily: 'Cormorant',
            fontSize: 14,
            color: AppColors.white,
          ),
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  static void success(BuildContext context, String message) =>
      show(context, message, backgroundColor: AppColors.success);

  static void error(BuildContext context, String message) =>
      show(context, message, backgroundColor: AppColors.error);
}

// ═════════════════════════════════════════════════════════════
//  9.  GOLD APP BAR  (convenience PreferredSizeWidget)
// ═════════════════════════════════════════════════════════════

/// Gold-gradient app bar with an optional bottom divider line.
///
/// ```dart
/// GoldAppBar(title: 'MY PROFILE')
/// GoldAppBar(title: 'SUBMIT COMPLAINT', whiteStyle: true)
/// ```
class GoldAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  /// [whiteStyle] – white background with charcoal title (detail screens).
  /// Default is the gold gradient (used on Home / main screens).
  final bool whiteStyle;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;

  const GoldAppBar({
    super.key,
    required this.title,
    this.whiteStyle = false,
    this.actions,
    this.automaticallyImplyLeading = true,
  });

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + 1 /* divider */);

  @override
  Widget build(BuildContext context) {
    if (whiteStyle) {
      return AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: automaticallyImplyLeading,
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Cormorant',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.charcoal,
            letterSpacing: 3,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.gold),
        actions: actions,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: AppColors.divider),
        ),
      );
    }

    // Gold gradient style
    return AppBar(
      flexibleSpace: Container(
        decoration:
        const BoxDecoration(gradient: AppColors.appBarGradient),
      ),
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Cormorant',
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.white,
          letterSpacing: 1,
        ),
      ),
      iconTheme: const IconThemeData(color: AppColors.white),
      actions: actions,
    );
  }
}