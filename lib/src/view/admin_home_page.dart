import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/authentication/authentication_cubit.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/user_post/user_post_cubit.dart';
import 'package:follow_up_clinic_app/src/route/routes.dart';
import 'package:follow_up_clinic_app/src/view/response_user_page.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePage();
}

class _AdminHomePage extends State<AdminHomePage> {
  late AuthenticationCubit authbloc;

  @override
  void initState() {
    super.initState();
    // authbloc = BlocProvider.of<AuthenticationCubit>(context);
    // authbloc.authenticationLogin();
  }

  @override
  void dispose() {
    // authbloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.5),
              image: const DecorationImage(
                  image: AssetImage('assets/images/login_header.jpg'),
                  fit: BoxFit.cover)),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.5),
                Theme.of(context).primaryColor.withOpacity(0.6)
              ], // Set your gradient colors
              begin:
                  Alignment.topCenter, // Set the start position of the gradient
              end: Alignment
                  .bottomCenter, // Set the end position of the gradient
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 45, 10, 10),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('TU Eye', style: TextStyle(fontSize: 30)),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.blue,
                      ),
                      onPressed: () => authbloc.authenticationLogout(),
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text('สวัสดี, คุณ เจ้าหน้าที่'),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: SearchAnchor(
                    builder: (BuildContext conntext, controller) {
                  return SearchBar(
                    controller: controller,
                    leading: const Icon(Icons.search),
                  );
                }, suggestionsBuilder:
                        (BuildContext context, SearchController controller) {
                  return List<ListTile>.generate(5, (int index) {
                    final String item = 'item $index';
                    return ListTile(
                      title: Text(item),
                      onTap: () {
                        setState(() {
                          controller.closeView(item);
                        });
                      },
                    );
                  });
                }),
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red)),
                      child: const Text('แจ้งเตือนใหม่'),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                        onPressed: () {}, child: const Text('คนไข้ทั้งหมด')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
