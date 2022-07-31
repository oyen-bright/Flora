import 'package:flutter/material.dart';
import 'package:flora/screens/userRegistration/constants.dart';
import 'package:flora/screens/userRegistration/components/text_field_container.dart';

class DisabledTextInputField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final String value;
  final ValueChanged<String> validator;
  final TextEditingController controller;
  const DisabledTextInputField(
      {Key key,
      this.hintText,
      this.icon = Icons.person,
      this.onChanged,
      this.value,
      this.controller,
      this.validator})
      : super(key: key);

  @override
  State<DisabledTextInputField> createState() => _DisabledTextInputFieldState();
}

class _DisabledTextInputFieldState extends State<DisabledTextInputField> {
  @override
  Widget build(BuildContext context) {
    print(widget.value);
    return TextFieldContainer(
      child: TextFormField(
        initialValue: widget.value,
        enabled: false,
        controller: widget.controller,
        validator: widget.validator,
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            widget.icon,
            color: kPrimaryColor,
          ),
          labelText: widget.hintText,
          // hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
