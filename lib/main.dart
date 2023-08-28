import 'package:flutter/material.dart';
import 'package:follow_up_clinic_app/theme/app_theme.dart';

// Import image
import './src/view/authentication_page.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'OPD Health MED',
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => AuthenticationPage(),
      },
    ),
  );
}
