import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/authentication/authentication_cubit.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/patient_overview/patient_overview_cubit.dart';
import 'package:follow_up_clinic_app/src/route/routes.dart';
import 'package:follow_up_clinic_app/src/view/admin_patient_overview_page.dart';
import 'package:follow_up_clinic_app/src/view/logout_confirmation_page.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePage();
}

class _AdminHomePage extends State<AdminHomePage> {
  late AuthenticationCubit authbloc;
  final LogoutConfirmationPage _logoutConfirmationPage =
      LogoutConfirmationPage();

  @override
  void initState() {
    super.initState();
    authbloc = BlocProvider.of<AuthenticationCubit>(context);
    // authbloc.authenticationLogin();
    BlocProvider.of<PatientOverviewCubit>(context).getPatientAll();
  }

  @override
  void dispose() {
    authbloc.close();
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      onPressed: () => _logoutConfirmationPage.showAlertDialog(
                          context, authbloc),
                    ),
                  )
                ],
              ),
              const Align(
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
                      child: const Text('รายการรอตอบกลับ'),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                        onPressed: () {}, child: const Text('คนไข้ทั้งหมด')),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                child: const Text('รายการผู้ป่วย'),
              ),
              BlocBuilder<PatientOverviewCubit, PatientOverviewState>(
                  builder: (context, state) {
                if (state is PatientOverviewSuccess) {
                  return AdminPatientOverviewPage(data: state.data);
                } else if (state is PatientOverviewLoading) {
                  return const CircularProgressIndicator();
                } else if (state is PatientOverviewError) {
                  return Text(state.message);
                } else {
                  return const Text('ไม่พบข้อมูลผู้ป่วย');
                }
              }),
            ],
          ),
        ),
      ],
    ));
  }
}
