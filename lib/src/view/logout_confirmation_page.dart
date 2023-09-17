import 'package:flutter/material.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/authentication/authentication_cubit.dart';

class LogoutConfirmationPage {
  late AuthenticationCubit authbloc;

  void showAlertDialog(BuildContext context, authbloc) {
    Widget cancelButton = TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('ยกเลิก'));

    Widget confirmButton = TextButton(
        onPressed: () => authbloc.authenticationLogout(),
        child: const Text(
          'ยืนยัน',
          style: TextStyle(color: Colors.red),
        ));

    AlertDialog alert = AlertDialog(
      title: Text('ยืนยันออกจากระบบ'),
      content: Text('คุณต้องการออกจากระบบใช่หรือไม่ ?'),
      actions: [confirmButton, cancelButton],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
