import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/authentication/authentication_cubit.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/homepage/homepage_cubit.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/login_cubit.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/register_cubit.dart';
import 'package:follow_up_clinic_app/src/view/admin_home_page.dart';
import 'package:follow_up_clinic_app/src/view/authentication_page.dart';
import 'package:follow_up_clinic_app/src/view/home_page.dart';
import 'package:follow_up_clinic_app/src/view/reset_password.dart';
import 'routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.login:
      return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
                  BlocProvider<RegisterCubit>(
                      create: (context) => RegisterCubit()),
                ],
                child: AuthenticationPage(),
              ));
    case Routes.home:
      return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(providers: [
                BlocProvider<AuthenticationCubit>(
                  create: (context) => AuthenticationCubit(),
                ),
                BlocProvider<HomepageCubit>(
                  create: (context) => HomepageCubit(),
                ),
              ], child: HomePage()));
    case Routes.resetPassword:
      return MaterialPageRoute(builder: (context) => ResetPassword());
    case Routes.adminHome:
      return MaterialPageRoute(builder: (context) => AdminHomePage());
    default:
      return MaterialPageRoute(
          builder: (context) => const AuthenticationPage());
  }
}
