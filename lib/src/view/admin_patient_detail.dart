import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/admin_post/admin_post_cubit.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/patient_detail/cubit/patient_detail_cubit.dart';
import 'package:follow_up_clinic_app/src/route/routes.dart';
import 'package:follow_up_clinic_app/src/view/preview_page.dart';
import 'package:follow_up_clinic_app/src/view/response_admin_page.dart';
import 'package:intl/intl.dart';

class AdminPatientDetail extends StatefulWidget {
  const AdminPatientDetail({super.key});

  @override
  State<AdminPatientDetail> createState() => _AdminPatientDetail();
}

class _AdminPatientDetail extends State<AdminPatientDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    return MultiBlocListener(
        listeners: [
          BlocListener<AdminPostCubit, AdminPostState>(
              listener: (context, state) {
            if (state is AdminPostSuccess) {
              BlocProvider.of<PatientDetailCubit>(context)
                  .getPatientHistory(arg['uid']);
            }
          }),
        ],
        child: Scaffold(
            body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.5),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/login_header.jpg'),
                      fit: BoxFit.cover)),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.5),
                    Theme.of(context).primaryColor.withOpacity(0.6)
                  ], // Set your gradient colors
                  begin: Alignment
                      .topCenter, // Set the start position of the gradient
                  end: Alignment
                      .bottomCenter, // Set the end position of the gradient
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 45, 10, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('TU Eye', style: TextStyle(fontSize: 30)),
                      ),
                    ],
                  ),
                  // const Padding(
                  //   padding: EdgeInsets.fromLTRB(50, 5, 0, 0),
                  //   child: Text('คุณ'),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: const Text('ประวัติการรักษา'),
                  ),
                  BlocBuilder<PatientDetailCubit, PatientDetailState>(
                      builder: (context, state) {
                    if (state is PatientDetailInitial) {
                      BlocProvider.of<PatientDetailCubit>(context)
                          .getPatientHistory(arg['uid']);
                    }
                    if (state is PatientDetailLoading) {
                      return const CircularProgressIndicator();
                    }
                    if (state is PatientDetailSuccess) {
                      return Expanded(
                          child: ListView.builder(
                              itemCount: state.data.length,
                              itemBuilder: (BuildContext context, index) {
                                return Card(
                                  margin: const EdgeInsets.all(5),
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(0),
                                          child: Text(
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall,
                                              DateFormat().add_yMMMMd().format(
                                                  state.data[index].dateCase
                                                      .toDate())),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            'รายละเอียด',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                        ),
                                        SizedBox(
                                            height: 200,
                                            child: GridView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                ),
                                                itemCount: state
                                                    .data[index].images.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        ind) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => PreviewPage(
                                                                  picture: state
                                                                          .data[
                                                                              index]
                                                                          .images[ind]
                                                                      [
                                                                      'url'])));
                                                    },
                                                    child: Container(
                                                      height: 300,
                                                      width: 200,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 5),
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(state
                                                                      .data[index]
                                                                      .images[
                                                                  ind]['url']))),
                                                      child: Center(
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.black,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            15)),
                                                          ),
                                                          child: Text(
                                                              (state.data[index]
                                                                          .images[ind]
                                                                      [
                                                                      'left_eye'])
                                                                  ? 'ตาซ้าย'
                                                                  : 'ตาขวา',
                                                              style: TextStyle(
                                                                fontSize: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge!
                                                                    .fontSize,
                                                                color: Colors
                                                                    .white,
                                                              )),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                })),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 20, 0, 0),
                                          child: Text(
                                            'คำอธิบาย',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                        ),
                                        // const Divider(color: Colors.grey),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 10, 0, 20),
                                          child: Text(
                                            state.data[index].description,
                                            maxLines: 10,
                                            overflow: TextOverflow.fade,
                                            softWrap: false,
                                          ),
                                        ),
                                        const Divider(color: Colors.grey),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 20, 0, 0),
                                          child: Text(
                                            'ผลการวินิจฉัย',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 20),
                                          child: DottedBorder(
                                            color: Colors.grey,
                                            radius: const Radius.circular(12),
                                            padding: const EdgeInsets.all(6),
                                            strokeWidth: 1,
                                            child: Text(
                                              state.data[index].diagnosisResult[
                                                      'description'] ??
                                                  'ไม่พบข้อมูลวินิจฉัย',
                                              maxLines: 10,
                                              overflow: TextOverflow.fade,
                                              softWrap: true,
                                              style: const TextStyle(
                                                color: Colors.green,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Diagnosis Image
                                        state
                                                    .data[index]
                                                    .diagnosisResult['image']
                                                    .length !=
                                                0
                                            ? SizedBox(
                                                height: 200,
                                                child: GridView.builder(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                    ),
                                                    itemCount: state
                                                        .data[index]
                                                        .diagnosisResult[
                                                            'image']
                                                        .length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            ind) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => PreviewPage(
                                                                      picture: state
                                                                          .data[
                                                                              index]
                                                                          .diagnosisResult['image'][ind]['url'])));
                                                        },
                                                        child: Container(
                                                          height: 300,
                                                          width: 200,
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 5),
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  image: NetworkImage(state
                                                                          .data[
                                                                              index]
                                                                          .diagnosisResult['image'][ind]
                                                                      [
                                                                      'url']))),
                                                        ),
                                                      );
                                                    }))
                                            : const Text(''),
                                        // const Divider(color: Colors.grey),
                                        ElevatedButton(
                                          child: const Text('ตอบกลับ'),
                                          onPressed: () {
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (BuildContext context) {
                                                return BlocProvider<
                                                    AdminPostCubit>(
                                                  create: (context) =>
                                                      AdminPostCubit(),
                                                  child: ResponseAdminPage(
                                                      postId:
                                                          state.data[index].id),
                                                );
                                              },
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }));
                    } else {
                      return const Text('ไม่พบข้อมูล');
                    }
                  })
                ],
              ),
            ),
          ],
        )));
  }
}
