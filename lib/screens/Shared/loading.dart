import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  double size = 25.0;
  Color color = Colors.white;

  Loading({Key key, this.size, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: SpinKitFadingCircle(color: color, size: size)),
    );
  }
}
