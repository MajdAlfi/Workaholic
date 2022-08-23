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
    apiKey: 'AIzaSyAM2_gcYCZMI-pUhQfknGGnSHzCsH9VE7Q',
    appId: '1:4552154974:web:d38a65e9343d5db587b9cf',
    messagingSenderId: '4552154974',
    projectId: 'workout-3c518',
    authDomain: 'workout-3c518.firebaseapp.com',
    storageBucket: 'workout-3c518.appspot.com',
    measurementId: 'G-FVJ0KYECZH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCquY8stYxa4HvN12AqmZTekd4CE_2RzvU',
    appId: '1:4552154974:android:639a2c28d17198d887b9cf',
    messagingSenderId: '4552154974',
    projectId: 'workout-3c518',
    storageBucket: 'workout-3c518.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB-zXmC3qx8zYivsxAM4lQZar-lRkEkUCs',
    appId: '1:4552154974:ios:494183d26c2e388b87b9cf',
    messagingSenderId: '4552154974',
    projectId: 'workout-3c518',
    storageBucket: 'workout-3c518.appspot.com',
    iosClientId: '4552154974-96hjsvokagdtntrgdmrcb3cis5g38ev9.apps.googleusercontent.com',
    iosBundleId: 'com.example.workoutApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB-zXmC3qx8zYivsxAM4lQZar-lRkEkUCs',
    appId: '1:4552154974:ios:494183d26c2e388b87b9cf',
    messagingSenderId: '4552154974',
    projectId: 'workout-3c518',
    storageBucket: 'workout-3c518.appspot.com',
    iosClientId: '4552154974-96hjsvokagdtntrgdmrcb3cis5g38ev9.apps.googleusercontent.com',
    iosBundleId: 'com.example.workoutApp',
  );
}
