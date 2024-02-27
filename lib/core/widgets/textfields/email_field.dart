import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../constants.dart';
import '../../utils.dart';
import 'widgets/check_icon.dart';
import 'widgets/label_text.dart';

class EmailField extends StatefulWidget {
  const EmailField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final void Function() onChanged;

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  void initState() {
    super.initState();
    Utils.emailValid = false;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.greenAccent,
      height: 44,
      child: TextField(
        controller: widget.controller,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(
          fontSize: 13,
        ),
        cursorColor: Colors.black,
        cursorWidth: 1,
        decoration: InputDecoration(
          label: const LabelText(label: 'E-mail', star: true),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: AppColors.basicWhite1,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          suffixIcon: Utils.emailValid ? const CheckIcon() : null,
          suffixIconConstraints: const BoxConstraints(
            minHeight: 18,
            minWidth: 18,
          ),
          errorStyle: const TextStyle(
            color: Colors.red,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
        ),
        onChanged: (value) {
          setState(() {
            if (!RegExp(Const.emailPattern).hasMatch(value)) {
              Utils.emailValid = false;
            } else {
              Utils.emailValid = true;
            }
          });
          widget.onChanged();
        },
        onTapOutside: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
      ),
    );
  }
}
