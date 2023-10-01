import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/authentication/authentication_cubit.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/internet_checker/internet_checker_cubit.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/user_post/user_post_cubit.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/homepage/homepage_cubit.dart';
import 'package:follow_up_clinic_app/src/route/routes.dart';
import 'package:follow_up_clinic_app/src/view/home_content_page.dart';
import 'package:follow_up_clinic_app/src/view/logout_confirmation_page.dart';
import 'package:follow_up_clinic_app/src/view/response_user_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  late AuthenticationCubit authbloc;
  late InternetCheckerCubit internetCheck;
  final LogoutConfirmationPage _logoutConfirmationPage =
      LogoutConfirmationPage();

  @override
  void initState() {
    super.initState();
    authbloc = BlocProvider.of<AuthenticationCubit>(context);
    internetCheck = BlocProvider.of<InternetCheckerCubit>(context);
    internetCheck.internetChecking();
  }

  @override
  void dispose() {
    authbloc.close();
    super.dispose();
  }

  Future<void> _getRefreshData() async {
    setState(() {
      BlocProvider.of<HomepageCubit>(context).getMedicalHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<InternetCheckerCubit, InternetCheckerState>(
            listener: (context, state) {
          if (state is InternetCheckerSuccess) {
            authbloc.authenticationLogin();
          }
        }),
        BlocListener<AuthenticationCubit, AuthenticationState>(
            listener: (context, state) {
          if (state is AuthenticationSuccess) {
            if (state.role == 'doctor' || state.role == 'admin') {
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.adminHome, (Route<dynamic> route) => false);
            } else {
              BlocProvider.of<HomepageCubit>(context).getMedicalHistory();
            }
          } else if (state is AuthenticationFail) {
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.login, (Route<dynamic> route) => false);
          }
        }),
        BlocListener<UserPostCubit, UserPostState>(listener: (context, state) {
          if (state is UserPostSuccess) {
            BlocProvider.of<HomepageCubit>(context).getMedicalHistory();
          }
        })
      ],
      child: Scaffold(
          body: BlocBuilder<InternetCheckerCubit, InternetCheckerState>(
        builder: (context, state) {
          if (state is InternetCheckerFailed) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('ไม่สามารถเชื่อมต่ออินเทอร์เน็ตได้'),
                  ElevatedButton.icon(
                      onPressed: () => internetCheck.internetChecking(),
                      icon: const Icon(Icons.refresh),
                      label: const Text('ลองใหม่อีกครั้ง'))
                ],
              ),
            );
          } else {
            return Stack(
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
                      begin: Alignment
                          .topCenter, // Set the start position of the gradient
                      end: Alignment
                          .bottomCenter, // Set the end position of the gradient
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 45, 10, 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('TU EYE',
                                style: TextStyle(
                                  fontSize: 30,
                                )),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: const Icon(
                                Icons.logout,
                                color: Color(0xFFdf9929),
                              ),
                              onPressed: () => _logoutConfirmationPage
                                  .showAlertDialog(context, authbloc),
                            ),
                          )
                        ],
                      ),
                      BlocBuilder<AuthenticationCubit, AuthenticationState>(
                          builder: (context, state) {
                        if (state is AuthenticationSuccess) {
                          return Align(
                            alignment: Alignment.topLeft,
                            child: Text('สวัสดี, คุณ ${state.data}'),
                          );
                        } else {
                          return const Text('สวัสดี');
                        }
                      }),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return BlocProvider<UserPostCubit>(
                                  create: (context) => UserPostCubit(),
                                  child: const ResponseUserPage(),
                                );
                              },
                            ).then((value) {
                              setState(() {
                                BlocProvider.of<HomepageCubit>(context)
                                    .getMedicalHistory();
                              });
                            });
                          },
                          icon: const Icon(Icons.add_circle_rounded),
                          label: const Text('อัพเดตอาการ'),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text('รายการอัพเดตอาการ'),
                      ),
                      BlocBuilder<HomepageCubit, HomepageState>(
                          builder: (context, state) {
                        if (state is HomepageSuccess) {
                          return HomeContentPage(state: state);
                        } else if (state is HomepageLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            child: const Center(
                              child: Text('คุณยังไม่มีรายการอัพเดต'),
                            ),
                          );
                        }
                      }),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      )),
    );
  }
}
