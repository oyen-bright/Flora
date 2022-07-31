import 'package:flora/screens/Shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flora/models/models.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flora/services/services.dart';

class MyListContentList extends StatelessWidget {
  final String title;
  final List<Content> myListContentList;
  final bool isOriginals;

  const MyListContentList({
    Key key,
    @required this.title,
    @required this.myListContentList,
    this.isOriginals = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final myListData = DatabaseService().getUsersMovieList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FutureBuilder(
            future: myListData,
            initialData: [],
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('No internet Connection')));
                } else if (snapshot.hasData) {
                  final data = snapshot.data;
                  if (data.length == 0) {
                    return Container(
                        width: screenSize.width,
                        child: Padding(
                          padding: const EdgeInsets.all(13),
                          child: Text(
                            'No movies in your Movie List',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ));
                  } else {
                    return Container(
                      height: isOriginals ? 500.0 : 220.0,
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 16.0,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            //final Content content = myListContentList[index];
                            Content newContent;
                            myListContentList.forEach((element) {
                              if (element.videoId == data[index]) {
                                print(element.name);
                                newContent = element;
                              }
                            });
                            return AnimationConfiguration.staggeredList(
                                position: index,
                                delay: Duration(milliseconds: 100),
                                child: SlideAnimation(
                                  duration: Duration(milliseconds: 2500),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  horizontalOffset: -250,
                                  child: ScaleAnimation(
                                      duration: Duration(microseconds: 2500),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      child: GestureDetector(
                                        onTap: () =>
                                            print("my list " + newContent.name),
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          height: isOriginals ? 350.0 : 200.0,
                                          width: isOriginals ? 250.0 : 130.0,
                                          // decoration: BoxDecoration(
                                          //   image: DecorationImage(
                                          //     image: AssetImage(
                                          //         newContent.imageUrl),
                                          //     fit: BoxFit.cover,
                                          //   ),
                                          // ),
                                          child: Image.network(
                                            newContent.imageUrl,
                                            fit: BoxFit.fill,
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent
                                                        loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
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
                                            errorBuilder: (context,
                                                Object exception,
                                                StackTrace stackTrace) {
                                              return Loading(
                                                size: 20,
                                                color: Colors.red,
                                              );
                                              //add a time to setstate
                                            },
                                          ),
                                        ),
                                      )),
                                ));
                          }),
                    );
                  }
                } else {
                  print('THE LIST IS EMPTY');
                }
              }
              return Center(
                child: Loading(
                  size: 25,
                  color: Colors.red,
                ),
                // ),
              );
            },
          )
        ],
      ),
    );
  }
}
