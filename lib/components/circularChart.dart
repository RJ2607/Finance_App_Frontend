// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';

class CircularChart extends StatefulWidget {
  const CircularChart(
      {Key? key,
      this.showTitle = true,
      this.animateTitle = true,
      required this.perc,
      this.startOffset = -90.0,
      this.endOffset = 90.0,
      this.color = Colors.red,
      this.duration = 1})
      : super(key: key);
  final double perc;
  final bool showTitle;
  final bool animateTitle;
  final double startOffset;
  final double endOffset;
  final Color color;
  final int duration;

  @override
  State<CircularChart> createState() => _CircularChartState();
}

class _CircularChartState extends State<CircularChart> {
  @override
  Widget build(BuildContext context) {
    double sOffset = degreeToRadian(widget.startOffset);
    double max = (widget.endOffset - widget.startOffset) / 360;
    double angle = max * widget.perc / 100;
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 200,
          width: 200,
          //create a tween animation for circular percent indicator and rotate it 120 degree on z axis
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              // ..setEntry(3, 2, 0.001)
              ..rotateZ(sOffset),
            child: CircularProgressIndicator(
              value: max,
              backgroundColor: Colors.transparent,
              color: Colors.black,
              strokeWidth: 10,
              strokeCap: StrokeCap.round,
            ),
          ),
        ),
        Ink(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // boxShadow: [
            //   BoxShadow(
            //     color: widget.color,
            //     spreadRadius: 10,
            //     blurRadius: 7,
            //     offset: Offset(0, 0),
            //   ),
            // ],
          ),
          child: SizedBox(
            height: 200,
            width: 200,
            //create a tween animation for circular percent indicator and rotate it 120 degree on z axis
            child: TweenAnimationBuilder(
              tween: Tween(begin: 0.0, end: angle),
              duration: Duration(seconds: widget.duration),
              builder: (context, value, child) {
                //rotate it 120 degree on z axis
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    // ..setEntry(3, 2, 0.001)
                    ..rotateZ(sOffset),
                  child: CircularProgressIndicator(
                    value: value,
                    backgroundColor: Colors.transparent,
                    color: widget.color,
                    strokeWidth: 10,
                    strokeCap: StrokeCap.round,
                  ),
                );
              },
            ),
          ),
        ),
        if (widget.showTitle) titlePerc(),
      ],
    );
  }

  Widget titlePerc() {
    if (widget.animateTitle) {
      return TweenAnimationBuilder(
          tween: Tween(begin: 0.0, end: widget.perc),
          duration: Duration(seconds: widget.duration),
          builder: (context, value, child) {
            //rotate it 120 degree on z axis
            return Text(
              '${value.toInt()}%',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
              ),
            );
          });
    } else {
      return Text(
        '${widget.perc.toInt()}%',
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w500,
          fontFamily: 'Roboto',
        ),
      );
    }
  }

  // a method to convert degree to radian
  double degreeToRadian(double degree) {
    return degree * (pi / 180);
  }
}
