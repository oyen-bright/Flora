import 'package:flora/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flora/screens/screens.dart';
import 'package:provider/provider.dart';
import 'package:flora/models/models.dart';
import 'package:flora/screens/wrappers/wrapper.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    print(user);
    print('WRAPPER');
    if (user == null) {
      return WelcomeScreen();
    } else {
      return NavScreen(
        uId: user.uid,
        currentIndex: 0,
      );
    }
  }
}
