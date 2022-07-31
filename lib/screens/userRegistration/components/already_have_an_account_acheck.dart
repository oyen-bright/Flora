import 'package:flutter/material.dart';
import 'package:flora/screens/userRegistration/constants.dart';

class AlreadyHaveAnAccountCheck extends StatefulWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  State<AlreadyHaveAnAccountCheck> createState() =>
      _AlreadyHaveAnAccountCheckState();
}

class _AlreadyHaveAnAccountCheckState extends State<AlreadyHaveAnAccountCheck> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          widget.login
              ? "Don’t have an Account ? "
              : "Already have an Account ? ",
          style: TextStyle(color: kPrimaryColor),
        ),
        GestureDetector(
          onTap: widget.press,
          child: Text(
            widget.login ? "Sign Up" : "Sign In",
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
