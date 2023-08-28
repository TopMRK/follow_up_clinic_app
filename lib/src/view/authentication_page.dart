import 'package:flutter/material.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPage();
}

class _AuthenticationPage extends State<AuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight +
            200), // Increase the height to accommodate the background
        child: Stack(
          children: [
            Image.asset(
              'assets/images/login_header.jpg', // Path to your background image
              fit: BoxFit.cover,
              width: double.infinity,
              height: kToolbarHeight + 200, // Adjust the height as needed
            ),
            AppBar(
              elevation: 0, // Remove the shadow
              backgroundColor: Theme.of(context)
                  .primaryColor
                  .withOpacity(0.35), // Make the AppBar transparent
            ),
          ],
        ),
      ),
      // body: ,
    );
  }
}
