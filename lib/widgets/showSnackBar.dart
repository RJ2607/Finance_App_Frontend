import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String message, Color _color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    content: Text(
      message,
      style: TextStyle(color: _color, fontSize: 15),
    ),
  ));
}
