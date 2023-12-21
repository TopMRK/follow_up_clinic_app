import 'package:flutter/material.dart';
import 'package:follow_up_clinic_app/src/model/patient_overview_model.dart';

class AdminPatientOverviewPage extends StatefulWidget {
  const AdminPatientOverviewPage({super.key, this.data});

  final dynamic data;

  @override
  State<AdminPatientOverviewPage> createState() => _AdminPatientOverviewPage();
}

class _AdminPatientOverviewPage extends State<AdminPatientOverviewPage> {
  @override
  Widget build(BuildContext context) {
    final dynamic data = widget.data;
    return Expanded(
        child: ListView.builder(
            itemCount: data.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => print('Click it'),
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${data[index].hn}",
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              "ชื่อ-สกุล:  ${data[index].firstname}  ${data[index].lastname}"),
                        ],
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.navigate_next_outlined,
                        color: Colors.green,
                      ),
                    ],
                  ),
                )),
              );
            }));
  }
}
