import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:follow_up_clinic_app/src/bloc/cubit/homepage/homepage_cubit.dart';
import 'package:follow_up_clinic_app/src/view/preview_page.dart';
import 'package:photo_view/photo_view.dart';
import 'package:intl/intl.dart';

class HomeContentPage extends StatefulWidget {
  final dynamic state;
  const HomeContentPage({super.key, this.state});

  @override
  State<HomeContentPage> createState() => _HomeContentPage();
}

class _HomeContentPage extends State<HomeContentPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    final dynamic state = widget.state;

    return Expanded(
        child: RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () async {
        setState(() {
          return BlocProvider.of<HomepageCubit>(context).getMedicalHistory();
        });
      },
      child: ListView.builder(
          itemCount: state.data.length,
          itemBuilder: (BuildContext context, index) {
            return Card(
              margin: EdgeInsets.all(5),
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: Text(
                          style: Theme.of(context).textTheme.headlineSmall,
                          DateFormat().add_yMMMMd().format(
                              state.data[index]['created_at'].toDate())),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        'รายละเอียด',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    SizedBox(
                        height: 200,
                        child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemCount: state.data[index]['image'].length,
                            itemBuilder: (BuildContext context, ind) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PreviewPage(
                                              picture: state.data[index]
                                                  ['image'][ind]['url'])));
                                },
                                child: Container(
                                  height: 300,
                                  width: 200,
                                  margin: const EdgeInsets.only(right: 5),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(state.data[index]
                                              ['image'][ind]['url']))),
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      child: Text(
                                          (state.data[index]['image'][ind]
                                                  ['left_eye'])
                                              ? 'ตาซ้าย'
                                              : 'ตาขวา',
                                          style: TextStyle(
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .fontSize,
                                            color: Colors.white,
                                          )),
                                    ),
                                  ),
                                ),
                              );
                            })),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Text(
                        'คำอธิบาย',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const Divider(color: Colors.grey),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                      child: Text(
                        state.data[index]['description'],
                        maxLines: 10,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    ));
  }
}
