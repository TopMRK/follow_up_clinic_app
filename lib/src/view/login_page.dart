import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/login_cubit.dart';
import 'package:email_validator/email_validator.dart';
import 'package:follow_up_clinic_app/src/route/routes.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late LoginCubit loginCubit;

  @override
  void initState() {
    super.initState();
    loginCubit = BlocProvider.of<LoginCubit>(context);
  }

  @override
  void dispose() {
    // loginCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.home, (Route<dynamic> route) => false);
        }
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกอีเมล';
                        } else if (!EmailValidator.validate(value)) {
                          return 'กรุณากรอกอีเมลให้ถูกต้อง';
                        }
                      },
                      controller: _emailController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: 'อีเมล*'),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกรหัสผ่าน';
                        }
                      },
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'รหัสผ่าน*',
                      ),
                      obscureText: true,
                      autocorrect: false,
                      enableSuggestions: false,
                    ),
                    BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                      if (state is LoginError) {
                        return Container(
                          margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: Text(
                            state.status,
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      } else {
                        return const Text('');
                      }
                    }),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () => Navigator.pushNamed(
                              context, Routes.resetPassword),
                          child: const Text('ลืมรหัสผ่าน ?')),
                    ),
                    BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                      if (state is LoginLoading) {
                        return const CircularProgressIndicator();
                      } else {
                        return ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                loginCubit.firebaseLogin(_emailController.text,
                                    _passwordController.text);
                              }
                            },
                            // Navigator.pushNamed(context, Routes.home),
                            child: const Text('เข้าสู่ระบบ'));
                      }
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
