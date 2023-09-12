import 'package:flutter/material.dart';

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
                    controller: _resetPasswordController,
                    decoration: const InputDecoration(
                        label: Text('อีเมล*'), border: OutlineInputBorder()),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print('reset Password');
                      }
                    },
                    child: const Text('รีเซตรหัสผ่าน')),
              ],
            ),
          ),
        ));
  }
}
