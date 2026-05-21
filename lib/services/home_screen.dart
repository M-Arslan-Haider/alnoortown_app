// //
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import '../providers/auth_provider.dart';
// // import '../screens/ComplaintScreen.dart';
// // import '../screens/profile_screen.dart';
// // import '../screens/login_screen.dart';
// //
// // class HomeScreen extends StatelessWidget {
// //   const HomeScreen({super.key});
// //
// //   Future<void> _handleSignOut(BuildContext context) async {
// //     final authProvider = Provider.of<AuthProvider>(context, listen: false);
// //     await authProvider.signOut();
// //     if (context.mounted) {
// //       Navigator.pushReplacement(
// //         context,
// //         MaterialPageRoute(builder: (_) => const LoginScreen()),
// //       );
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final authProvider = Provider.of<AuthProvider>(context);
// //     final userName  = authProvider.getUserName();
// //     final userEmail = authProvider.getUserEmail();
// //
// //     return Scaffold(
// //       backgroundColor: AppColors.offWhite,
// //       appBar: AppBar(
// //         flexibleSpace: Container(
// //           decoration: const BoxDecoration(
// //             gradient: LinearGradient(
// //               colors: [AppColors.goldDark, AppColors.gold],
// //               begin: Alignment.topLeft,
// //               end: Alignment.bottomRight,
// //             ),
// //           ),
// //         ),
// //         elevation: 0,
// //         centerTitle: true,
// //         title: const Text(
// //           'AL NOOR TOWN',
// //           style: TextStyle(
// //             fontFamily: 'Cormorant',
// //             fontSize: 20,
// //             fontWeight: FontWeight.w700,
// //             color: AppColors.white,
// //             letterSpacing: 1,
// //           ),
// //         ),
// //         iconTheme: const IconThemeData(color: AppColors.white),
// //       ),
// //       drawer: _buildDrawer(context, userName, userEmail),
// //       body: Padding(
// //         padding: const EdgeInsets.fromLTRB(24, 36, 24, 24),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             // Greeting
// //             Text(
// //               'Welcome back,',
// //               style: TextStyle(
// //                 fontFamily: 'Cormorant',
// //                 fontSize: 15,
// //                 color: AppColors.grey,
// //                 letterSpacing: 0.5,
// //               ),
// //             ),
// //             const SizedBox(height: 4),
// //             Text(
// //               userName,
// //               style: const TextStyle(
// //                 fontFamily: 'Cormorant',
// //                 fontSize: 28,
// //                 fontWeight: FontWeight.w700,
// //                 color: AppColors.charcoal,
// //               ),
// //             ),
// //
// //             const SizedBox(height: 40),
// //
// //             // Action Cards
// //             _ActionTile(
// //               icon: Icons.person_outline,
// //               label: 'My Profile',
// //               subtitle: 'View and edit your information',
// //               onTap: () => Navigator.push(
// //                 context,
// //                 MaterialPageRoute(builder: (_) => const ProfileScreen()),
// //               ),
// //             ),
// //             const SizedBox(height: 14),
// //             _ActionTile(
// //               icon: Icons.report_problem_outlined,
// //               label: 'Submit Complaint',
// //               subtitle: 'Report an issue to management',
// //               onTap: () => Navigator.push(
// //                 context,
// //                 MaterialPageRoute(builder: (_) => const ComplaintScreen()),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildDrawer(BuildContext context, String userName, String userEmail) {
// //     return Drawer(
// //       backgroundColor: AppColors.white,
// //       child: Column(
// //         children: [
// //           Container(
// //             width: double.infinity,
// //             padding: const EdgeInsets.fromLTRB(24, 56, 24, 28),
// //             decoration: const BoxDecoration(
// //               gradient: LinearGradient(
// //                 colors: [AppColors.goldDark, AppColors.gold],
// //                 begin: Alignment.topLeft,
// //                 end: Alignment.bottomRight,
// //               ),
// //             ),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Container(
// //                   width: 56,
// //                   height: 56,
// //                   decoration: BoxDecoration(
// //                     shape: BoxShape.circle,
// //                     color: AppColors.white.withOpacity(0.2),
// //                     border: Border.all(color: AppColors.white, width: 1.5),
// //                   ),
// //                   child: const Icon(Icons.person, size: 30, color: AppColors.white),
// //                 ),
// //                 const SizedBox(height: 14),
// //                 Text(
// //                   userName,
// //                   style: const TextStyle(
// //                     fontFamily: 'Cormorant',
// //                     color: AppColors.white,
// //                     fontSize: 20,
// //                     fontWeight: FontWeight.w700,
// //                   ),
// //                 ),
// //                 const SizedBox(height: 3),
// //                 Text(
// //                   userEmail,
// //                   style: TextStyle(
// //                     fontFamily: 'Cormorant',
// //                     color: AppColors.white.withOpacity(0.85),
// //                     fontSize: 13,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //
// //           const SizedBox(height: 8),
// //
// //           _DrawerItem(icon: Icons.home_outlined,           label: 'Dashboard',        onTap: () => Navigator.pop(context)),
// //           _DrawerItem(
// //             icon: Icons.person_outline,
// //             label: 'My Profile',
// //             onTap: () {
// //               Navigator.pop(context);
// //               Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
// //             },
// //           ),
// //           _DrawerItem(
// //             icon: Icons.report_problem_outlined,
// //             label: 'Submit Complaint',
// //             onTap: () {
// //               Navigator.pop(context);
// //               Navigator.push(context, MaterialPageRoute(builder: (_) => const ComplaintScreen()));
// //             },
// //           ),
// //
// //           const Spacer(),
// //
// //           Padding(
// //             padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
// //             child: GestureDetector(
// //               onTap: () => _handleSignOut(context),
// //               child: Container(
// //                 height: 50,
// //                 decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(12),
// //                   border: Border.all(color: AppColors.error, width: 1.2),
// //                 ),
// //                 child: const Row(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     Icon(Icons.logout, color: AppColors.error, size: 18),
// //                     SizedBox(width: 8),
// //                     Text(
// //                       'Sign Out',
// //                       style: TextStyle(
// //                         fontFamily: 'Cormorant',
// //                         fontSize: 16,
// //                         fontWeight: FontWeight.w700,
// //                         color: AppColors.error,
// //                         letterSpacing: 0.5,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ),
// //           const Padding(
// //             padding: EdgeInsets.only(bottom: 12),
// //             child: Text(
// //               'Version 1.0.0',
// //               style: TextStyle(
// //                 fontFamily: 'Cormorant',
// //                 fontSize: 12,
// //                 color: AppColors.grey,
// //                 letterSpacing: 0.5,
// //               ),
// //               textAlign: TextAlign.center,
// //             ),
// //           ),
// //
// //           // ← ADD THIS
// //           const Padding(
// //             padding: EdgeInsets.only(bottom: 20),
// //             child: Text(
// //               'Powered by MetaXperts',
// //               style: TextStyle(
// //                 fontFamily: 'Cormorant',
// //                 fontSize: 12,
// //                 color: AppColors.grey,
// //                 letterSpacing: 0.5,
// //                 fontStyle: FontStyle.italic,
// //               ),
// //               textAlign: TextAlign.center,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// // // ── Action Tile ────────────────────────────────────────────────
// // class _ActionTile extends StatelessWidget {
// //   final IconData icon;
// //   final String label;
// //   final String subtitle;
// //   final VoidCallback onTap;
// //
// //   const _ActionTile({
// //     required this.icon,
// //     required this.label,
// //     required this.subtitle,
// //     required this.onTap,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Container(
// //         padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
// //         decoration: BoxDecoration(
// //           color: AppColors.white,
// //           borderRadius: BorderRadius.circular(14),
// //           border: Border.all(color: AppColors.divider),
// //         ),
// //         child: Row(
// //           children: [
// //             Container(
// //               width: 44,
// //               height: 44,
// //               decoration: BoxDecoration(
// //                 color: AppColors.gold.withOpacity(0.08),
// //                 borderRadius: BorderRadius.circular(10),
// //               ),
// //               child: Icon(icon, color: AppColors.gold, size: 22),
// //             ),
// //             const SizedBox(width: 16),
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     label,
// //                     style: const TextStyle(
// //                       fontFamily: 'Cormorant',
// //                       fontSize: 16,
// //                       fontWeight: FontWeight.w700,
// //                       color: AppColors.charcoal,
// //                     ),
// //                   ),
// //                   const SizedBox(height: 2),
// //                   Text(
// //                     subtitle,
// //                     style: const TextStyle(
// //                       fontFamily: 'Cormorant',
// //                       fontSize: 13,
// //                       color: AppColors.grey,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             const Icon(Icons.arrow_forward_ios, size: 13, color: AppColors.greyLight),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // // ── Drawer Item ────────────────────────────────────────────────
// // class _DrawerItem extends StatelessWidget {
// //   final IconData icon;
// //   final String label;
// //   final VoidCallback onTap;
// //
// //   const _DrawerItem({required this.icon, required this.label, required this.onTap});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return ListTile(
// //       contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
// //       leading: Icon(icon, color: AppColors.gold, size: 22),
// //       title: Text(
// //         label,
// //         style: const TextStyle(
// //           fontFamily: 'Cormorant',
// //           fontSize: 16,
// //           fontWeight: FontWeight.w600,
// //           color: AppColors.charcoal,
// //         ),
// //       ),
// //       trailing: const Icon(Icons.arrow_forward_ios, size: 13, color: AppColors.greyLight),
// //       onTap: onTap,
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../core/app_colors.dart';
// import '../core/app_widgets.dart';
// import '../providers/auth_provider.dart';
// import '../screens/ComplaintScreen.dart';
// import '../screens/profile_screen.dart';
// import '../screens/login_screen.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   Future<void> _handleSignOut(BuildContext context) async {
//     final authProvider =
//     Provider.of<AuthProvider>(context, listen: false);
//     await authProvider.signOut();
//     if (context.mounted) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const LoginScreen()),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context);
//     final userName     = authProvider.getUserName();
//     final userEmail    = authProvider.getUserEmail();
//
//     return Scaffold(
//       backgroundColor: AppColors.offWhite,
//       appBar: GoldAppBar(title: 'AL NOOR TOWN'),
//       drawer: _AppDrawer(
//         userName:  userName,
//         userEmail: userEmail,
//         onSignOut: () => _handleSignOut(context),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.fromLTRB(24, 36, 24, 24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ── Greeting ──
//             Text(
//               'Welcome back,',
//               style: TextStyle(
//                 fontFamily: 'Cormorant',
//                 fontSize: 15,
//                 color: AppColors.grey,
//                 letterSpacing: 0.5,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               userName,
//               style: const TextStyle(
//                 fontFamily: 'Cormorant',
//                 fontSize: 28,
//                 fontWeight: FontWeight.w700,
//                 color: AppColors.charcoal,
//               ),
//             ),
//
//             const SizedBox(height: 40),
//
//             // ── Action tiles ──
//             _ActionTile(
//               icon: Icons.person_outline,
//               label: 'My Profile',
//               subtitle: 'View and edit your information',
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (_) => const ProfileScreen()),
//               ),
//             ),
//             const SizedBox(height: 14),
//             _ActionTile(
//               icon: Icons.report_problem_outlined,
//               label: 'Submit Complaint',
//               subtitle: 'Report an issue to management',
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (_) => const ComplaintScreen()),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // ═════════════════════════════════════════════════════════════
// //  DRAWER
// // ═════════════════════════════════════════════════════════════
// class _AppDrawer extends StatelessWidget {
//   final String userName;
//   final String userEmail;
//   final VoidCallback onSignOut;
//
//   const _AppDrawer({
//     required this.userName,
//     required this.userEmail,
//     required this.onSignOut,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: AppColors.white,
//       child: Column(
//         children: [
//           // ── Header ──
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.fromLTRB(24, 56, 24, 28),
//             decoration: const BoxDecoration(
//                 gradient: AppColors.appBarGradient),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   width: 56, height: 56,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: AppColors.white.withOpacity(0.2),
//                     border: Border.all(
//                         color: AppColors.white, width: 1.5),
//                   ),
//                   child: const Icon(Icons.person,
//                       size: 30, color: AppColors.white),
//                 ),
//                 const SizedBox(height: 14),
//                 Text(
//                   userName,
//                   style: const TextStyle(
//                     fontFamily: 'Cormorant',
//                     color: AppColors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 const SizedBox(height: 3),
//                 Text(
//                   userEmail,
//                   style: TextStyle(
//                     fontFamily: 'Cormorant',
//                     color: AppColors.white.withOpacity(0.85),
//                     fontSize: 13,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           const SizedBox(height: 8),
//
//           _DrawerItem(
//             icon: Icons.home_outlined,
//             label: 'Dashboard',
//             onTap: () => Navigator.pop(context),
//           ),
//           _DrawerItem(
//             icon: Icons.person_outline,
//             label: 'My Profile',
//             onTap: () {
//               Navigator.pop(context);
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (_) => const ProfileScreen()));
//             },
//           ),
//           _DrawerItem(
//             icon: Icons.report_problem_outlined,
//             label: 'Submit Complaint',
//             onTap: () {
//               Navigator.pop(context);
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (_) => const ComplaintScreen()));
//             },
//           ),
//
//           const Spacer(),
//
//           // ── Sign Out ──
//           Padding(
//             padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
//             child: GestureDetector(
//               onTap: onSignOut,
//               child: Container(
//                 height: 50,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(
//                       color: AppColors.error, width: 1.2),
//                 ),
//                 child: const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.logout,
//                         color: AppColors.error, size: 18),
//                     SizedBox(width: 8),
//                     Text(
//                       'Sign Out',
//                       style: TextStyle(
//                         fontFamily: 'Cormorant',
//                         fontSize: 16,
//                         fontWeight: FontWeight.w700,
//                         color: AppColors.error,
//                         letterSpacing: 0.5,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//           const Padding(
//             padding: EdgeInsets.only(bottom: 8),
//             child: Text(
//               'Version 1.0.0',
//               style: TextStyle(
//                 fontFamily: 'Cormorant',
//                 fontSize: 12,
//                 color: AppColors.grey,
//                 letterSpacing: 0.5,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           const Padding(
//             padding: EdgeInsets.only(bottom: 20),
//             child: Text(
//               'Powered by MetaXperts',
//               style: TextStyle(
//                 fontFamily: 'Cormorant',
//                 fontSize: 12,
//                 color: AppColors.grey,
//                 letterSpacing: 0.5,
//                 fontStyle: FontStyle.italic,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ═════════════════════════════════════════════════════════════
// //  ACTION TILE
// // ═════════════════════════════════════════════════════════════
// class _ActionTile extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final String subtitle;
//   final VoidCallback onTap;
//
//   const _ActionTile({
//     required this.icon,
//     required this.label,
//     required this.subtitle,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(
//             horizontal: 18, vertical: 18),
//         decoration: BoxDecoration(
//           color: AppColors.white,
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(color: AppColors.divider),
//         ),
//         child: Row(
//           children: [
//             Container(
//               width: 44, height: 44,
//               decoration: BoxDecoration(
//                 color: AppColors.gold.withOpacity(0.08),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Icon(icon, color: AppColors.gold, size: 22),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     label,
//                     style: const TextStyle(
//                       fontFamily: 'Cormorant',
//                       fontSize: 16,
//                       fontWeight: FontWeight.w700,
//                       color: AppColors.charcoal,
//                     ),
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     subtitle,
//                     style: const TextStyle(
//                       fontFamily: 'Cormorant',
//                       fontSize: 13,
//                       color: AppColors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Icon(Icons.arrow_forward_ios,
//                 size: 13, color: AppColors.greyLight),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // ═════════════════════════════════════════════════════════════
// //  DRAWER ITEM
// // ═════════════════════════════════════════════════════════════
// class _DrawerItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final VoidCallback onTap;
//
//   const _DrawerItem({
//     required this.icon,
//     required this.label,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       contentPadding:
//       const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
//       leading: Icon(icon, color: AppColors.gold, size: 22),
//       title: Text(
//         label,
//         style: const TextStyle(
//           fontFamily: 'Cormorant',
//           fontSize: 16,
//           fontWeight: FontWeight.w600,
//           color: AppColors.charcoal,
//         ),
//       ),
//       trailing: const Icon(Icons.arrow_forward_ios,
//           size: 13, color: AppColors.greyLight),
//       onTap: onTap,
//     );
//   }
// }


