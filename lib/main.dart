import 'package:flutter/material.dart';

// Import image
import './src/view/authentication_page.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'OPD Health MED',
      initialRoute: '/',
      routes: {
        '/': (context) => AuthenticationPage(),
      },
    ),
  );
}
