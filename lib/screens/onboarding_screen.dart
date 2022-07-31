import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './onBoarding/OnbordingData.dart';
import './onBoarding/flutteronboardingscreens.dart';

class OnBoardingScreen extends StatelessWidget {
  final List<OnbordingData> list = [
    OnbordingData(
      imagePath: "assets/images/download.png",
      title: "LoremIpsum",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    ),
    OnbordingData(
      imagePath: "assets/images/nocontract.png",
      title: "LoremIpsum",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    ),
    OnbordingData(
      imagePath: "assets/images/anydevice.png",
      title: "LoremIpsum",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: IntroScreen(
        list,
        MaterialPageRoute(builder: (context) => OnBoardingScreen()),
      ),
    );
  }
}
