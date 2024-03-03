import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
    this.title, {
    super.key,
    required this.size,
    required this.weight,
    this.center = false,
    required this.color,
  });

  final String title;
  final double size;
  final int weight;
  final bool center;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: center ? TextAlign.center : TextAlign.left,
      style: TextStyle(
        fontSize: size,
        fontWeight: getWeight(weight),
        color: color,
      ),
    );
  }
}

FontWeight getWeight(int weight) {
  switch (weight) {
    case 100:
      return FontWeight.w100;
    case 200:
      return FontWeight.w200;
    case 300:
      return FontWeight.w300;
    case 400:
      return FontWeight.w400;
    case 500:
      return FontWeight.w500;
    case 600:
      return FontWeight.w600;
    case 700:
      return FontWeight.w700;
    case 800:
      return FontWeight.w800;
    case 900:
      return FontWeight.w900;
    default:
      return FontWeight.w400;
  }
}
