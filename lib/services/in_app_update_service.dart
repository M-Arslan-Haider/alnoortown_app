// // lib/services/in_app_update_service.dart
// import 'package:in_app_update/in_app_update.dart';
// import 'package:flutter/material.dart';
//
// class InAppUpdateService {
//   /// Check if update is available and return update info
//   static Future<AppUpdateInfo?> checkForUpdate() async {
//     try {
//       final updateInfo = await InAppUpdate.checkForUpdate();
//       return updateInfo;
//     } catch (e) {
//       debugPrint('In-app update check failed: $e');
//       return null;
//     }
//   }
//
//   /// Check if update is available (returns boolean)
//   static Future<bool> isUpdateAvailable() async {
//     try {
//       final updateInfo = await InAppUpdate.checkForUpdate();
//       return updateInfo.updateAvailability == UpdateAvailability.updateAvailable;
//     } catch (e) {
//       debugPrint('In-app update check failed: $e');
//       return false;
//     }
//   }
//
//   /// Perform immediate update (mandatory, blocks UI)
//   static Future<void> performImmediateUpdate() async {
//     try {
//       await InAppUpdate.performImmediateUpdate();
//     } catch (e) {
//       debugPrint('Immediate update failed: $e');
//       rethrow;
//     }
//   }
//
//   /// Start flexible update (optional, can be downloaded in background)
//   static Future<void> startFlexibleUpdate() async {
//     try {
//       await InAppUpdate.startFlexibleUpdate();
//     } catch (e) {
//       debugPrint('Flexible update start failed: $e');
//       rethrow;
//     }
//   }
//
//   /// Complete flexible update (must be called after download)
//   static Future<void> completeFlexibleUpdate() async {
//     try {
//       await InAppUpdate.completeFlexibleUpdate();
//     } catch (e) {
//       debugPrint('Complete flexible update failed: $e');
//       rethrow;
//     }
//   }
// }