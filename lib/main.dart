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

  Intl.defaultLocale = 'th_TH';
  await initializeDateFormatting('th_TH', null);

  runApp(
    MaterialApp(
      title: 'OPD Health MED',
      theme: AppTheme.lightTheme,
      initialRoute: routes.Routes.home,
      onGenerateRoute: handleRoute.generateRoute,
    ),
  );
}
