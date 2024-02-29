import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../utils.dart';

class TxtField extends StatelessWidget {
  const TxtField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final void Function() onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 126,
      child: TextField(
        controller: controller,
        maxLines: 4,
        maxLength: 250,
        buildCounter: (
          context, {
          required currentLength,
          required isFocused,
          maxLength,
        }) {
          return Container(
            transform: Matrix4.translationValues(8, -26, 0),
            child: Text(
              "$currentLength/$maxLength",
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: AppColors.basicGrey5,
              ),
            ),
          );
        },
        textCapitalization: TextCapitalization.sentences,
        textAlignVertical: TextAlignVertical.top,
        cursorColor: Colors.black,
        cursorWidth: 1,
        style: const TextStyle(fontSize: 13),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppColors.basicGrey4,
            fontSize: 13,
          ),
          fillColor: AppColors.basicWhite1,
          filled: true,
          contentPadding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 15,
            bottom: 34,
          ),
          errorStyle: const TextStyle(color: Colors.red),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
        ),
        onChanged: (value) {
          if (value.isEmpty) {
            Utils.txtValid = false;
          } else {
            Utils.txtValid = true;
          }
          onChanged();
        },
        onTapOutside: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
      ),
    );
  }
}
