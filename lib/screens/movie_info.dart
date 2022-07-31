import 'package:flutter/material.dart';
import 'package:flora/models/models.dart';
import 'package:flora/data/data.dart';
import 'package:flora/screens/Shared/shared.dart';
import 'package:flora/data/data.dart';

class MovieInfo extends StatefulWidget {
  final Content movieContent;
  MovieInfo({
    Key key,
    @required this.movieContent,
  }) : super(key: key);

  @override
  _MovieInfoState createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  Widget getAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0.0,
      title: Text(
        widget.movieContent.name,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      actions: [],
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 330,
                  child: Stack(
                    children: [
                      Container(
                        // decoration: BoxDecoration(
                        //     image: DecorationImage(
                        //   scale: 2.0,
                        //   image: AssetImage(comingSoonJson[index]['img']),
                        // )),
                        child: Image.network(
                          'https://console.firebase.google.com/',
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
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2))),
                    ],
                  ),
                ),
                true
                    ? Column(children: [
                        SizedBox(
                          height: 20,
                        ),
                      ])
                    : Container(),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        " ",
                        style: TextStyle(color: Colors.white),
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Text(
                                "₦" + "" + widget.movieContent.price,
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 25,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Column(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.play_circle_outline,
                                    color: Colors.white,
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Play",
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
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    widget.movieContent.name,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    widget.movieContent.description,
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
                    widget.movieContent.category,
                    style: TextStyle(
                        fontSize: 12,
                        height: 1.4,
                        color: Colors.white.withOpacity(0.9)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