///new design my complaint
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/app_colors.dart';
import '../core/app_widgets.dart';
import '../providers/auth_provider.dart';
import '../screens/ComplaintScreen.dart';
import '../screens/my_complaints_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _handleSignOut(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.signOut();
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userName = authProvider.getUserName();
    final userEmail = authProvider.getUserEmail();

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: GoldAppBar(title: 'AL NOOR TOWN'),
      drawer: _AppDrawer(
        userName: userName,
        userEmail: userEmail,
        onSignOut: () => _handleSignOut(context),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Greeting ──
            Text(
              _greeting(),
              style: TextStyle(
                fontFamily: 'Cormorant',
                fontSize: 15,
                color: AppColors.grey,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 3),
            const Text(
              'How can we help today?',
              style: TextStyle(
                fontFamily: 'Cormorant',
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: AppColors.charcoal,
              ),
            ),

            const SizedBox(height: 15),
            // ── Two large cards ──
            Row(
              children: [
                Expanded(
                  child: _BigCard(
                    label: 'New Complaint',
                    icon: Icons.edit_note_outlined,
                    backgroundColor: AppColors.gold,
                    iconColor: AppColors.white,
                    labelColor: AppColors.white,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ComplaintScreen()),
                    ),
                  ),
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: _BigCard(
                    label: 'My Complaints',
                    icon: Icons.list_alt_outlined,
                    backgroundColor: AppColors.charcoal,
                    iconColor: AppColors.white,
                    labelColor: AppColors.white,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const MyComplaintsScreen()),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════
//  BIG CARD
// ═══════════════════════════════════════
class _BigCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final Color labelColor;
  final VoidCallback onTap;

  const _BigCard({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.labelColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,// ← fixed height, tweak to taste
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: iconColor, size: 26),
            const SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Cormorant',
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: labelColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════
//  DRAWER  (same as before, profile kept here)
// ═══════════════════════════════════════
class _AppDrawer extends StatelessWidget {
  final String userName;
  final String userEmail;
  final VoidCallback onSignOut;

  const _AppDrawer({
    required this.userName,
    required this.userEmail,
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.white,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 56, 24, 28),
            decoration: const BoxDecoration(gradient: AppColors.appBarGradient),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white.withOpacity(0.2),
                    border: Border.all(color: AppColors.white, width: 1.5),
                  ),
                  child: const Icon(Icons.person, size: 30, color: AppColors.white),
                ),
                const SizedBox(height: 14),
                Text(userName,
                    style: const TextStyle(
                        fontFamily: 'Cormorant',
                        color: AppColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 3),
                Text(userEmail,
                    style: TextStyle(
                        fontFamily: 'Cormorant',
                        color: AppColors.white.withOpacity(0.85),
                        fontSize: 13)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          _DrawerItem(
            icon: Icons.home_outlined,
            label: 'Dashboard',
            onTap: () => Navigator.pop(context),
          ),
          _DrawerItem(
            icon: Icons.person_outline,
            label: 'My Profile',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen()));
            },
          ),
          _DrawerItem(
            icon: Icons.edit_note_outlined,
            label: 'New Complaint',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const ComplaintScreen()));
            },
          ),
          _DrawerItem(
            icon: Icons.list_alt_outlined,
            label: 'My Complaints',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const MyComplaintsScreen()));
            },
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
            child: GestureDetector(
              onTap: onSignOut,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.error, width: 1.2),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: AppColors.error, size: 18),
                    SizedBox(width: 8),
                    Text('Sign Out',
                        style: TextStyle(
                            fontFamily: 'Cormorant',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.error,
                            letterSpacing: 0.5)),
                  ],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text('Version 1.0.0',
                style: TextStyle(
                    fontFamily: 'Cormorant',
                    fontSize: 12,
                    color: AppColors.grey,
                    letterSpacing: 0.5),
                textAlign: TextAlign.center),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text('Powered by MetaXperts',
                style: TextStyle(
                    fontFamily: 'Cormorant',
                    fontSize: 12,
                    color: AppColors.grey,
                    letterSpacing: 0.5,
                    fontStyle: FontStyle.italic),
                textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DrawerItem({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
      leading: Icon(icon, color: AppColors.gold, size: 22),
      title: Text(label,
          style: const TextStyle(
              fontFamily: 'Cormorant',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.charcoal)),
      trailing:
      const Icon(Icons.arrow_forward_ios, size: 13, color: AppColors.greyLight),
      onTap: onTap,
    );
  }
}