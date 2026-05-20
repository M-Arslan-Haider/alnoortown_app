// // lib/widgets/update_checker_widget.dart
// import 'package:flutter/material.dart';
// import 'package:in_app_update/in_app_update.dart';
// import '../services/in_app_update_service.dart';
//
// // Define AppColors if not already defined in a separate file
// // If you have AppColors defined elsewhere, remove this section
// class AppColors {
//   static const Color gold = Color(0xFFC9A84C);
//   static const Color goldDark = Color(0xFFA8882E);
//   static const Color offWhite = Color(0xFFF8F6F0);
//   static const Color white = Color(0xFFFFFFFF);
//   static const Color charcoal = Color(0xFF333333);
//   static const Color grey = Color(0xFF888888);
//   static const Color greyLight = Color(0xFFCCCCCC);
//   static const Color divider = Color(0xFFEEEEEE);
//   static const Color error = Color(0xFFDC3545);
// }
//
// class UpdateCheckerWidget extends StatefulWidget {
//   final Widget child;
//
//   const UpdateCheckerWidget({super.key, required this.child});
//
//   @override
//   State<UpdateCheckerWidget> createState() => _UpdateCheckerWidgetState();
// }
//
// class _UpdateCheckerWidgetState extends State<UpdateCheckerWidget> {
//   bool _isCheckingUpdate = true;
//   bool _isUpdateRequired = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _checkForMandatoryUpdate();
//   }
//
//   Future<void> _checkForMandatoryUpdate() async {
//     try {
//       final updateInfo = await InAppUpdateService.checkForUpdate();
//
//       if (updateInfo != null &&
//           updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
//         // Check if update is mandatory
//         final isMandatory = await _isUpdateMandatory(updateInfo);
//
//         if (isMandatory && mounted) {
//           setState(() {
//             _isUpdateRequired = true;
//             _isCheckingUpdate = false;
//           });
//           _showMandatoryUpdateDialog();
//         } else if (mounted) {
//           setState(() {
//             _isCheckingUpdate = false;
//           });
//           _showOptionalUpdateNotification();
//         }
//       } else if (mounted) {
//         setState(() {
//           _isCheckingUpdate = false;
//         });
//       }
//     } catch (e) {
//       debugPrint('Update check failed: $e');
//       if (mounted) {
//         setState(() {
//           _isCheckingUpdate = false;
//         });
//       }
//     }
//   }
//
//   Future<bool> _isUpdateMandatory(AppUpdateInfo updateInfo) async {
//     // Make all updates mandatory - change this logic as needed
//     return true;
//   }
//
//   void _showMandatoryUpdateDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return PopScope(
//           canPop: false,
//           child: AlertDialog(
//             backgroundColor: AppColors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//             title: Column(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: AppColors.gold.withOpacity(0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(
//                     Icons.system_update_alt,
//                     color: AppColors.gold,
//                     size: 48,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 const Text(
//                   'Update Required',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.w700,
//                     color: AppColors.charcoal,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: const [
//                 Text(
//                   'A new version of Al Noor Town is available.',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: AppColors.grey,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 12),
//                 Text(
//                   'Please update to continue using the app.',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.error,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//             actions: [
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(16),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.gold,
//                     foregroundColor: AppColors.white,
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   onPressed: () async {
//                     try {
//                       await InAppUpdateService.performImmediateUpdate();
//                     } catch (e) {
//                       debugPrint('Update failed: $e');
//                       if (mounted) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text('Update failed. Please try again.'),
//                             backgroundColor: AppColors.error,
//                           ),
//                         );
//                       }
//                     }
//                   },
//                   child: const Text(
//                     'UPDATE NOW',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void _showOptionalUpdateNotification() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: const [
//             Icon(Icons.system_update, color: AppColors.gold),
//             SizedBox(width: 12),
//             Expanded(
//               child: Text(
//                 'New update available! Please update for better experience.',
//                 style: TextStyle(
//                   fontSize: 14,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         backgroundColor: AppColors.charcoal,
//         duration: const Duration(seconds: 8),
//         action: SnackBarAction(
//           label: 'UPDATE',
//           textColor: AppColors.gold,
//           onPressed: () async {
//             try {
//               await InAppUpdateService.performImmediateUpdate();
//             } catch (e) {
//               debugPrint('Update failed: $e');
//             }
//           },
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_isCheckingUpdate) {
//       return Scaffold(
//         backgroundColor: AppColors.offWhite,
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: 60,
//                 height: 60,
//                 padding: const EdgeInsets.all(12),
//                 child: const CircularProgressIndicator(
//                   valueColor: AlwaysStoppedAnimation<Color>(AppColors.gold),
//                   strokeWidth: 3,
//                 ),
//               ),
//               const SizedBox(height: 24),
//               const Text(
//                 'Checking for updates...',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: AppColors.grey,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//
//     if (_isUpdateRequired) {
//       return Scaffold(
//         backgroundColor: AppColors.offWhite,
//         body: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(32.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: AppColors.gold.withOpacity(0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(
//                     Icons.system_update_alt,
//                     color: AppColors.gold,
//                     size: 64,
//                   ),
//                 ),
//                 const SizedBox(height: 32),
//                 const Text(
//                   'Update Required',
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.w700,
//                     color: AppColors.charcoal,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 const Text(
//                   'A new version is available.\nPlease update to continue using the app.',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: AppColors.grey,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 32),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.gold,
//                       foregroundColor: AppColors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     onPressed: () async {
//                       try {
//                         await InAppUpdateService.performImmediateUpdate();
//                       } catch (e) {
//                         debugPrint('Update failed: $e');
//                         if (mounted) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                               content: Text('Update failed. Please try again.'),
//                               backgroundColor: AppColors.error,
//                             ),
//                           );
//                         }
//                       }
//                     },
//                     child: const Text(
//                       'UPDATE NOW',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     }
//
//     return widget.child;
//   }
// }