// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAhGPqp_Ww-YxqLdqYoDYH47wMROi53SBE',
    appId: '1:468184582786:web:64a6ad34a610ec184e829b',
    messagingSenderId: '468184582786',
    projectId: 'fir-auth-app-a5f85',
    authDomain: 'fir-auth-app-a5f85.firebaseapp.com',
    storageBucket: 'fir-auth-app-a5f85.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDceYF4OVCnJ5rfJO0G0uWeuIiErXYC22M',
    appId: '1:468184582786:android:e94fedebf6d7118d4e829b',
    messagingSenderId: '468184582786',
    projectId: 'fir-auth-app-a5f85',
    storageBucket: 'fir-auth-app-a5f85.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC9xv_8YV_lUWC_vGbSLlfq0d7Gyfhc3PQ',
    appId: '1:468184582786:ios:0ab043b0b46ffead4e829b',
    messagingSenderId: '468184582786',
    projectId: 'fir-auth-app-a5f85',
    storageBucket: 'fir-auth-app-a5f85.appspot.com',
    iosBundleId: 'com.example.sidiBou',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAhGPqp_Ww-YxqLdqYoDYH47wMROi53SBE',
    appId: '1:468184582786:web:7b4f70c38a933d244e829b',
    messagingSenderId: '468184582786',
    projectId: 'fir-auth-app-a5f85',
    authDomain: 'fir-auth-app-a5f85.firebaseapp.com',
    storageBucket: 'fir-auth-app-a5f85.appspot.com',
  );
}
