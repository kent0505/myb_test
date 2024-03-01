import 'package:flutter/material.dart';

import '../../app_colors.dart';

class YellowLineWidget extends StatelessWidget {
  const YellowLineWidget({
    super.key,
    required this.width,
    this.top,
    this.left,
    this.bottom,
    this.right,
  });

  final double width;
  final double? top;
  final double? left;
  final double? bottom;
  final double? right;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      bottom: bottom,
      right: right,
      child: Container(
        height: 3,
        width: width,
        color: AppColors.primaryOrange,
      ),
    );
  }
}
