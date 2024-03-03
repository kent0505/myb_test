import 'package:flutter/material.dart';

import '../../config/app_colors.dart';

class YellowLineTextWidget extends StatelessWidget {
  const YellowLineTextWidget(
    this.title, {
    super.key,
    required this.size,
    required this.width,
    this.top,
    this.left,
    this.bottom,
    this.right,
  });

  final String title;
  final double size;
  final double width;
  final double? top;
  final double? left;
  final double? bottom;
  final double? right;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: size,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        Positioned(
          top: top,
          left: left,
          bottom: bottom,
          right: right,
          child: Container(
            height: 3,
            width: width,
            color: AppColors.primaryOrange,
          ),
        ),
      ],
    );
  }
}
