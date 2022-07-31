import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flora/screens/Shared/loading.dart';
import 'package:flora/services/local_database.dart';
import 'package:flora/services/services.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flora/cubits/cubits.dart';
import 'package:flora/models/models.dart';
import 'package:flutterwave/core/flutterwave.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:flora/data/data.dart';
import 'package:chewie/chewie.dart';

class MovieScreen extends StatefulWidget {
  final Content movieData;
  MovieScreen({Key key, this.movieData}) : super(key: key);

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController;
  final _formKeyy = GlobalKey<FormState>();
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  int activeEpisode = 0;
  bool isMoviesPaidfor = false;

  bool isPlayingMode = false;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        context.read<AppBarCubit>().setOffset(_scrollController.offset);
      });
    super.initState();
    //_videoPlayerController = VideoPlayerController.asset(Assets.videoTestUrl)
    // _videoPlayerController = VideoPlayerController.file(
    //     File(' /data/user/0/com.brinnixs.flora/app_flutter/Sintel'))
    print('DSFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF');

    if (!isPlayingMode) {
      try {
        _videoPlayerController =
            VideoPlayerController.network(widget.movieData.videoPreviewUrl)
              ..initialize().then((_) {
                print('video player Package');
                setState(() {
                  _videoPlayerController.play();
                });
              });
      } catch (e) {
        print(e.toString());
      }
    } else {
      _videoPlayerController =
          VideoPlayerController.network(widget.movieData.videoUrl)
            ..initialize();
      print(widget.movieData.videoUrl);
      print('Cheiwe Packages');
    }

    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        looping: true,
        errorBuilder: (context, errorMessage) {
          print(errorMessage);
          return Center(
              child: Loading(
            size: 45,
            color: Colors.white,
          ));
        });

    // var playerWidget = Chewie(
    //   controller: chewieController,
    // );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _chewieController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  //cHANGE THE NAIRA ASSET IMAGE TO TEXT

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    final Size screenSize = MediaQuery.of(context).size;
    final movieMetaData = DatabaseService().getPaidMovieList();
    print(DatabaseService().getData(category: 'Comedy'));

    //getDirectory();
    // for (int i = 0; i < 10; i++) {
    //   DBProvider.db.newMovie(Content(
    //       name: 'otherdelete',
    //       imageUrl:
    //           'https://firebasestorage.googleapis.com/v0/b/flora-media-limited.appspot.com/o/Movies%2Fimages%2FheaderImages%2Fsintel.jpg?alt=media&token=92053fe0-63b8-4e4a-8c42-6ef4ecc1ce4a',
    //       noDownload: "0",
    //       price: '20',
    //       titleImageUrl:
    //           'https://firebasestorage.googleapis.com/v0/b/flora-media-limited.appspot.com/o/Movies%2Fimages%2FheaderImages%2Fsintel_title.png?alt=media&token=6b69b70c-e373-45a9-ad7a-e60acae62cf1',
    //       videoId: 'znDZ8UolhSWlxUDrP0te+bjjtb+$i',
    //       videoUrl: '/data/user/0/com.brinnixs.flora/app_flutter/testdownload',
    //       description:
    //           ' A lonely young woman, Sintel, helps and befriends a dragon,\nwhom she calls Scales. But when he is kidnapped by an adult\ndragon, Sintel decides to embark on a dangerous quest to find\nher lost friend Scales.',
    //       category: 'Adventure'));
    // }

    return Scaffold(
        key: this._scaffoldKey,
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.black,
        appBar: PreferredSize(
            preferredSize: Size(screenSize.width, 30.0),
            child: AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              actions: [
                // IconButton(
                //     icon: Icon(
                //       Icons.add,
                //       size: 28,
                //     ),
                //     onPressed: () {}),
              ],
            )),
        body: ListView(children: [movieDetails()]));
  }

  Widget movieDetails() {
    final movieMetaData = DatabaseService().getPaidMovieList();
    final othersLikethis = DatabaseService().getData(category: 'Comedy');

    Content testMovie = Content(
        name: 'Sintel',
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/flora-media-limited.appspot.com/o/Movies%2Fimages%2FheaderImages%2Fsintel.jpg?alt=media&token=92053fe0-63b8-4e4a-8c42-6ef4ecc1ce4a',
        noDownload: "0",
        price: '20',
        titleImageUrl:
            'https://firebasestorage.googleapis.com/v0/b/flora-media-limited.appspot.com/o/Movies%2Fimages%2FheaderImages%2Fsintel_title.png?alt=media&token=6b69b70c-e373-45a9-ad7a-e60acae62cf1',
        videoId: 'znDZ8UolhSWlxUDrP0te',
        videoUrl:
            'https://firebasestorage.googleapis.com/v0/b/flora-media-limited.appspot.com/o/Movies%2Fvideos%2FPenguins_of_Madagascar.m4v?alt=media&token=43587220-dcbf-4277-ae3b-c52434adcec1',
        description:
            ' A lonely young woman, Sintel, helps and befriends a dragon,\nwhom she calls Scales. But when he is kidnapped by an adult\ndragon, Sintel decides to embark on a dangerous quest to find\nher lost friend Scales.',
        category: 'Adventure');

    var size = MediaQuery.of(context).size;

    bool isMute = false;
    return Container(
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          !isPlayingMode
              ? _videoPlayerController.value.isInitialized
                  ? Container(
                      height: 320,
                      child: Stack(
                        children: [
                          AspectRatio(
                            aspectRatio:
                                _videoPlayerController.value.aspectRatio,
                            child: VideoPlayer(_videoPlayerController),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.2))),
                          AspectRatio(
                            aspectRatio:
                                _videoPlayerController.value.aspectRatio,
                            child: Center(
                              child: IconButton(
                                icon: Icon(
                                  _videoPlayerController.value.isPlaying
                                      ? null
                                      : Icons.play_arrow,
                                  size: 50,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _videoPlayerController.value.isPlaying
                                        ? _videoPlayerController.pause()
                                        : _videoPlayerController.play();
                                  });
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            left: 5,
                            bottom: 20,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 13, left: 13, top: 8, bottom: 8),
                                child: Row(
                                  children: [
                                    !isPlayingMode
                                        ? Text(
                                            "Preview",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          )
                                        : Container()
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 5,
                            bottom: 10,
                            child: !isPlayingMode
                                ? Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: IconButton(
                                        onPressed: (() => {
                                              setState(() {
                                                _videoPlayerController
                                                            .value.volume ==
                                                        1
                                                    ? _videoPlayerController
                                                        .setVolume(0)
                                                    : _videoPlayerController
                                                        .setVolume(1);
                                              }),
                                            }),
                                        icon: Icon(
                                          _videoPlayerController.value.volume ==
                                                  1
                                              ? Icons.volume_mute
                                              : Icons.volume_off,
                                          color: Colors.white,
                                          size: 19,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                          )
                        ],
                      ),
                    )
                  : Container(
                      height: 220,
                      child: Stack(
                        children: [
                          // Container(
                          //   decoration: BoxDecoration(
                          //       image: DecorationImage(
                          //           image: AssetImage("assets/images/banner.webp"),
                          //           fit: BoxFit.cover)),
                          // ),
                          Loading(
                            color: Colors.white,
                            size: 45,
                          )
                        ],
                      ),
                    )
              : Container(
                  height: 220,
                  child: Stack(children: [
                    AspectRatio(
                      aspectRatio: _videoPlayerController.value.aspectRatio,
                      child: Chewie(
                        controller: _chewieController,
                      ),
                    )
                  ]),
                ),
          Container(
            height: size.height - 280,
            child: SingleChildScrollView(
              child: FutureBuilder(
                  future: movieMetaData,
                  initialData: [],
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return Loading(
                          size: 25,
                          color: Colors.white,
                        );
                      } else if (snapshot.hasData) {
                        final data = snapshot.data;
                        print(data);
                        List paidList = data;
                        print(data.runtimeType);
                        paidList.forEach((element) {
                          print(widget.movieData.videoId);
                          if (element == widget.movieData.videoId) {
                            isMoviesPaidfor = true;
                          }
                        });
                        print(isMoviesPaidfor);
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 15, right: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.movieData.name,
                                style: TextStyle(
                                    height: 1.4,
                                    fontSize: 28,
                                    color: Colors.white.withOpacity(0.9),
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "New",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    "2021",
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.5),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: Colors.white.withOpacity(0.2)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 6, right: 6, top: 4, bottom: 4),
                                      child: Text(
                                        "18+",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  // Container(
                                  //   child: Column(
                                  //     children: [
                                  //       Image(
                                  //           height: 25,
                                  //           image: AssetImage('assets/images/naira.png'))
                                  //     ],
                                  //   ),
                                  // ),
                                  !isMoviesPaidfor
                                      ? Text(
                                          "₦" + "" + widget.movieData.price,
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 25,
                                          ),
                                        )
                                      : SizedBox(),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        border: Border.all(
                                            width: 2,
                                            color:
                                                Colors.white.withOpacity(0.2))),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4, right: 4, top: 2, bottom: 2),
                                      child: Text(
                                        "HD",
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.6),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Watch Now",
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (!isMoviesPaidfor) {
                                    this
                                        ._scaffoldKey
                                        .currentState
                                        .showBottomSheet((ctx) =>
                                            _paymentBottomnSheet(ctx,
                                                formkey: _formKeyy));
                                  } else if (isPlayingMode) {
                                    setState(() {
                                      _chewieController.pause();
                                    });
                                  } else {
                                    setState(() {
                                      isPlayingMode = !isPlayingMode;
                                    });
                                  }
                                },
                                // onTap: () {
                                //   _printAllLocalDatabase();
                                // },
                                child: Container(
                                  width: size.width,
                                  height: 38,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.white),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      isMoviesPaidfor
                                          ? !isPlayingMode
                                              ? Icon(
                                                  Icons.play_arrow,
                                                  color: Colors.black,
                                                )
                                              : Icon(
                                                  Icons.pause,
                                                  color: Colors.black,
                                                )
                                          : Icon(
                                              Icons.payment,
                                              color: Colors.black,
                                            ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      isMoviesPaidfor
                                          ? !isPlayingMode
                                              ? Text(
                                                  "Play",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                )
                                              : Text(
                                                  "Pause",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                )
                                          : Text(
                                              "Make payment",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              GestureDetector(
                                onTap: () {
                                  isMoviesPaidfor
                                      ? print('thils')
                                      : this
                                          ._scaffoldKey
                                          .currentState
                                          .showBottomSheet((ctx) =>
                                              _paymentBottomnSheet(ctx,
                                                  formkey: _formKeyy));
                                },
                                child: Container(
                                  width: size.width,
                                  height: 38,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.grey.withOpacity(0.3)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.file_download,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Download",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.movieData.subName,
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: (size.width - 30) * 0.75,
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: (size.width - 30) * 0.75,
                                          height: 2.5,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color:
                                                  Colors.grey.withOpacity(0.5)),
                                        ),
                                        Container(
                                          width: 248,
                                          height: 2.5,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color:
                                                  Colors.red.withOpacity(0.8)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "35m remaining",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 10),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                widget.movieData.description,
                                style: TextStyle(
                                    height: 1.4,
                                    color: Colors.white.withOpacity(0.9)),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  RatingBar.builder(
                                    unratedColor: Colors.grey,
                                    glowColor: Colors.red,
                                    initialRating: _getRatingfromSnapshots(
                                        widget.movieData),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    updateOnDrag: true,
                                    itemSize: 20,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      DatabaseService().updateMovieRating(
                                          movieId: widget.movieData.videoId,
                                          noOfRatings: widget
                                              .movieData.rating['noOfRatings'],
                                          totalRatings: (double.parse(widget
                                                      .movieData
                                                      .rating['totalRatings']) +
                                                  rating)
                                              .toString());
                                    },
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: size.width - 270),
                                    child: Row(
                                      children: List.generate(likesList.length,
                                          (index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(left: 0),
                                          child: Column(
                                            children: [
                                              IconButton(
                                                padding: EdgeInsets.all(0),
                                                icon: Icon(
                                                  likesList[index]['icon'],
                                                  size: 20,
                                                  color: Colors.white
                                                      .withOpacity(0.9),
                                                ),
                                                onPressed: () =>
                                                    DatabaseService()
                                                        .updateUserMovieList(
                                                            movieId: widget
                                                                .movieData
                                                                .videoId),
                                              ),
                                              // SizedBox(
                                              //   height: 1,
                                              // ),
                                              Text(likesList[index]['text'],
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      height: 1.4,
                                                      color: Colors.grey
                                                          .withOpacity(0.9)))
                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(episodesList.length,
                                      (index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          activeEpisode = index;
                                        });
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 25),
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      top: BorderSide(
                                                          width: 4,
                                                          color: activeEpisode ==
                                                                  index
                                                              ? Colors.red
                                                                  .withOpacity(
                                                                      0.8)
                                                              : Colors
                                                                  .transparent))),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 12),
                                                child: Text(
                                                  episodesList[index],
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: activeEpisode ==
                                                              index
                                                          ? Colors.white
                                                              .withOpacity(0.9)
                                                          : Colors.white
                                                              .withOpacity(0.5),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              FutureBuilder(
                                future: othersLikethis,
                                initialData: [],
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    // If we got an error
                                    if (snapshot.hasError) {
                                      return Loading(
                                        size: 25,
                                        color: Colors.red,
                                      );
                                      // return Center(
                                      //   child: Text(
                                      //     '${snapshot.error} occured',
                                      //     style: TextStyle(fontSize: 18),
                                      //   ),
                                      // );

                                      // if we got our data
                                    } else if (snapshot.hasData) {
                                      // Extracting data from snapshot object
                                      final data = snapshot.data;
                                      return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: List.generate(data.length,
                                              (index) {
                                            final Content content = data[index];
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 20),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () => Navigator
                                                            .pushReplacement(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (_) =>
                                                                        MovieScreen(
                                                                          movieData:
                                                                              content,
                                                                        ))),
                                                        child: Container(
                                                          width: (size.width -
                                                                  30) *
                                                              0.85,
                                                          height: 100,
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                width: 150,
                                                                child: Stack(
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          150,
                                                                      height:
                                                                          90,
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                      child: Image
                                                                          .network(
                                                                        content
                                                                            .imageUrl,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        loadingBuilder: (BuildContext context,
                                                                            Widget
                                                                                child,
                                                                            ImageChunkEvent
                                                                                loadingProgress) {
                                                                          if (loadingProgress ==
                                                                              null) {
                                                                            return child;
                                                                          }
                                                                          return Center(
                                                                            child:
                                                                                CircularProgressIndicator(
                                                                              color: Colors.red,
                                                                              value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes : null,
                                                                            ),
                                                                          );
                                                                        },
                                                                        errorBuilder: (BuildContext context,
                                                                            Object
                                                                                exception,
                                                                            StackTrace
                                                                                stackTrace) {
                                                                          return Center(
                                                                              child: Loading(
                                                                            color:
                                                                                Colors.white,
                                                                            size:
                                                                                20,
                                                                          ));
                                                                        },
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width:
                                                                          150,
                                                                      height:
                                                                          90,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .black
                                                                              .withOpacity(0.3)),
                                                                    ),
                                                                    Positioned(
                                                                      top: 30,
                                                                      left: 57,
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            38,
                                                                        height:
                                                                            38,
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            border: Border.all(width: 2, color: Colors.white),
                                                                            color: Colors.black.withOpacity(0.4)),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Icon(
                                                                            Icons.play_arrow,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                width: (size
                                                                        .width) *
                                                                    0.35,
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
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
                                                                        content
                                                                            .name,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15,
                                                                            height:
                                                                                1.3,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            color: Colors.white.withOpacity(0.9)),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            3,
                                                                      ),
                                                                      Text(
                                                                        content
                                                                            .dateUploaded,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Colors.white.withOpacity(0.5)),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                            (size.width - 30) *
                                                                0.15,
                                                        height: 100,
                                                        child: Center(
                                                          child: Icon(
                                                            Icons.file_download,
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.7),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    widget
                                                        .movieData.description,
                                                    style: TextStyle(
                                                        height: 1.4,
                                                        color: Colors.white
                                                            .withOpacity(0.5)),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }));
                                    }
                                  }

                                  // Displaying LoadingSpinner to indicate waiting state
                                  return Center(
                                    child: Loading(
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        );
                      }
                    }
                    return Center(
                      child: Loading(
                        color: Colors.white,
                        size: 25,
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }

  Container _paymentBottomnSheet(BuildContext context, {formkey}) {
    String userEmail = AuthServices().getUserEmaill();
    print(userEmail);

    final Size screenSize = MediaQuery.of(context).size;
    TextEditingController _email = TextEditingController();
    _email = new TextEditingController(text: userEmail);

    String _ref;
    void setRef() {
      Random rand = Random();
      int number = rand.nextInt(2000);
      if (Platform.isAndroid) {
        setState(() {
          _ref = "AndriodRef123456789$number";
        });
      } else {
        setState(() {
          _ref = "IOSRef123456789$number";
        });
      }
    }

    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            foregroundColor: Colors.black,
            backgroundColor: Color.fromRGBO(252, 241, 201, 1),
            title: Text(
              "Make Payment",
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: ListView(children: [
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(bottom: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                // AssetImage(assetName)
                                SizedBox(height: 69),
                                Row(
                                  children: [
                                    Text(
                                      "₦" + " ",
                                      style: TextStyle(
                                          fontSize: 35,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      widget.movieData.price,
                                      style: TextStyle(
                                          fontSize: 35,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                )
                              ],
                            )),
                        Container(
                            margin: const EdgeInsets.only(top: 3),
                            child: Form(
                              key: _formKeyy,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter your Email';
                                  } else if (!isValidEmail(value)) {
                                    return 'Invalid Email';
                                  }
                                  return null;
                                },
                                controller: _email,
                                decoration: InputDecoration(labelText: "Email"),
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height / 2 / 5.7,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_formKeyy.currentState.validate()) {
                        final email = _email.text;
                        _makePayment(context, email.trim(),
                            widget.movieData.price.trim());
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      color: Color.fromRGBO(252, 241, 201, 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.payment),
                          SizedBox(
                            height: 2,
                            width: 8,
                          ),
                          Text(
                            "Pay Now",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ])),
    );
  }

  bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  void _makePayment(BuildContext context, String email, String amount) async {
    final flutterwave = Flutterwave.forUIPayment(
        amount: '100',
        currency: 'NGN',
        context: this.context,
        publicKey: 'FLWPUBK_TEST-218e84ac9077b89967f15d69489513b9-X',
        encryptionKey: 'FLWSECK_TEST2a793c92a383',
        email: email,
        fullName: "Flora Media",
        txRef: DateTime.now().toIso8601String(),
        narration: "Flora Media Payment",
        isDebugMode: true,
        phoneNumber: '0123456789',
        acceptAccountPayment: true,
        acceptCardPayment: true,
        acceptUSSDPayment: true);
    final response = await flutterwave.initializeForUiPayments();
    if (response != null) {
      print(
          '-----------------------------MAKE PAYMENT--------------------------');
      print(response.message);
      print(response.status);
      print(
          '-----------------------------MAKE PAYMENT--------------------------');
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('PAYMENT SUCESSFUL')));
      setState(() {});
      try {
        DatabaseService()
            .updateUserPaidMovieList(movieId: widget.movieData.videoId);
      } catch (e) {
        print(e.toString());
      }
    } else {
      print(
          '-----------------------------MAKE PAYMENT--------------------------');
      print('error');
      try {
        print(response.message);
      } catch (e) {
        print(e.toString());
      }
      print(
          '-----------------------------MAKE PAYMENT--------------------------');
    }
  }

  // ignore: missing_return
  Future _downloadVideo(Content movie) async {
    try {
      String dir = (await getApplicationDocumentsDirectory()).path;
      var httpClient = http.Client();
      var request = new http.Request('GET', Uri.parse(movie.videoUrl));
      var requestImage = new http.Request('GET', Uri.parse(movie.imageUrl));
      var response = httpClient.send(request);
      var responseImage = httpClient.send(request);

      List<List<int>> chunks = new List();
      int downloaded = 0;

      List<List<int>> chunks2 = new List();
      int downloadedImagePercent = 0;

      response.asStream().listen((http.StreamedResponse r) async {
        r.stream.listen((List<int> chunks2) {
          // Display percentage of completion
          print(
              'downloadPercentage: ${downloadedImagePercent / r.contentLength * 100}');

          chunks.add(chunks2);
          downloaded += chunks2.length;
        }, onDone: () async {
          // Display percentage of completion
          print('downloadPercentage: ${downloaded / r.contentLength * 100}');

          // Save the file
          File file = new File('$dir/${movie.name}+"image"');
          final Uint8List bytes = Uint8List(r.contentLength);
          int offset = 0;
          for (List<int> chunks2 in chunks2) {
            bytes.setRange(offset, offset + chunks2.length, chunks2);
            offset += chunks2.length;
          }
          await file.writeAsBytes(bytes);
          getDirectory();
        });
      });

      response.asStream().listen((http.StreamedResponse r) async {
        r.stream.listen((List<int> chunk) {
          // Display percentage of completion
          print('downloadPercentage: ${downloaded / r.contentLength * 100}');

          chunks.add(chunk);
          downloaded += chunk.length;
        }, onDone: () async {
          // Display percentage of completion
          print('downloadPercentage: ${downloaded / r.contentLength * 100}');

          // Save the file
          File file = new File('$dir/${movie.name}');
          final Uint8List bytes = Uint8List(r.contentLength);
          int offset = 0;
          for (List<int> chunk in chunks) {
            bytes.setRange(offset, offset + chunk.length, chunk);
            offset += chunk.length;
          }
          await file.writeAsBytes(bytes);
          getDirectory();
          return _addToLocalDatabae(Content(
              name: movie.name,
              imageUrl: '$dir/${movie.name}+"image"',
              price: movie.price,
              titleImageUrl: movie.titleImageUrl,
              videoUrl: '$dir/${movie.name}',
              description: movie.description,
              videoId: movie.videoId,
              category: movie.category,
              noDownload: movie.noDownload));
        });
      });
    } catch (e) {
      return null;
    }
  }

  void getDirectory() async {
    var systemTempDir =
        Directory("/data/user/0/com.brinnixs.flora/app_flutter");

    // List directory contents, recursing into sub-directories,
    // but not following symbolic links.
    await for (var entity
        in systemTempDir.list(recursive: true, followLinks: false)) {
      print(entity.path);
    }
  }

  void _deleteVideo(String vidoUrl, String imgUrl) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    print(dir);

    File file2 = new File('$dir/imgUrl');
    File file = new File('$dir/Age of Samuria');
    try {
      await file.delete();
    } catch (e) {
      print(e.toString());
    }

    return getDirectory();
  }

  void _addToLocalDatabae(Content newMovie) {
    var response = DBProvider.db.newMovie(newMovie);
    print(newMovie.videoId);
    print(response);
  }

  void _printAllLocalDatabase() {
    List list = DBProvider.db.getAllClients() as List;
    print(list);
  }

  double _getRatingfromSnapshots(Content n) {
    int noOfRatings = n.rating['noOfRatings'];
    String totalRatings = n.rating['totalRatings'];
    return double.parse((double.parse(totalRatings) / noOfRatings).toString());
  }
}
