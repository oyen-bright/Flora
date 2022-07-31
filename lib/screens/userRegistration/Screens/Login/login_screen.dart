import 'package:flutter/material.dart';
import 'package:flora/screens/userRegistration/Screens/Login/components/body.dart';

class LoginScreen extends StatelessWidget {
  final String userEmail;
  const LoginScreen({Key key, this.userEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        userEmail: userEmail,
      ),
    );
  }
}
