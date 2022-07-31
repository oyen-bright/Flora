import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flora/models/models.dart';
import 'package:flora/screens/Shared/loading.dart';
import 'package:flora/widgets/movie_category.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flora/cubits/cubits.dart';
import 'package:flora/data/data.dart';
import 'package:flora/widgets/widgets.dart';
import 'package:flora/services/services.dart';
import 'package:provider/provider.dart';

class AllMovies extends StatefulWidget {
  final bool isNav;
  const AllMovies({Key key, this.isNav}) : super(key: key);

  @override
  _AllMoviesState createState() => _AllMoviesState();
}

class _AllMoviesState extends State<AllMovies> {
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    //   ..addListener(() {
    //     context.read<AppBarCubit>().setOffset(_scrollController.offset);
    //   });
    // super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // DatabaseService().updateMovieData(
    //   name: 'Madagascar',
    //   imageUrl:
    //       'https://firebasestorage.googleapis.com/v0/b/flora-media-limited.appspot.com/o/Movies%2Fimages%2FpreviewImages%2Fblack_mirror.jpg?alt=media&token=cc11fcb1-e186-4889-80e7-435899df0dc0',
    //   titleImageUrl:
    //       'https://firebasestorage.googleapis.com/v0/b/flora-media-limited.appspot.com/o/Movies%2Fimages%2FpreviewImages%2Fblack_mirror_title.png?alt=media&token=55653796-2401-48e6-a2f2-f73ee4bd28ce',
    //   videoUrl:
    //       'https://firebasestorage.googleapis.com/v0/b/flora-media-limited.appspot.com/o/Movies%2Fvideos%2FPreviews%2FAge%20of%20Samural.mp4?alt=media&token=804b2933-47f6-4e5a-ae8f-f2198a74dd68',
    //   description:
    //       'Aquaman was th e liosfsf iskdf ios il sifl skfnuan ifaljijfla dfndlfjaif kdflkkd filfkndf',
    //   price: '200',
    //   noDownload: '10',
    //   category: "Action",
    //   color: "Colors.blue",
    //   videoPreviewUrl:
    //       'https://firebasestorage.googleapis.com/v0/b/flora-media-limited.appspot.com/o/Movies%2Fvideos%2FPreviews%2FAquaman.mp4?alt=media&token=b4af262f-8f66-41af-b7af-cc310a3adf24',
    //   year: '2021',
    //   pgRating: '18',
    //   quality: 'HD',
    //   rating: '4',
    //   noOfPayment: '2',
    // );
    final Allmovies = Provider.of<List<Content>>(context);
    Future getCategories(Allmovies) async {
      List<String> categories = [];
      final Allmovies = Provider.of<List<Content>>(context);
      Allmovies.forEach((element) {
        print(element);
        if (categories.contains(element.category)) {
        } else {
          categories.add(element.category);
        }
      });
      categories.forEach((element) {
        print(element + 'new category');
      });
      getMovieList() {
        return Allmovies;
      }

      return categories;
    }

    // print(Allmovies);
    // if (Allmovies != null) {
    //   Allmovies.forEach((brew) {
    //     print(brew.videoUrl);
    //     print('object');
    //     print(brew.rating);
    //     print('f');
    //   });

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
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 50.0),
        child: widget.isNav
            ? AppBar(
                title: Text('Movies'),
                backgroundColor: Colors.black,
                elevation: 0,
                actions: [],
              )
            : AppBar(
                title: Text('Movies'),
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
                actions: [],
              ),
      ),
      body: FutureBuilder(
        future: getCategories(Allmovies),
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              print(snapshot.error);
            } else if (snapshot.hasData) {
              final cat = snapshot.data;
              return CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.only(top: 80.0),
                  ),
                  SliverToBoxAdapter(
                    child: MovieCategory(
                      categories: cat,
                      key: PageStorageKey('myList'),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ContentList(
                      key: PageStorageKey('originals'),
                      title: 'Top Movies',
                      contentList: Allmovies,
                      isOriginals: true,
                      isforTrending: false,
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    sliver: SliverToBoxAdapter(
                      child: AllMoviesList(
                        isNav: widget.isNav,
                        key: PageStorageKey('allmovieslist'),
                        title: 'All Movies',
                        contentList: Allmovies,
                      ),
                    ),
                  )
                ],
              );
            }
          }
          return Loading(
            color: Colors.white,
            size: 25,
          );
        },
      ),
    );
  }
}
