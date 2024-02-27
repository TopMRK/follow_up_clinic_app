import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/admin_post/admin_post_cubit.dart';
import 'package:follow_up_clinic_app/src/view/admin_patient_detail.dart';
import 'package:follow_up_clinic_app/src/view/camera_admin_page.dart';
import 'package:follow_up_clinic_app/src/view/camera_page.dart';

class ResponseAdminPage extends StatefulWidget {
  const ResponseAdminPage({
    super.key,
    required this.postId,
  });
  final String postId;
  @override
  _ResponseAdminPageState createState() => _ResponseAdminPageState();
}

class _ResponseAdminPageState extends State<ResponseAdminPage> {
  final startDate = DateTime.now();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _textFieldController = TextEditingController();

  dynamic picture;
  List listPicture = [];

  bool enableTakePhoto = true;

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminPostCubit, AdminPostState>(
      listener: (context, state) {
        if (state is AdminPostSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('คุณได้แจ้งผลการวินิจฉัยเรียบร้อย'),
            backgroundColor: Colors.green,
          ));
          return Navigator.pop(context);
        } else if (state is AdminPostError) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('ไม่สามารถอัพโหลดข้อมูลได้ กรุณาลองใหม่อีกครั้ง'),
            backgroundColor: Colors.red,
          ));
          return Navigator.pop(context);
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
                        'แจ้งผลวินิจฉัย',
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
                                          builder: (_) => CameraAdminPage(
                                              cameras: value))));
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
                                              File(listPicture[index]['picture']
                                                  .path),
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
                          BlocProvider.of<AdminPostCubit>(context).adminNewPost(
                              _textFieldController.text,
                              listPicture,
                              startDate,
                              widget.postId);
                          // Navigator.pop(context); // Close the BottomSheet
                        }
                      },
                      child: const Text('ยืนยันผลวินิจฉัย'),
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
