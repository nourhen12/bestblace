import 'package:flutter/material.dart';
import 'package:flutterbestplace/components/text_field_container.dart';
import 'package:flutterbestplace/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String> validate;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon,
    this.onChanged,
    this.validate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      nb: 0.8,
      child: TextFormField(
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        validator: validate,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
