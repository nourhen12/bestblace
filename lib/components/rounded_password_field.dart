import 'package:flutter/material.dart';
import 'package:flutterbestplace/components/text_field_container.dart';
import 'package:flutterbestplace/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String> validate;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.validate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      nb: 0.8,
      child: TextFormField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        validator: validate,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
