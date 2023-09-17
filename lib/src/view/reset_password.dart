import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/reset_password/reset_password_cubit.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPassword();
}

class _ResetPassword extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _resetPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('รีเซตรหัสผ่าน')),
        body: Container(
          margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: Center(
            child: Column(
              children: <Widget>[
                const Text(
                    'กรุณากรอกอีเมล เราจะทำการส่งลิงค์สำหรับรีเซตรหัสไปยังอีเมล'),
                const SizedBox(height: 15),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'กรุณาระบุอีเมลของท่าน';
                      } else if (!EmailValidator.validate(value)) {
                        return 'กรุณาระบุอีเมลให้ถูกต้อง';
                      }
                    },
                    controller: _resetPasswordController,
                    decoration: const InputDecoration(
                        label: Text('อีเมล*'), border: OutlineInputBorder()),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                    builder: (context, state) {
                  if (state is ResetPasswordError) {
                    return Text(state.message);
                  } else if (state is ResetPasswordSuccess) {
                    return const Text(
                        'ได้ทำการส่งอีเมลสำหรับรีเซตรหัสผ่านไปทางอีเมลเรียบร้อย');
                  } else {
                    return const Text('');
                  }
                }),
                BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                    builder: (context, state) {
                  if (state is ResetPasswordLoading) {
                    return const CircularProgressIndicator();
                  } else {
                    return ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<ResetPasswordCubit>(context)
                                .sendResetPassword(
                                    _resetPasswordController.text);
                          }
                        },
                        child: const Text('รีเซตรหัสผ่าน'));
                  }
                }),
              ],
            ),
          ),
        ));
  }
}
