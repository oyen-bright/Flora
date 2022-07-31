import 'package:flora/screens/nav_screen.dart';
import 'package:flora/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flora/screens/userRegistration/screens/Login/components/background.dart';
import 'package:flora/screens/userRegistration/components/rounded_button.dart';
import 'package:flora/screens/userRegistration/components/rounded_input_field.dart';
import 'package:flora/screens/userRegistration/components/rounded_password_field.dart';
import 'package:flora/services/services.dart';
import 'package:flora/screens/userRegistration/components/text_field.dart';

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
  String email = '';
  String password = '';
  final AuthServices _auth = AuthServices();
  TextEditingController _password = TextEditingController();

  bool loading = false;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/netflix_logo1.png",
                width: size.width - 200,
              ),
              Padding(padding: EdgeInsets.fromLTRB(40, 60, 40, 5)),
              // Text(
              //   "LOGIN",
              //   style: TextStyle(fontWeight: FontWeight.bold),
              // ),
              // SizedBox(height: size.height * 0.03),
              // SvgPicture.asset(
              //   "assets/icons/login.svg",
              //   height: size.height * 0.35,
              // ),
              // SizedBox(height: size.height * 0.03),
              DisabledTextInputField(
                value: widget.userEmail,
              ),
              RoundedPasswordField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your Passwored';
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
                text: "LOGIN",
                press: () async {
                  if (_formkey.currentState.validate()) {
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.signInWithEmailAndPassword(
                        widget.userEmail, _password.text);

                    if (result.runtimeType == String) {
                      setState(() {
                        loading = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Theme.of(context).errorColor,
                          content: Text(result, textAlign: TextAlign.center)));
                    } else {
                      Navigator.popUntil(context, (route) => false);
                    }

                    // if (result != null) {
                    // } else {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(content: Text(_auth.getAuthError())));
                    // }

                    print(result);
                  }
                },
                isLoading: loading,
              ),

              SizedBox(height: size.height * 0.03),
              // AlreadyHaveAnAccountCheck(
              //   press: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) {
              //           return SignUpScreen();
              //         },
              //       ),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
