import 'package:flutter/material.dart';
import 'package:flora/screens/userRegistration/Screens/Signup/components/body.dart';

class SignUpScreen extends StatelessWidget {
  final String userEmail;
  const SignUpScreen({Key key, this.userEmail}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        userEmail: userEmail,
      ),
    );
  }
}
