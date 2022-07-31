import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flora/models/content_model.dart';
import 'package:flora/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flora/cubits/cubits.dart';
import 'package:flora/data/data.dart';
import 'package:flora/widgets/widgets.dart';
import 'package:flora/services/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flora/screens/Shared/shared.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    // final movies = Provider.of<List<Content>>(context);
    //StreamProvider provider = StreamProvider<List<Content>>;
    final user = Provider.of<AppUser>(context);
    print('CURRENT USER LOGIN');
    print(user.uid);
    print('CURERNT USER LOGIN');
    Stream<int> generateNumbers = (() async* {
      await Future<void>.delayed(Duration(seconds: 2));

      for (int i = 1; i <= 5; i++) {
        await Future<void>.delayed(Duration(seconds: 1));
        yield i;
      }
    })();

    // print(movies[1]);
    // print(movies[3]);

    // // previews.add(Content(name));
    // if (movies != null) {
    //   movies.forEach((brew) {
    //     print(brew.videoUrl);
    //     print('object');
    //     print(brew.name);
    //   });
    // }

    // if (movies.docs == null) return CircularProgressIndicator();
    // int i = 0;
    // for (var doc in movies.docs) {
    //   print(doc.data());
    //   print(i);
    //   i++;
    // }
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.grey[850],
      //   child: const Icon(Icons.cast),
      //   onPressed: () => print('Cast'),
      // ),
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 50.0),
        child: BlocBuilder<AppBarCubit, double>(
          builder: (context, scrollOffset) {
            return CustomAppBar(scrollOffset: scrollOffset);
          },
        ),
      ),
      body: StreamBuilder(
        stream: DatabaseService().allMovieListm,
        initialData: 0,
        builder: (
          BuildContext context,
          AsyncSnapshot snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading(
              size: 25,
              color: Colors.white,
            );
          } else if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  children: <Widget>[
                    Loading(size: 25, color: Colors.white),
                    Text("No Connection")
                  ],
                ),
              );
            } else if (snapshot.hasData) {
              final movies = snapshot.data;
              return CustomScrollView(
                controller: _scrollController,
                slivers: [
                  // SliverToBoxAdapter(
                  //   //child: ContentHeader(featuredContent: sintelContent),
                  //   child: ContentHeader(
                  //     featuredContent: sintelContent,
                  //     contentList: originals,
                  //   ),
                  // ),
                  // SliverToBoxAdapter(
                  //   //child: ContentHeader(featuredContent: sintelContent),
                  //   child: Container(
                  //     width: screenSize.width,
                  //     child: CarouselSlider(
                  //       options: CarouselOptions(
                  //         height: 100,
                  //         autoPlay: true,
                  //         disableCenter: true,
                  //       ),
                  //       items: headerContent
                  //           .map((item) => ContentHeader(
                  //                 featuredContent: item,
                  //               ))
                  //           .toList(),
                  //     ),
                  //   ),
                  // ),
                  SliverToBoxAdapter(
                      child: CarouselSlider.builder(
                          options: CarouselOptions(
                            height: screenSize.height / 1.3,
                            // enlargeCenterPage: true,
                            autoPlay: true,
                            viewportFraction: 1.0,
                          ),
                          itemCount: headerContent.length,
                          itemBuilder:
                              (context, int itemIndex, int pageViewIndex) {
                            return ContentHeader(
                                featuredContent: headerContent[itemIndex]);
                          })),
                  SliverPadding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    sliver: SliverToBoxAdapter(
                      child: ContentList(
                        key: PageStorageKey('trending'),
                        title: 'Trending',
                        contentList: movies,
                        isforTrending: true,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: MyListContentList(
                      key: PageStorageKey('myList'),
                      title: 'My List',
                      myListContentList: movies,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ContentList(
                      key: PageStorageKey('originals'),
                      title: 'Top Movies',
                      contentList: movies,
                      isOriginals: true,
                      isforTrending: false,
                    ),
                  ),
                ],
              );
            } else {
              return Loading(
                size: 2,
                color: Colors.red,
              );
            }
          }
          return Loading(
            size: 2,
            color: Colors.red,
          );
        },
      ),
    );
  }
}
