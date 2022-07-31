import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flora/cubits/cubits.dart';
import 'package:flora/data/data.dart';
import 'package:flora/widgets/widgets.dart';

class ComingSoonScreen extends StatefulWidget {
  ComingSoonScreen({Key key}) : super(key: key);

  @override
  _ComingSoonScreenState createState() => _ComingSoonScreenState();
}

class _ComingSoonScreenState extends State<ComingSoonScreen> {
  ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        context.read<AppBarCubit>().setOffset(_scrollController.offset);
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Center(
        child: Text(
      "COMING SOON",
      style: TextStyle(color: Colors.white, fontSize: 20),
    ));
    // return Scaffold(
    //   backgroundColor: Colors.black,
    //   floatingActionButton: FloatingActionButton(
    //       backgroundColor: Colors.grey[850],
    //       child: const Icon(Icons.notifications),
    //       onPressed: (() => {print("My notificatioin on coming soon")})),
    //   appBar: PreferredSize(
    //     preferredSize: Size(screenSize.width, 50.0),
    //     child: BlocBuilder<AppBarCubit, double>(
    //       builder: (context, scrollOffset) {
    //         return AppBar(
    //           backgroundColor: Colors.black,
    //           elevation: 0.0,
    //           title: Text(
    //             "Coming Soon",
    //           ),
    //           actions: [
    //             IconButton(
    //                 icon: Icon(
    //                   Icons.person_outline,
    //                   size: 28,
    //                 ),
    //                 onPressed: () {}),
    //           ],
    //         );
    //       },
    //     ),
    //   ),
    //   body: getBody(),
    // );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.notifications_none_outlined,
                      size: 28,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Notifications",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withOpacity(0.9)),
                    )
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 22,
                  color: Colors.white.withOpacity(0.9),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(comingSoonJson.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 220,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        comingSoonJson[index]['img']),
                                    fit: BoxFit.cover)),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.2))),
                        ],
                      ),
                    ),
                    comingSoonJson[index]['duration']
                        ? Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Stack(
                                children: [
                                  Container(
                                    height: 2.5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.grey.withOpacity(0.7)),
                                  ),
                                  Container(
                                    width: size.width * 0.34,
                                    height: 2.5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.red.withOpacity(0.8)),
                                  )
                                ],
                              ),
                            ],
                          )
                        : Container(),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            comingSoonJson[index]['title_img'],
                            width: 120,
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Icon(
                                    Icons.notifications_none_outlined,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Remind me",
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.white),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Info",
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.white),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        comingSoonJson[index]['date'],
                        style: TextStyle(color: Colors.white.withOpacity(0.5)),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        comingSoonJson[index]['title'],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        comingSoonJson[index]['description'],
                        style: TextStyle(
                            height: 1.4, color: Colors.white.withOpacity(0.5)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        comingSoonJson[index]['type'],
                        style: TextStyle(
                            fontSize: 12,
                            height: 1.4,
                            color: Colors.white.withOpacity(0.9)),
                      ),
                    ),
                  ],
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
