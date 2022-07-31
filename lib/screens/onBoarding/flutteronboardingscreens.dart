library flutteronboardingscreens;

import 'package:flora/screens/onBoarding/OnbordingData.dart';
import 'package:flora/screens/screens.dart';
import 'package:flora/screens/wrappers/wrapper.dart';
import 'package:flora/services/local_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flora/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A IntroScreen Class.
///
///
class IntroScreen extends StatefulWidget {
  final List<OnbordingData> onbordingDataList;
  final MaterialPageRoute pageRoute;
  IntroScreen(this.onbordingDataList, this.pageRoute);

  void skipPage(BuildContext context) {
    Navigator.push(context, pageRoute);
  }

  @override
  IntroScreenState createState() {
    return new IntroScreenState();
  }
}

class IntroScreenState extends State<IntroScreen> {
  // This size provide us total height and width of our screen

  final PageController controller = new PageController();
  int currentPage = 0;
  bool lastPage = false;

  void _onPageChanged(int page) {
    setState(() {
      currentPage = page;
      if (currentPage == widget.onbordingDataList.length - 1) {
        lastPage = true;
      } else {
        lastPage = false;
      }
    });
  }

  Widget _buildPageIndicator(int page) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: page == currentPage ? 10.0 : 6.0,
      width: page == currentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: page == currentPage ? Colors.red : Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    print(user);
    return Container(
      // color: new Color(0xFFEEEEEE),
      color: Colors.black,
      padding: const EdgeInsets.all(10.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Expanded(
            flex: 1,
            child: new Container(),
          ),
          new Expanded(
            flex: 3,
            child: new PageView(
              children: widget.onbordingDataList,
              controller: controller,
              onPageChanged: _onPageChanged,
            ),
          ),
          new Expanded(
            flex: 1,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                new TextButton(
                    child: new Text(lastPage ? "" : "SKIP",
                        style: new TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0)),
                    onPressed: () => lastPage
                        ? null
                        : {
                            print('SKIP BUTTON PRESSED'),
                            widget.skipPage(
                              context,
                            ),
                          }),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Container(
                    child: Row(
                      children: [
                        _buildPageIndicator(0),
                        _buildPageIndicator(1),
                        _buildPageIndicator(2),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  child: new Text(lastPage ? "READY ?" : "NEXT",
                      style: new TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0)),
                  onPressed: lastPage
                      ? () async {
                          final SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.setBool('isFirstLaunch', false);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Material(child: Wrapper());
                                // if (user == null) {
                                //   return WelcomeScreen();
                                // } else {
                                //   print(user.uid);
                                //   return NavScreen(uId: user.uid);
                                // }
                              },
                            ),
                          );
                        }
                      : () => controller.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
