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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
      apiKey: "AIzaSyCxk--D1aE8vtJ3H_2XZ1YZw8tBNEae11c",
      authDomain: "fluid-60f3a.firebaseapp.com",
      projectId: "fluid-60f3a",
      storageBucket: "fluid-60f3a.appspot.com",
      messagingSenderId: "904734656301",
      appId: "1:904734656301:web:397c5bdb6d775abdb635a4",
      measurementId: "G-RVV4LT0DQ3"
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAiQYR-Y8SYMhfXmtD2p7L3KKmPBpepELE',
    appId: '1:904734656301:android:2c4f79b15f4f0c70b635a4',
    messagingSenderId: "904734656301",
    projectId: "fluid-60f3a",
    storageBucket: "fluid-60f3a.appspot.com",
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAiQYR-Y8SYMhfXmtD2p7L3KKmPBpepELE',
    appId: '1:904734656301:ios:b4ca37661f4f445fb635a4',
    messagingSenderId: "904734656301",
    projectId: "fluid-60f3a",
    storageBucket: "fluid-60f3a.appspot.com",
    iosClientId: '387371288168-44ivlspqmvbkjoaijlc40jjt2r01r2ik.apps.googleusercontent.com',
    iosBundleId: 'com.example.fluidDatingApp',
  );
}
