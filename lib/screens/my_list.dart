import 'package:flora/cubits/app_bar/app_bar_cubit.dart';
import 'package:flora/screens/Shared/loading.dart';
import 'package:flora/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:flora/models/content_model.dart';

class MyList extends StatefulWidget {
  MyList({Key key}) : super(key: key);

  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  bool thereIsData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  Widget getAppBar() {
    final Size screenSize = MediaQuery.of(context).size;

    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0.0,
      title: Text("My list"),
      actions: [
        IconButton(
            icon: Icon(
              Icons.delete_forever,
              color: Colors.white,
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
                                DatabaseService().deleteFromUserMovieList(
                                    deleteall: true, movieId: null);

                                setState(() {});

                                Navigator.pop(context);
                              },
                              child: Text('DELETE'))
                        ]);
                  });
            }),
      ],
    );
  }

  Widget getBody() {
    final Allmovies = Provider.of<List<Content>>(context);
    final myListData = DatabaseService().getUsersMovieList();
    var size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: myListData,
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            print(snapshot.error);
          } else if (snapshot.hasData) {
            final data = snapshot.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(data.length, (index) {
                Content newContent;
                Allmovies.forEach((element) {
                  if (element.videoId == data[index]) {
                    thereIsData = true;
                    print(element.name);
                    newContent = element;
                  }
                });
                return SingleChildScrollView(
                  child: AnimationConfiguration.staggeredList(
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
                              //what to do after slide dismissalm
                              DatabaseService().deleteFromUserMovieList(
                                  movieId: newContent.videoId,
                                  deleteall: false);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  _deleteSnackBar(newContent.name));
                            },
                          ),
                          key: UniqueKey(),
                          actionPane: const SlidableScrollActionPane(),
                          secondaryActions: [
                            IconSlideAction(
                                caption: 'Delete',
                                color: Colors.red,
                                icon: Icons.delete,
                                onTap: () {
                                  DatabaseService().deleteFromUserMovieList(
                                      movieId: newContent.videoId,
                                      deleteall: false);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      _deleteSnackBar(newContent.name));
                                  setState(() {});
                                })
                          ],
                          child: Container(
                            margin: const EdgeInsets.all(0.5),
                            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                            decoration: new BoxDecoration(
                                border: Border.all(color: Colors.black26)),
                            height: 150,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      Card(
                                        semanticContainer: true,
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: Image.network(
                                          newContent.imageUrl,
                                          fit: BoxFit.fill,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.red,
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes
                                                    : null,
                                              ),
                                            );
                                          },
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace stackTrace) {
                                            return Container(
                                              height: 130,
                                              child: Center(
                                                child: Loading(
                                                  color: Colors.red,
                                                  size: 25,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        elevation: 5,
                                        margin: EdgeInsets.only(left: 2),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: Column(
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 80,
                                            width: 280,
                                            child: ListTile(
                                              title: Text(
                                                newContent.name,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                              subtitle: Text(
                                                newContent.description,
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                              isThreeLine: true,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        25, 0, 0, 0),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        2, 5, 0, 0),
                                                child: Text(
                                                  newContent.category,
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          27, 1, 10, 0),
                                                  child: Text(
                                                    "₦" + "" + newContent.price,
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          }
        }
        return Center(
          // child: Padding(
          //   padding: EdgeInsets.only(
          //     top: MediaQuery.of(context).size.height / 9,
          //   ),
          child: Loading(
            size: 25,
            color: Colors.red,
          ),
          // ),
        );
      },
    );
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
}
