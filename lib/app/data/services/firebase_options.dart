// File: firebase_options.dart

// This file is generated automatically, do not edit it.
// The file contains the configuration for Firebase for each platform.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return kIsWeb
        ? web
        : defaultTargetPlatform == TargetPlatform.android
            ? android
            : defaultTargetPlatform == TargetPlatform.iOS
                ? ios
                : defaultTargetPlatform == TargetPlatform.macOS
                    ? macos
                    : defaultTargetPlatform == TargetPlatform.windows
                        ? windows
                        : throw UnsupportedError('DefaultFirebaseOptions are not supported for this platform.');
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAycQ6khSL67CFPO34INtkalZyP5t_veh0',
    appId: '1:526973938578:web:5d7d9815866d8f014b7503',
    messagingSenderId: '526973938578',
    projectId: 'ujastore-84269',
    authDomain: 'ujastore-84269.firebaseapp.com',
    storageBucket: 'ujastore-84269.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAycQ6khSL67CFPO34INtkalZyP5t_veh0',
    appId: '1:526973938578:android:529c14dccd6f665f142f4b',
    messagingSenderId: '526973938578',
    projectId: 'ujastore-84269',
    storageBucket: 'ujastore-84269.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAycQ6khSL67CFPO34INtkalZyP5t_veh0',
    appId: '1:526973938578:ios:some_ios_app_id',
    messagingSenderId: '526973938578',
    projectId: 'ujastore-84269',
    storageBucket: 'ujastore-84269.appspot.com',
    iosBundleId: 'com.example.ujastore',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAycQ6khSL67CFPO34INtkalZyP5t_veh0',
    appId: '1:526973938578:macos:some_macos_app_id',
    messagingSenderId: '526973938578',
    projectId: 'ujastore-84269',
    storageBucket: 'ujastore-84269.appspot.com',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAycQ6khSL67CFPO34INtkalZyP5t_veh0',
    appId: '1:526973938578:windows:some_windows_app_id',
    messagingSenderId: '526973938578',
    projectId: 'ujastore-84269',
    storageBucket: 'ujastore-84269.appspot.com',
  );
}
