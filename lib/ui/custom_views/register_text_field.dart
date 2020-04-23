import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterTextField extends StatelessWidget {
  final String inputName;
  final String inputHintName;
  final bool isPassword;
  final bool isEmail;
  final FormFieldValidator<String> validate;
  final TextEditingController controller;
  final Function onChange;
  final TextCapitalization textCapitalization;
  final int maxLins;

  const RegisterTextField(
      {Key key,
      this.inputName,
      this.inputHintName,
      this.isPassword,
      this.validate,
      this.controller,
      this.isEmail,
      this.onChange,
      this.textCapitalization,
      this.maxLins})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            inputName,
            style: TextStyle(color: Colors.blue, fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: TextFormField(
            textCapitalization: textCapitalization != null
                ? textCapitalization
                : TextCapitalization.none,
            obscureText: (isPassword ?? false) ? true : false,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 16, top: 24, right: 12),
              hintText: inputHintName,
              hintStyle: TextStyle(fontSize: 16, color: Color(0XFFB4B4B4)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0XFFC1C1C1)),
                borderRadius: BorderRadius.circular(5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0XFFC1C1C1)),
                borderRadius: BorderRadius.circular(5),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            validator: validate,
            controller: controller,
            keyboardType:
                isEmail ? TextInputType.emailAddress : TextInputType.text,
            onChanged: onChange,
            maxLines: maxLins ?? 1,
          ),
        ),
      ],
    );
  }
}
