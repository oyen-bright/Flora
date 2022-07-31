import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flora/models/content_model.dart';
import 'package:flora/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flora/cubits/cubits.dart';
import 'package:flora/screens/screens.dart';
import 'package:flora/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:connectivity/connectivity.dart';

class NavScreen extends StatefulWidget {
  String uId;
  int currentIndex = 0;

  NavScreen({Key key, this.uId, this.currentIndex}) : super(key: key);
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final Map<String, IconData> _icons = const {
    'Home': Icons.home,
    'Search': Icons.search,
    'Movies': Icons.movie,
    'Downloads': Icons.file_download,
    'Profile': Icons.person_outline,
  };
  final AuthServices _auth = AuthServices();

  //int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    setState(() {});
    final List<Widget> _screens = [
      HomeScreen(key: PageStorageKey('homeScreen')),
      SearchScreen(key: PageStorageKey('searchScreen')),
      AllMovies(
        key: PageStorageKey('movieScreen'),
        isNav: true,
      ),
      // ComingSoonScreen(key: PageStorageKey('comingsoonScreen')),
      DownloadScreen(key: PageStorageKey('myDownloadsScreen')),
      UserProfileScreen(
        key: PageStorageKey('userProfilScreen'),
        uId: widget.uId,
        userEmail: 'AHA@GMIAL.COM',
      )
    ];

    // DatabaseService().updateMovieData(
    //   name: 'Black Mirror',
    //   imageUrl:
    //       'https://firebasestorage.googleapis.com/v0/b/flora-media-limited.appspot.com/o/Movies%2Fimages%2FpreviewImages%2Fblack_mirror.jpg?alt=media&token=cc11fcb1-e186-4889-80e7-435899df0dc0',
    //   titleImageUrl:
    //       'https://firebasestorage.googleapis.com/v0/b/flora-media-limited.appspot.com/o/Movies%2Fimages%2FpreviewImages%2Fblack_mirror_title.png?alt=media&token=55653796-2401-48e6-a2f2-f73ee4bd28ce',
    // );
    // Timer.periodic(new Duration(seconds: 5), (timer) {
    //   print(timer.tick.toString());
    // });
    var connectivityResult = (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("No Internet Connection")));
    }

    // return StreamProvider<List<Content>>.value(
    //   value: DatabaseService().allMovieListm,
    //   initialData: null,

    // catchError: (_, __) => null,
    // child: Scaffold(
    return Scaffold(
        body: BlocProvider<AppBarCubit>(
          create: (_) => AppBarCubit(),
          child: _screens[widget.currentIndex],

          // child: Container(
          //   color: Colors.red,
          //   child: FlatButton(
          //       onPressed: () async {
          //         await _auth.signOut();
          //       },
          //       child: Text('me')),
          // ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          items: _icons
              .map((title, icon) => MapEntry(
                  title,
                  BottomNavigationBarItem(
                    icon: Icon(icon, size: 30.0),
                    title: Text(title),
                  )))
              .values
              .toList(),
          currentIndex: widget.currentIndex,
          selectedItemColor: Colors.white,
          selectedFontSize: 11.0,
          unselectedItemColor: Colors.grey,
          unselectedFontSize: 11.0,
          onTap: (index) => setState(() => {widget.currentIndex = index}),
        ));
    // );
  }
}
