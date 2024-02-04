import 'package:flutter/material.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/authentication/authentication_cubit.dart';
import 'package:follow_up_clinic_app/src/route/routes.dart';

class LogoutConfirmationPage {
  late AuthenticationCubit authbloc;

  void showAlertDialog(BuildContext context, authbloc) {
    Widget cancelButton = TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('ยกเลิก'));

    Widget confirmButton = TextButton(
        onPressed: () {
          authbloc.authenticationLogout();
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.login, (Route<dynamic> route) => false);
        },
        child: const Text(
          'ยืนยัน',
          style: TextStyle(color: Colors.red),
        ));

    AlertDialog alert = AlertDialog(
      title: const Text('ยืนยันออกจากระบบ'),
      content: const Text('คุณต้องการออกจากระบบใช่หรือไม่ ?'),
      actions: [confirmButton, cancelButton],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
