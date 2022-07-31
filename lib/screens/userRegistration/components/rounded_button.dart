import 'package:flutter/material.dart';
import 'package:flora/screens/userRegistration/constants.dart';
import 'package:flora/screens/Shared/shared.dart';

class RoundedButton extends StatefulWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  final bool isLoading;
  const RoundedButton(
      {Key key,
      this.text,
      this.press,
      this.color = kPrimaryColor,
      this.textColor = Colors.white,
      this.isLoading = false})
      : super(key: key);

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0),
        child: newElevatedButton(),
      ),
    );
  }

  Widget newElevatedButton() {
    return ElevatedButton(
      child: widget.isLoading
          ? Loading(
              color: Colors.white,
              size: 25,
            )
          : Text(
              widget.text,
              style: TextStyle(color: widget.textColor),
            ),
      onPressed: widget.press,
      style: ElevatedButton.styleFrom(
          primary: widget.color,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          textStyle: TextStyle(
              color: widget.textColor,
              fontSize: 14,
              fontWeight: FontWeight.w500)),
    );
  }
}
