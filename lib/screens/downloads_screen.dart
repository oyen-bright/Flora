import 'dart:io';
import 'package:flora/assets.dart';
import 'package:flora/services/local_database.dart';
import 'package:flora/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flora/cubits/cubits.dart';
import 'package:flora/models/models.dart';
import 'package:flora/screens/home_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

//WORK ON THE SCAFFOLD COLOR CHANGE FORM BLACK TO GREY AND VIS VERSA;
//CHANGE THE PLAY BUTTON TO DELETE AND MAKE A TOAST ON TAP OF THE BUTTON;

class DownloadScreen extends StatefulWidget {
  DownloadScreen({Key key}) : super(key: key);

  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  ScrollController _scrollController;
  Color scaffoldColor;

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
    void _deleteVideo(String vidoUrl) async {
      String dir = (await getApplicationDocumentsDirectory()).path;
      print(dir);

      File file = new File(vidoUrl);
      try {
        await file.delete();
      } catch (e) {
        print(e.toString());
      }
    }

    List dellist = [];

    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: scaffoldColor,
        appBar: PreferredSize(
            preferredSize: Size(screenSize.width, 50.0),
            child: BlocBuilder<AppBarCubit, double>(
                builder: (context, scrollOffset) {
              return AppBar(
                //CENTER THE APPBAR TEXT
                backgroundColor: Colors.black,
                elevation: 0.0,
                title: Text("My Downloads"),
                actions: [
                  IconButton(
                      icon: Icon(
                        Icons.delete_forever,
                        size: 28,
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  backgroundColor: Colors.black87,
                                  title: Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  content: Text(
                                    "Delete All Movies ?",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      textColor: Colors.white,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('CANCEL'),
                                    ),
                                    FlatButton(
                                        textColor: Colors.red,
                                        onPressed: () {
                                          setState(() {
                                            scaffoldColor = Colors.grey;
                                          });
                                          DBProvider.db.deleteAll();
                                          if (dellist.isEmpty) {
                                          } else {
                                            print('this is the dellist one' +
                                                dellist[0]);
                                          }
                                          Navigator.pop(context);
                                        },
                                        child: Text('DELETE'))
                                  ]);
                            });
                      }),
                ],
              );
            })),
        body: FutureBuilder<List<Content>>(
            future: DBProvider.db.getAllClients(),
            initialData: null,
            builder:
                (BuildContext context, AsyncSnapshot<List<Content>> snapshot) {
              if (snapshot.hasData) {
                for (int i = 0; i < snapshot.data.length; i++) {
                  Content testmovie = snapshot.data[i];
                  print(testmovie.videoUrl);
                  print(i);
                  dellist.add(testmovie.videoUrl);
                  // print("This is the movie urls" + movie.videoUrl);
                }
                if (snapshot.data.length == 0) {
                  return ListView(children: <Widget>[downloadPage(screenSize)]);
                } else {
                  return AnimationLimiter(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        Content movie = snapshot.data[index];
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          delay: Duration(milliseconds: 100),
                          child: SlideAnimation(
                            duration: Duration(milliseconds: 2500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            verticalOffset: -250,
                            child: ScaleAnimation(
                              duration: Duration(microseconds: 2500),
                              curve: Curves.fastLinearToSlowEaseIn,
                              child: Slidable(
                                dismissal: SlidableDismissal(
                                    child: SlidableDrawerDismissal(),
                                    onDismissed: (direction) {
                                      DBProvider.db.deleteClient(movie.videoId);
                                      _deleteVideo(movie.videoUrl);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              _deleteSnackBar(movie.name));
                                    }),
                                key: UniqueKey(),
                                actionPane: const SlidableScrollActionPane(),
                                secondaryActions: [
                                  IconSlideAction(
                                      caption: 'Delete',
                                      color: Colors.red,
                                      icon: Icons.delete,
                                      onTap: () {
                                        DBProvider.db
                                            .deleteClient(movie.videoId);
                                        print(movie.videoUrl);
                                        _deleteVideo(movie.videoUrl);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                                _deleteSnackBar(movie.name));
                                        setState(() {});
                                      })
                                ],
                                child: GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(movie.name)));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 0,
                                      right: 13,
                                      left: 13,
                                      top: 22,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: (screenSize.width - 30) *
                                                  0.85,
                                              height: 100,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 150,
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          width: 150,
                                                          height: 90,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              image: DecorationImage(
                                                                  image: AssetImage(
                                                                      Assets
                                                                          .atla),
                                                                  fit: BoxFit
                                                                      .cover)),
                                                        ),
                                                        Container(
                                                          width: 150,
                                                          height: 90,
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.3)),
                                                        ),
                                                        Positioned(
                                                          top: 30,
                                                          left: 57,
                                                          child: Container(
                                                            width: 38,
                                                            height: 38,
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                border: Border.all(
                                                                    width: 2,
                                                                    color: Colors
                                                                        .white),
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.4)),
                                                            child: Center(
                                                              child: Icon(
                                                                Icons
                                                                    .play_arrow,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: (screenSize.width) *
                                                        0.35,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            movie.name,
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                height: 1.3,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.9)),
                                                          ),
                                                          SizedBox(
                                                            height: 3,
                                                          ),
                                                          Text(
                                                            'duration',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.5)),
                                                          ),
                                                          SizedBox(
                                                            height: 3,
                                                          ),
                                                          Text(
                                                            'Category',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.5)),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: (screenSize.width - 30) *
                                                  0.15,
                                              height: 100,
                                              child: Center(
                                                child: Icon(
                                                  Icons.play_arrow,
                                                  color: Colors.white
                                                      .withOpacity(0.7),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'A preview of the moviw you about to watch A preview of the moviw you about to watch A preview of the moviw you about to watch A preview of the moviw you about to watch',
                                          style: TextStyle(
                                              height: 1.4,
                                              color: Colors.white
                                                  .withOpacity(0.5)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));

    // body: ListView(children: <Widget>[downloadPage(screenSize)]));
  }

  SnackBar _deleteSnackBar(movieName) {
    return SnackBar(
        backgroundColor: Colors.black,
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                Icons.delete_forever,
                size: 24,
                color: Colors.white,
              ),
            ),
            Expanded(
                child: Text(
              movieName + " : " + 'Deleted',
              style: TextStyle(fontSize: 14),
            )),
          ],
        ),
        action: SnackBarAction(label: 'Ok', onPressed: () {}));
  }

  Widget downloadPage(Size screenSize) {
    scaffoldColor = Colors.grey;
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 60,
        ),
        Column(
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.black.withOpacity(0.2)),
              child: Center(
                child: Icon(
                  Icons.file_download,
                  size: 80,
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Never be without flora",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Text(
                "Download movies so you'll never be without something to watch even when you're offline",
                style: TextStyle(
                  height: 1.5,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => HomeScreen()));
                },
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Center(
                    child: Text(
                      "See What You Can Download",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
        //Spacer()
      ],
    );
  }
}
