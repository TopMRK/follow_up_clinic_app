import 'package:flutter/material.dart';
import 'package:follow_up_clinic_app/src/route/routes.dart';
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
    return Scaffold(
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
              begin:
                  Alignment.topCenter, // Set the start position of the gradient
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
              const Padding(
                padding: EdgeInsets.fromLTRB(50, 5, 0, 0),
                child: Text('คุณ'),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                child: const Text('ประวัติการรักษา'),
              ),
              Text(arg['uid']),
              // ListView.builder(
              //     itemCount: state.data.length,
              //     itemBuilder: (BuildContext context, index) {
              //       return Card(
              //         margin: EdgeInsets.all(5),
              //         child: Container(
              //           margin: EdgeInsets.all(10),
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Padding(
              //                 padding: EdgeInsets.all(0),
              //                 child: Text(
              //                     style:
              //                         Theme.of(context).textTheme.headlineSmall,
              //                     DateFormat().add_yMMMMd().format(state
              //                         .data[index]['created_at']
              //                         .toDate())),
              //               ),
              //               Container(
              //                 margin: const EdgeInsets.only(bottom: 5),
              //                 child: Text(
              //                   'รายละเอียด',
              //                   style: Theme.of(context).textTheme.bodyLarge,
              //                 ),
              //               ),
              //               SizedBox(
              //                   height: 200,
              //                   child: GridView.builder(
              //                       physics:
              //                           const NeverScrollableScrollPhysics(),
              //                       gridDelegate:
              //                           const SliverGridDelegateWithFixedCrossAxisCount(
              //                         crossAxisCount: 2,
              //                       ),
              //                       itemCount:
              //                           state.data[index]['image'].length,
              //                       itemBuilder: (BuildContext context, ind) {
              //                         return GestureDetector(
              //                           onTap: () {
              //                             Navigator.push(
              //                                 context,
              //                                 MaterialPageRoute(
              //                                     builder: (context) =>
              //                                         PreviewPage(
              //                                             picture: state.data[
              //                                                         index]
              //                                                     ['image'][ind]
              //                                                 ['url'])));
              //                           },
              //                           child: Container(
              //                             height: 300,
              //                             width: 200,
              //                             margin:
              //                                 const EdgeInsets.only(right: 5),
              //                             decoration: BoxDecoration(
              //                                 image: DecorationImage(
              //                                     fit: BoxFit.cover,
              //                                     image: NetworkImage(
              //                                         state.data[index]['image']
              //                                             [ind]['url']))),
              //                             child: Center(
              //                               child: Container(
              //                                 padding: const EdgeInsets.all(5),
              //                                 decoration: const BoxDecoration(
              //                                   color: Colors.black,
              //                                   borderRadius: BorderRadius.all(
              //                                       Radius.circular(15)),
              //                                 ),
              //                                 child: Text(
              //                                     (state.data[index]['image']
              //                                             [ind]['left_eye'])
              //                                         ? 'ตาซ้าย'
              //                                         : 'ตาขวา',
              //                                     style: TextStyle(
              //                                       fontSize: Theme.of(context)
              //                                           .textTheme
              //                                           .bodyLarge!
              //                                           .fontSize,
              //                                       color: Colors.white,
              //                                     )),
              //                               ),
              //                             ),
              //                           ),
              //                         );
              //                       })),
              //               Padding(
              //                 padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              //                 child: Text(
              //                   'คำอธิบาย',
              //                   style: Theme.of(context).textTheme.bodyLarge,
              //                 ),
              //               ),
              //               const Divider(color: Colors.grey),
              //               Padding(
              //                 padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
              //                 child: Text(
              //                   state.data[index]['description'],
              //                   maxLines: 10,
              //                   overflow: TextOverflow.fade,
              //                   softWrap: false,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       );
              //     })
            ],
          ),
        ),
      ],
    ));
  }
}
