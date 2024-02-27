import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/admin_post/admin_post_cubit.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/authentication/authentication_cubit.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/homepage/homepage_cubit.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/internet_checker/internet_checker_cubit.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/login_cubit.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/patient_detail/cubit/patient_detail_cubit.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/patient_overview/patient_overview_cubit.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/register_cubit.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/reset_password/reset_password_cubit.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/user_post/user_post_cubit.dart';
import 'package:follow_up_clinic_app/src/view/admin_home_page.dart';
import 'package:follow_up_clinic_app/src/view/admin_patient_detail.dart';
import 'package:follow_up_clinic_app/src/view/authentication_page.dart';
import 'package:follow_up_clinic_app/src/view/home_page.dart';
import 'package:follow_up_clinic_app/src/view/preview_page.dart';
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
                BlocProvider<UserPostCubit>(
                    create: (context) => UserPostCubit()),
                BlocProvider<InternetCheckerCubit>(
                    create: (context) => InternetCheckerCubit()),
              ], child: HomePage()));
    case Routes.resetPassword:
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => ResetPasswordCubit(),
                child: ResetPassword(),
              ));
    case Routes.adminHome:
      return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider<AuthenticationCubit>(
                      create: (context) => AuthenticationCubit()),
                  BlocProvider<PatientOverviewCubit>(
                    create: (context) => PatientOverviewCubit(),
                  )
                ],
                child: AdminHomePage(),
              ));
    case Routes.adminPatientDetail:
      return MaterialPageRoute(
          settings: settings,
          builder: (context) => MultiBlocProvider(providers: [
                BlocProvider<PatientDetailCubit>(
                  create: (context) => PatientDetailCubit(),
                ),
                BlocProvider<AdminPostCubit>(
                  create: (context) => AdminPostCubit(),
                ),
              ], child: const AdminPatientDetail()));
    default:
      return MaterialPageRoute(
          builder: (context) => const AuthenticationPage());
  }
}
