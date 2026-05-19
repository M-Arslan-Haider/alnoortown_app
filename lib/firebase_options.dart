import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDbX9BT2Be4s0G2X3KQC2Zc1Z6PNCCgNE8',
    appId: '1:1074033692644:android:53bb11575fa9ec2a2741f1',
    messagingSenderId: '1074033692644',
    projectId: 'al-noor-town-app',
    storageBucket: 'al-noor-town-app.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDbX9BT2Be4s0G2X3KQC2Zc1Z6PNCCgNE8',
    appId: '1:1074033692644:ios:53bb11575fa9ec2a2741f1',
    messagingSenderId: '1074033692644',
    projectId: 'al-noor-town-app',
    storageBucket: 'al-noor-town-app.firebasestorage.app',
    iosBundleId: 'com.example.alnoortown_app',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDbX9BT2Be4s0G2X3KQC2Zc1Z6PNCCgNE8',
    appId: '1:1074033692644:web:53bb11575fa9ec2a2741f1',
    messagingSenderId: '1074033692644',
    projectId: 'al-noor-town-app',
    authDomain: 'al-noor-town-app.firebaseapp.com',
    storageBucket: 'al-noor-town-app.firebasestorage.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDbX9BT2Be4s0G2X3KQC2Zc1Z6PNCCgNE8',
    appId: '1:1074033692644:ios:53bb11575fa9ec2a2741f1',
    messagingSenderId: '1074033692644',
    projectId: 'al-noor-town-app',
    storageBucket: 'al-noor-town-app.firebasestorage.app',
    iosBundleId: 'com.example.alnoortown_app',
  );
}