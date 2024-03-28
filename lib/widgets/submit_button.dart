// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  bool loading;
  Color color;

  double textsize;

  SubmitButton(
      {Key? key,
      required this.onPressed,
      required this.title,
      this.loading = false,
      this.color = const Color.fromRGBO(40, 65, 98, 1),
      this.textsize = 15})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: TextButton(
          onPressed: () {
            loading ? null : onPressed();
          },
          style: TextButton.styleFrom(
              shadowColor: loading ? Colors.black : Colors.redAccent,
              elevation: 15,
              fixedSize: Size(340, 45),
              side: BorderSide(
                width: 1,
                color: loading
                    ? const Color.fromARGB(255, 65, 65, 65)
                    : Colors.redAccent,
              ),
              backgroundColor: loading ? Colors.grey[800] : Colors.redAccent),
          child: loading
              ? SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeCap: StrokeCap.round,
                    strokeWidth: 3.0,
                  ),
                )
              : Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: textsize),
                )),
    );
  }
}
