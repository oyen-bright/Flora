import 'package:flora/models/models.dart';
import 'package:flora/screens/wrappers/wrapper.dart';
import 'package:flora/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flora/screens/userRegistration/Screens/Login/login_screen.dart';
import 'package:flora/screens/userRegistration/Screens/Signup/signup_screen.dart';
import 'package:flora/screens/userRegistration/Screens/Welcome/components/background.dart';
import 'package:flora/screens/userRegistration/components/rounded_button.dart';
import 'package:flora/screens/userRegistration/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flora/screens/userRegistration/components/rounded_input_field.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AuthServices _auth = AuthServices();

  TextEditingController _email = TextEditingController();

  final _formKeyy = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/netflix_logo1.png",
              width: size.width - 200,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 60, 40, 5),
              //padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Text(
                "Ready ?",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 30),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Text(
                "Enter your email to create or sign in            to your account.",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
              ),
            ),
            //SizedBox(height: size.height * 0.05),
            // SvgPicture.asset(
            //   "assets/icons/chat.svg",
            //   height: size.height * 0.45,
            // ),
            //SizedBox(height: size.height * 0.05),
            Form(
              key: _formKeyy,
              child: RoundedInputField(
                hintText: "Your Email",
                onChanged: (value) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your Email';
                  } else if (!isValidEmail(value)) {
                    return 'Invalid Email';
                  }
                  return null;
                },
                controller: _email,
              ),
            ),
            RoundedButton(
              text: "GET STARTED",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () async {
                if (_formKeyy.currentState.validate()) {
                  setState(() {
                    loading = true;
                  });
                  dynamic result =
                      await _auth.getStartedCheck(_email.text, '########');
                  print(result);
                  if (result == true) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen(
                            userEmail: _email.text,
                          );
                        },
                      ),
                    );
                  } else if (result == false) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignUpScreen(
                            userEmail: _email.text,
                          );
                        },
                      ),
                    );
                  } else if (result == null) {
                    setState(() {
                      loading = false;
                    });
                  } else if (result == 'tooManyRequests') {
                    setState(() {
                      loading = false;
                    });
                  } else {
                    print('i worked');
                    return Wrapper();
                  }
                }
              },
              isLoading: loading,
            ),
          ],
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }
}
