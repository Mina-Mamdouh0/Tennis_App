// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCvrqqeSqZ_cThIkm_yKXsi77z_Q58EhXM',
    appId: '1:609935719586:web:17e19fbdf6a36580362bfb',
    messagingSenderId: '609935719586',
    projectId: 'tennis-app-6760a',
    authDomain: 'tennis-app-6760a.firebaseapp.com',
    storageBucket: 'tennis-app-6760a.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCZ1_ROm0i6KSKopFhsg2PtJEF0bH3Jz98',
    appId: '1:609935719586:android:33a783d44cb821bc362bfb',
    messagingSenderId: '609935719586',
    projectId: 'tennis-app-6760a',
    storageBucket: 'tennis-app-6760a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDiHgmwDZFuA-1G6vgr8S_fCI_d41d1IMU',
    appId: '1:609935719586:ios:84bcb19cbbae2ca0362bfb',
    messagingSenderId: '609935719586',
    projectId: 'tennis-app-6760a',
    storageBucket: 'tennis-app-6760a.appspot.com',
    iosClientId: '609935719586-6668e5iodaenhed1qugfoo5fhmg11pj7.apps.googleusercontent.com',
    iosBundleId: 'com.example.tennisApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDiHgmwDZFuA-1G6vgr8S_fCI_d41d1IMU',
    appId: '1:609935719586:ios:84bcb19cbbae2ca0362bfb',
    messagingSenderId: '609935719586',
    projectId: 'tennis-app-6760a',
    storageBucket: 'tennis-app-6760a.appspot.com',
    iosClientId: '609935719586-6668e5iodaenhed1qugfoo5fhmg11pj7.apps.googleusercontent.com',
    iosBundleId: 'com.example.tennisApp',
  );
}
