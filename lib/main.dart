import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'firebase_options.dart';
import 'package:follow_up_clinic_app/theme/app_theme.dart';
import 'package:flutter/services.dart';

import './src/route/routes.dart' as routes;
import './src/route/route_handler.dart' as handleRoute;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    print('Firebase in debug mode');
    try {
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
      await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Intl.defaultLocale = 'th_TH';
  await initializeDateFormatting('th_TH', null);

  runApp(
    MaterialApp(
      title: 'TU EYE',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: routes.Routes.home,
      onGenerateRoute: handleRoute.generateRoute,
    ),
  );
}
