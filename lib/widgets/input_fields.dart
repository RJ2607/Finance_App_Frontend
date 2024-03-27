import 'package:flutter/material.dart';

class InputTextFieldWidget extends StatefulWidget {
  final bool passwordField;
  final TextEditingController textEditingController;
  final String hintText;
  InputTextFieldWidget(this.textEditingController, this.hintText,
      {this.passwordField = false});

  @override
  State<InputTextFieldWidget> createState() => _InputTextFieldWidgetState();
}

class _InputTextFieldWidgetState extends State<InputTextFieldWidget> {
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      obscureText: widget.passwordField ? visible : false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          hintText: widget.hintText,
          suffixIcon: widget.passwordField
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      visible = !visible;
                    });
                  },
                  icon: Icon(visible ? Icons.visibility : Icons.visibility_off))
              : null,
          hintStyle: TextStyle(color: Colors.grey[400]),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(color: Color.fromRGBO(40, 65, 98, 1), width: 2))),
    );
  }
}
