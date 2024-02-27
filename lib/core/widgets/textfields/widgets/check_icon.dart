import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CheckIcon extends StatelessWidget {
  const CheckIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: SvgPicture.asset('assets/icons/check_green.svg'),
    );
  }
}
