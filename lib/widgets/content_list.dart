import 'package:flora/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flora/models/models.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flora/screens/Shared/loading.dart';

class ContentList extends StatelessWidget {
  final String title;
  final List<Content> contentList;
  final bool isOriginals;
  final bool isforTrending;

  const ContentList({
    Key key,
    @required this.title,
    @required this.contentList,
    this.isOriginals = false,
    @required this.isforTrending,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Content> newContentList = [];

    if (isforTrending == true) {
      contentList.forEach((element) {
        if (element.isTrending == true) {
          newContentList.add(element);
        }
      });
    } else {
      contentList.forEach((element) {
        if (element.isTopMovie == true) {
          newContentList.add(element);
        }
      });
    }
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
          Container(
            height: isOriginals ? 400.0 : 220.0,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 16.0,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: newContentList.length,
              itemBuilder: (BuildContext context, int index) {
                final Content content = newContentList[index];
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
                            onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => MovieScreen(
                                            movieData: content,
                                          )))
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              height: isOriginals ? 350.0 : 200.0,
                              width: isOriginals ? 250.0 : 130.0,
                              decoration: BoxDecoration(
                                  // image: DecorationImage(
                                  //   image: AssetImage(content.imageUrl),
                                  //   fit: BoxFit.cover,
                                  // ),
                                  ),
                              child: Image.network(
                                content.imageUrl,
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
                                              loadingProgress.expectedTotalBytes
                                          : null,
                                    ),
                                  );
                                },
                                errorBuilder: (context, Object exception,
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
