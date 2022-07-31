import 'package:flora/models/models.dart';
import 'package:flora/screens/wrappers/wrapper.dart';
import 'package:flora/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flora/screens/screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future getIsFirstLaunch() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  bool isfirstLunch = sharedPreferences.getBool('isFirstLaunch');
  if (isfirstLunch != null) {
    finalIsFirstLaunch = isfirstLunch;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  getIsFirstLaunch().whenComplete(() async {
    runApp(MyApp());
  });
}

bool finalIsFirstLaunch = true;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser>.value(
      value: AuthServices().user,
      initialData: null,
      child: StreamProvider<List<Content>>.value(
        value: DatabaseService().allMovieListm,
        initialData: null,
        child: MaterialApp(
          title: 'Flora',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            scaffoldBackgroundColor: Colors.black,
          ),
          home: finalIsFirstLaunch ? OnBoardingScreen() : Wrapper(),
        ),
      ),
    );
  }
}
