import 'package:flora/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flora/screens/userRegistration/Screens/Login/login_screen.dart';
import 'package:flora/screens/userRegistration/Screens/Signup/components/background.dart';
import 'package:flora/screens/userRegistration/Screens/Signup/components/or_divider.dart';
import 'package:flora/screens/userRegistration/Screens/Signup/components/social_icon.dart';
import 'package:flora/screens/userRegistration/components/already_have_an_account_acheck.dart';
import 'package:flora/screens/userRegistration/components/rounded_button.dart';
import 'package:flora/screens/userRegistration/components/rounded_input_field.dart';
import 'package:flora/screens/userRegistration/components/text_field.dart';
import 'package:flora/screens/userRegistration/components/rounded_password_field.dart';

class Body extends StatefulWidget {
  String userEmail;

  Body({
    Key key,
    this.userEmail,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController _password = TextEditingController();

  final AuthServices _auth = AuthServices();

  String email = "";
  String password = "";

  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(widget.userEmail);
    return Background(
      child: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Image.asset(
              //   "assets/images/netflix_logo1.png",
              //   width: size.width - 200,
              // ),
              Padding(
                padding: EdgeInsets.fromLTRB(40, 60, 40, 5),
                //padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: Text(
                  "Ready to experience to quality movies ?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                child: Text(
                  "Create an account, and we'll send you an email with everything you need to know about flora.",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20),
                ),
              ),
              // Text(
              //   "SIGNUP",
              //   style:
              //       TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              // ),
              // SizedBox(height: size.height * 0.03),
              // SvgPicture.asset(
              //   "assets/icons/signup.svg",
              //   height: size.height * 0.35,
              // ),
              DisabledTextInputField(
                value: widget.userEmail,
              ),
              RoundedPasswordField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your Passwored';
                  } else if (value.length < 8) {
                    return 'Password less than 8 Character';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                controller: _password,
              ),

              RoundedButton(
                text: "SIGNUP",
                press: () async {
                  print(_password.text);
                  if (_formkey.currentState.validate()) {
                    setState(() {
                      loading = true;
                    });
                    print(_password.text);
                    dynamic result = await _auth.registerWithEmailAndPassword(
                        widget.userEmail, _password.text);

                    if (result.runtimeType == String) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          result,
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: Theme.of(context).errorColor,
                      ));
                    }
                  }
                },
                isLoading: loading,
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                },
              ),
              OrDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocalIcon(
                    iconSrc: "assets/icons/facebook.svg",
                    press: () {},
                  ),
                  SocalIcon(
                    iconSrc: "assets/icons/twitter.svg",
                    press: () {},
                  ),
                  SocalIcon(
                    iconSrc: "assets/icons/google-plus.svg",
                    press: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
