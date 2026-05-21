// //
// // import 'package:alnoortown.residentapp/services/home_screen.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'firebase_options.dart';
// // import 'providers/auth_provider.dart';
// // import 'screens/login_screen.dart';
// // import 'screens/profile_screen.dart';
// // import 'screens/splash_screen.dart';          // ← add this
// //
// //
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp(
// //     options: DefaultFirebaseOptions.currentPlatform,
// //   );
// //   runApp(const MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MultiProvider(
// //       providers: [
// //         ChangeNotifierProvider(create: (_) => AuthProvider()),
// //       ],
// //       child: MaterialApp(
// //         title: 'Al Noor Town',
// //         theme: ThemeData(
// //           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
// //           useMaterial3: true,
// //         ),
// //         home: const SplashScreen(),           // ← splash first
// //         debugShowCheckedModeBanner: false,
// //       ),
// //     );
// //   }
// // }
// //
// // // SplashScreen navigates here after its animation finishes
// // class AuthWrapper extends StatelessWidget {
// //   const AuthWrapper({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final authProvider = Provider.of<AuthProvider>(context);
// //
// //     if (authProvider.isLoggedIn) {
// //       if (authProvider.isProfileComplete()) {
// //         return const HomeScreen();
// //       } else {
// //         return const ProfileScreen(isProfileCompletion: true);
// //       }
// //     } else {
// //       return const LoginScreen();
// //     }
// //   }
// // }
//
// import 'package:alnoortown.residentapp/services/home_screen.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'firebase_options.dart';
// import 'providers/auth_provider.dart';
// import 'screens/login_screen.dart';
// import 'screens/profile_screen.dart';
// import 'screens/splash_screen.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => AuthProvider()),
//       ],
//       child: MaterialApp(
//         title: 'Al Noor Town',
//         theme: ThemeData(
//           colorScheme:
//           ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//           useMaterial3: true,
//         ),
//         home: const SplashScreen(),
//         debugShowCheckedModeBanner: false,
//       ),
//     );
//   }
// }
//
// /// Navigated to from [SplashScreen] after the intro animation.
// class AuthWrapper extends StatelessWidget {
//   const AuthWrapper({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context);
//
//     if (authProvider.isLoggedIn) {
//       return authProvider.isProfileComplete()
//           ? const HomeScreen()
//           : const ProfileScreen(isProfileCompletion: true);
//     }
//     return const LoginScreen();
//   }
// }

import 'package:alnoortown.residentapp/services/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'providers/auth_provider.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Al Noor Town',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

/// Navigated to from [SplashScreen] after the intro animation.
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    // Jab tak AuthProvider init nahi hua (SharedPrefs load nahi hui)
    // loading spinner dikhao — profile check mat karo
    if (!authProvider.isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (authProvider.isLoggedIn) {
      return authProvider.isProfileComplete()
          ? const HomeScreen()
          : const ProfileScreen(isProfileCompletion: true);
    }

    return const LoginScreen();
  }
}