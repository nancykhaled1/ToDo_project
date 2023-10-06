import 'package:flutter/material.dart';

class TextFormWidget extends StatelessWidget {
  String text;
  TextInputType keyboardType;
  TextEditingController controller;
  String? Function(String?) validator;
  bool isobscure;
  var style;

  TextFormWidget(
      {required this.text,
      this.keyboardType = TextInputType.text,
      required this.controller,
      required this.validator,
      this.isobscure = false,
      this.style});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        decoration: InputDecoration(
            label: Text(
              text,
              style: style,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                width: 3,
                color: Theme.of(context).primaryColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                width: 3,
                color: Theme.of(context).primaryColor,
              ),
            )),
        keyboardType: keyboardType,
        controller: controller,
        validator: validator,
        obscureText: isobscure,
      ),
    );
  }
}
