import 'package:flutter/material.dart';
import 'package:flora/screens/userRegistration/constants.dart';
import 'package:flora/screens/userRegistration/components/text_field_container.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final ValueChanged<String> validator;

  const RoundedPasswordField({
    Key key,
    this.controller,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  final myController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: _isObscure,
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        validator: widget.validator,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _isObscure ? Icons.visibility : Icons.visibility_off,
              color: kPrimaryColor,
            ),
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
                print(myController.text);
              });
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
