import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PCustomContainer extends StatelessWidget {
  final Widget child;
  double padding;
  double marginTop;
  double marginLeft;
  double marginRight;
  double borderRadius;
  double height;
  Color color;

  PCustomContainer({
    Key? key,
    required this.child,
    this.padding = 9,
    this.marginTop = 0.0,
    this.marginLeft = 20,
    this.marginRight = 20,
    this.borderRadius = 20,
    this.height = 0.0,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height > 0 ? height : null,
      padding: EdgeInsets.all(padding),
      margin: EdgeInsets.only(
        left: marginLeft,
        right: marginRight,
        top: marginTop,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      width: double.infinity,
      child: child,
    );
  }
}
