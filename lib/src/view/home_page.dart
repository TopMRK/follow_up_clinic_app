import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/authentication/authentication_cubit.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/user_post/user_post_cubit.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/homepage/homepage_cubit.dart';
import 'package:follow_up_clinic_app/src/route/routes.dart';
import 'package:follow_up_clinic_app/src/view/response_user_page.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  late AuthenticationCubit authbloc;

  @override
  void initState() {
    super.initState();
    authbloc = BlocProvider.of<AuthenticationCubit>(context);
    authbloc.authenticationLogin();
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
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccess) {
          BlocProvider.of<HomepageCubit>(context).getMedicalHistory();
        } else if (state is AuthenticationFail) {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.login, (Route<dynamic> route) => false);
        }
      },
      child: Scaffold(
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
                begin: Alignment
                    .topCenter, // Set the start position of the gradient
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
                      child: Text('OPD MED HEALTH',
                          style: TextStyle(fontSize: 30)),
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
                      );
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
                    return Expanded(
                        child: ListView.builder(
                            itemCount: state.data.length,
                            itemBuilder: (BuildContext context, index) {
                              return Card(
                                margin: EdgeInsets.all(5),
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Text(
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge,
                                                  DateFormat()
                                                      .add_yMMMMd()
                                                      .format(state.data[index]
                                                              ['created_at']
                                                          .toDate())),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 5),
                                                    child: Text(
                                                      'รายละเอียด',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height: 100,
                                                      child: GridView.builder(
                                                          physics:
                                                              const NeverScrollableScrollPhysics(),
                                                          gridDelegate:
                                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 2,
                                                          ),
                                                          itemCount: state
                                                              .data[index]
                                                                  ['image']
                                                              .length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  ind) {
                                                            return Container(
                                                              height: 300,
                                                              width: 200,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      right: 5),
                                                              decoration: BoxDecoration(
                                                                  image: DecorationImage(
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      image: NetworkImage(state.data[index]
                                                                              [
                                                                              'image']
                                                                          [
                                                                          ind]))),
                                                            );
                                                          })),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 10, 0, 20),
                                                    child: Text(
                                                      state.data[index]
                                                          ['description'],
                                                      maxLines: 10,
                                                      overflow:
                                                          TextOverflow.fade,
                                                      softWrap: false,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                              // return Text(state.data[index]['uid']);
                            }));
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
      )),
    );
  }
}
