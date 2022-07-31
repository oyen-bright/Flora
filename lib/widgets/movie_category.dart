import 'package:flora/screens/movie_screen.dart';
import 'package:flora/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flora/models/models.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flora/services/database.dart';
import 'package:flora/screens/Shared/loading.dart';

class MovieCategory extends StatelessWidget {
  final bool isOriginals;
  final List<String> categories;

  const MovieCategory({
    Key key,
    @required this.categories,
    this.isOriginals = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(categories.length, (index) {
      final currentCatContent =
          DatabaseService().getData(category: categories[index]);
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  categories[index],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SeeAll(
                          title: categories[index],
                          contentList: currentCatContent);
                    }))
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text('See All',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.blue,
                        )),
                  ),
                ),
              )
            ]),
            FutureBuilder(
              future: currentCatContent,
              initialData: [],
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                  } else if (snapshot.hasData) {
                    final data = snapshot.data;
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
                              final Content content = data[index];
                              return AnimationConfiguration.staggeredList(
                                  position: index,
                                  delay: Duration(milliseconds: 50),
                                  child: SlideAnimation(
                                      duration: Duration(milliseconds: 2500),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      horizontalOffset: -250,
                                      child: ScaleAnimation(
                                          duration:
                                              Duration(microseconds: 2500),
                                          curve: Curves.fastLinearToSlowEaseIn,
                                          child: GestureDetector(
                                            onTap: () => {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          MovieScreen(
                                                            movieData: content,
                                                          )))
                                            },
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              height:
                                                  isOriginals ? 400.0 : 200.0,
                                              width:
                                                  isOriginals ? 200.0 : 130.0,
                                              // decoration: BoxDecoration(
                                              //   image: DecorationImage(
                                              //     image: AssetImage(
                                              //         content.imageUrl),
                                              //     fit: BoxFit.cover,
                                              //   ),
                                              child: Image.network(
                                                content.imageUrl,
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
                                                errorBuilder:
                                                    (BuildContext context,
                                                        Object exception,
                                                        StackTrace stackTrace) {
                                                  return Center(
                                                    child: Loading(
                                                      color: Colors.red,
                                                      size: 25,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ))));
                            }));
                  }
                }
                return Center(
                  child: Loading(
                    color: Colors.white,
                    size: 25,
                  ),
                );
              },
            )
          ]));
    }));
  }
}
