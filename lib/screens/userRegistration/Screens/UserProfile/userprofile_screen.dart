import 'package:flora/assets.dart';
import 'package:flora/screens/nav_screen.dart';
import 'package:flora/screens/screens.dart';
import 'package:flora/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flora/cubits/cubits.dart';
import 'package:provider/provider.dart';
import 'package:flora/models/models.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flora/screens/userRegistration/Screens/UserProfile/profile_list_item.dart';

class UserProfileScreen extends StatefulWidget {
  String uId;
  String userEmail;
  UserProfileScreen({Key key, this.uId, this.userEmail}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  ScrollController _scrollController;
  int counter = 0;
  final AuthServices _auth = AuthServices();

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
    final user = Provider.of<AppUser>(context);
    bool isExpanded;

    print('botton AppBar: USERPROFILE');
    Orientation orn = MediaQuery.of(context).orientation;
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(children: <Widget>[
        Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.black])),
            child: Container(
              width: screenSize.width,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: orn == Orientation.portrait ? 90 : 45,
                    ),
                    Text(
                      widget.userEmail,
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: orn == Orientation.portrait ? 90 : 45,
                    ),
                  ],
                ),
              ),
            )),
        Container(
          child: Expanded(
            child: ListView(
              children: <Widget>[
                ProfileListItem(
                  onClick: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentHistorylist()));
                  },
                  icon: Icons.payment,
                  text: 'Payment History',
                ),
                // ProfileListItem(
                //   onClick: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => NavScreen(
                //                   currentIndex: 3,
                //                 )));
                //   },
                //   icon: Icons.download,
                //   text: 'Downloads',
                // ),
                ProfileListItem(
                  onClick: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => MyList()));
                  },
                  icon: Icons.movie,
                  text: 'My List',
                ),
                ProfileListItem(
                  onClick: () {
                    _auth.signOut();
                  },
                  icon: Icons.logout,
                  text: 'Log Out',
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  Container _paymentHistory(Size size) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 13, right: 13),
        child: Row(
          children: [
            Container(
              width: (size.width - 36) * 0.8,
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 70,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                image: AssetImage(Assets.crownTitle),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                          height: 70,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2)))
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Expanded(
                      child: Text(
                        "Movie Title",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: (size.width - 36) * 0.2,
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 2, color: Colors.white),
                    color: Colors.black.withOpacity(0.4)),
                child: Center(
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
