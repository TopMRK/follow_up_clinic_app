import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/register_cubit.dart';
import 'package:follow_up_clinic_app/src/model/register_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

import 'package:follow_up_clinic_app/src/model/register_model.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _hnController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  DateTime _birthday = DateTime.now();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('คุณลงทะเบียนสำเร็จแล้ว'),
            backgroundColor: Colors.green,
          ));

          _emailController.text = '';
          _passwordController.text = '';
          _telephoneController.text = '';
          _firstnameController.text = '';
          _lastnameController.text = '';
          _birthdayController.text = '';
          _hnController.text = '';
          _addressController.text = '';
        } else if (state is RegisterError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
            backgroundColor: Colors.red,
          ));
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
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: 'อีเมล*'),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกข้อมูล';
                        }
                      },
                      controller: _telephoneController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'หมายเลขโทรศัพท์*',
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกข้อมูล';
                        }
                      },
                      controller: _firstnameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'ชื่อจริง*',
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกข้อมูล';
                        }
                      },
                      controller: _lastnameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'นามสกุล*',
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกข้อมูล';
                        }
                      },
                      controller: _birthdayController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'วัน/เดือน/ปีเกิด*',
                      ),
                      // keyboardType: TextInputType.datetime,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1920),
                            lastDate: DateTime.now());
                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat().add_yMMMMd().format(pickedDate);
                          _birthday = pickedDate;
                          setState(() {
                            _birthdayController.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {}
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'ที่อยู่*',
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกข้อมูล';
                        }
                      },
                      controller: _hnController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'หมายเลขประจำตัวผู้ป่วย*',
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกข้อมูล';
                        } else if (value !=
                            _passwordConfirmationController.text) {
                          return 'รหัสผ่านไม่ตรงกัน';
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
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกข้อมูล';
                        } else if (value != _passwordController.text) {
                          return 'รหัสผ่านไม่ตรงกัน';
                        }
                      },
                      controller: _passwordConfirmationController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'ยืนยันรหัสผ่าน*',
                      ),
                      obscureText: true,
                      autocorrect: false,
                      enableSuggestions: false,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    BlocBuilder<RegisterCubit, RegisterState>(
                        builder: (context, state) {
                      if (state is RegisterLoading) {
                        return const CircularProgressIndicator();
                      } else {
                        return ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final user = Register(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    telephone: _telephoneController.text,
                                    firstname: _firstnameController.text,
                                    lastname: _lastnameController.text,
                                    birthday: _birthday,
                                    hn: _hnController.text,
                                    address: _addressController.text);
                                BlocProvider.of<RegisterCubit>(context)
                                    .registerUser(user);
                              }
                            },
                            child: const Text('สมัครสมาชิก'));
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
