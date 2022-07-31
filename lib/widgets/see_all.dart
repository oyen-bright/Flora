import 'package:flora/widgets/content_list.dart';
import 'package:flutter/material.dart';
import 'package:flora/screens/Shared/loading.dart';
import 'package:flora/models/models.dart';

class SeeAll extends StatefulWidget {
  final String title;
  final String price;
  final Future contentList;
  final bool isOriginals;
  const SeeAll({
    Key key,
    this.title,
    this.price,
    this.contentList,
    this.isOriginals = false,
  }) : super(key: key);

  @override
  State<SeeAll> createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  bool isGrid = true;
  int axisCount = 2;
  @override
  Widget build(BuildContext context) {
    Orientation orn = MediaQuery.of(context).orientation;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(widget.title),
          actions: [
            // IconButton(
            //     onPressed: () => setState(() {
            //           isGrid = !isGrid;
            //         }),
            //     icon: Icon(
            //       orn == Orientation.portrait
            //           ? isGrid
            //               ? Icons.list
            //               : Icons.grid_on
            //           : null,
            //       color: Colors.white,
            //     ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                  future: widget.contentList,
                  initialData: [],
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                      } else if (snapshot.hasData) {
                        final data = snapshot.data;
                        return Container(
                          height: widget.isOriginals
                              ? 500.0
                              : MediaQuery.of(context).size.height / 1.2,
                          child: GridView.builder(
                            padding: const EdgeInsets.symmetric(
                              vertical: 22.0,
                              horizontal: 5.0,
                            ),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        orn == Orientation.portrait &&
                                                isGrid == true
                                            ? 2
                                            : orn == Orientation.portrait &&
                                                    isGrid == false
                                                ? 1
                                                : 4,
                                    childAspectRatio: 0.6),
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              final Content content = data[index];
                              return GestureDetector(
                                onTap: () => print("my list " + content.name),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 6, right: 7, left: 4, bottom: 3),
                                  child: Container(
                                    // margin: const EdgeInsets.symmetric(horizontal: 8.0),
                                    // height: isOriginals ? 400.0 : 400.0,
                                    // width: isOriginals ? 200.0 : 330.0,

                                    // decoration: BoxDecoration(
                                    //   image: DecorationImage(
                                    //     image: AssetImage(content.imageUrl),
                                    //     fit: BoxFit.fill,
                                    //   ),
                                    // ),
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
                                                    loadingProgress
                                                        .expectedTotalBytes
                                                : null,
                                          ),
                                        );
                                      },
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace stackTrace) {
                                        return Center(
                                          child: Loading(
                                            size: 25,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    }
                    return Center(
                      child: Loading(
                        size: 25,
                      ),
                    );
                  }),
            ],
          ),
        ));
  }
}
