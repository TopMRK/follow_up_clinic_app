import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/user_post/user_post_cubit.dart';
import 'package:follow_up_clinic_app/src/model/user_post_model.dart';
import 'package:follow_up_clinic_app/src/view/camera_page.dart';

class ResponseUserPage extends StatefulWidget {
  const ResponseUserPage({super.key});
  @override
  _ResponseUserPageState createState() => _ResponseUserPageState();
}

class _ResponseUserPageState extends State<ResponseUserPage> {
  final startDate = DateTime.now();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _textFieldController = TextEditingController();

  XFile? picture;
  List<XFile> listPicture = [];

  bool enableTakePhoto = true;

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserPostCubit, UserPostState>(
      listener: (context, state) {
        if (state is UserPostSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('คุณได้อัพเดตข้อมูลเรียบร้อย'),
            backgroundColor: Colors.green,
          ));
          return Navigator.pop(context);
        } else if (state is UserPostError) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('ไม่สามารถอั'),
            backgroundColor: Colors.green,
          ));
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                25, 25, 25, MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.75,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'อัพเดตอาการ',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      minLines: 5,
                      maxLines: null,
                      controller: _textFieldController,
                      decoration: const InputDecoration(
                          labelText: 'กรุณากรอกรายละเอียด*',
                          alignLabelWithHint: true),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกรายละเอียด';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.camera_alt),
                      onPressed: (enableTakePhoto)
                          ? () async {
                              picture = await availableCameras().then((value) =>
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              CameraPage(cameras: value))));
                              if (listPicture.length <= 4) {
                                if (picture != null) {
                                  setState(() {
                                    listPicture.add(picture!);
                                  });
                                }
                              } else {
                                setState(() {
                                  enableTakePhoto = false;
                                });
                              }
                              print(enableTakePhoto);
                            }
                          : null,
                      label: const Text('อัพโหลดรูปภาพ'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: (listPicture.isNotEmpty)
                          ? Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: listPicture.length,
                                  itemBuilder: (BuildContext context, index) {
                                    return Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Stack(
                                          children: [
                                            Image.file(
                                              File(listPicture[index].path),
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.close,
                                                size: 15,
                                              ),
                                              color: Colors.white,
                                              onPressed: () => setState(() {
                                                listPicture
                                                    .remove(listPicture[index]);
                                              }),
                                            ),
                                          ],
                                        ));
                                  }))
                          : const Text('ไม่พบรูปภาพแนบ'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Process the form data here
                          BlocProvider.of<UserPostCubit>(context).userNewPost(
                              _textFieldController.text,
                              listPicture,
                              startDate);
                          // Navigator.pop(context); // Close the BottomSheet
                        }
                      },
                      child: const Text('ส่งผลอาการ'),
                    ),
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
