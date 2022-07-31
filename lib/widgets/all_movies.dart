import 'package:flora/screens/Shared/loading.dart';
import 'package:flora/screens/movie_screen.dart';
import 'package:flutter/material.dart';
import 'package:flora/models/models.dart';

//put grid or single file in the all movie

class AllMoviesList extends StatefulWidget {
  final String title;
  final List<Content> contentList;
  final bool isOriginals;
  final bool isNav;

  const AllMoviesList({
    Key key,
    @required this.isNav,
    @required this.title,
    @required this.contentList,
    this.isOriginals = false,
  }) : super(key: key);

  @override
  State<AllMoviesList> createState() => _AllMoviesListState();
}

class _AllMoviesListState extends State<AllMoviesList> {
  bool isGrid = true;

  @override
  Widget build(BuildContext context) {
    Orientation orn = MediaQuery.of(context).orientation;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
                child: Container(
              alignment: Alignment.centerRight,
              child: IconButton(
                  onPressed: () => setState(() {
                        isGrid = !isGrid;
                      }),
                  icon: Icon(
                    orn == Orientation.portrait
                        ? isGrid
                            ? Icons.list
                            : Icons.grid_on
                        : null,
                    color: Colors.white,
                  )),
            ))
          ]),
          Container(
            height: widget.isOriginals
                ? 500.0
                // : MediaQuery.of(context).size.height / 1.10,
                : widget.isNav
                    ? MediaQuery.of(context).size.height / 1.20
                    : MediaQuery.of(context).size.height / 1.10,
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: 22.0,
                horizontal: 5.0,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: orn == Orientation.portrait && isGrid == true
                      ? 2
                      : orn == Orientation.portrait && isGrid == false
                          ? 1
                          : 4,
                  childAspectRatio: 0.6),
              itemCount: widget.contentList.length,
              itemBuilder: (BuildContext context, int index) {
                final Content content = widget.contentList[index];
                return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MovieScreen(
                                  movieData: content,
                                ))),
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 6, right: 1, left: 1, bottom: 3),
                      child: Container(
                        // margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        // height: isOriginals ? 400.0 : 400.0,
                        // width: isOriginals ? 200.0 : 330.0,

                        decoration: BoxDecoration(
                            // image: DecorationImage(
                            //   image: NetworkImage(content.imageUrl ),

                            //   fit: BoxFit.fill,
                            // ),
                            ),
                        child: Image.network(
                          content.imageUrl,
                          fit: BoxFit.fill,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.red,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (BuildContext context, Object exception,
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
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
