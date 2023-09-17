import 'package:flutter/material.dart';

import './login_page.dart';
import './register_page.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPage();
}

class _AuthenticationPage extends State<AuthenticationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: 2,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight +
              120), // Increase the height to accommodate the background
          child: Stack(
            children: [
              Image.asset(
                'assets/images/login_header.jpg', // Path to your background image
                fit: BoxFit.cover,
                width: double.infinity,
                height: kToolbarHeight + 300, // Adjust the height as needed
              ),
              AppBar(
                elevation: 0, // Remove the shadow
                backgroundColor: Theme.of(context)
                    .primaryColor
                    .withOpacity(0.40), // Make the AppBar transparent
              ),
              Align(
                alignment: Alignment.center,
                heightFactor: kToolbarHeight + 30,
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain,
                  height: 150,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
              decoration: BoxDecoration(
                  // border: Border.all(width: 0.1),
                  borderRadius: BorderRadius.circular(50),
                  color: const Color(0xFFfafafa)),
              // color: const Color(0xFFfafafa),
              child: TabBar(
                  controller: _tabController,
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                      // gradient: const LinearGradient(
                      //     colors: [Colors.blue, Colors.orangeAccent]),
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context).primaryColor),
                  splashBorderRadius: BorderRadius.circular(50),
                  tabs: const [
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("เข้าสู่ระบบ"),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("สมัครสมาชิก"),
                      ),
                    ),
                  ]),
            ),
            Expanded(
                child: TabBarView(
              controller: _tabController,
              children: [
                LoginPage(),
                RegisterPage(),
              ],
            ))
          ],
        ));
  }
}
