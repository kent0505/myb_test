import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/app_colors.dart';
import '../../utils.dart';
import 'widgets/check_icon.dart';
import 'widgets/label_text.dart';

class NameField extends StatefulWidget {
  const NameField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final void Function() onChanged;

  @override
  State<NameField> createState() => _NameFieldState();
}

class _NameFieldState extends State<NameField> {
  @override
  void initState() {
    super.initState();
    Utils.nameValid = false;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: TextField(
        controller: widget.controller,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Zа-яА-Я]')),
        ],
        keyboardType: TextInputType.text,
        style: const TextStyle(
          fontSize: 13,
        ),
        cursorColor: Colors.black,
        cursorWidth: 1,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          label: const LabelText(label: 'Ваше Имя', star: true),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: AppColors.basicWhite1,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          suffixIcon: Utils.nameValid ? const CheckIcon() : null,
          suffixIconConstraints: const BoxConstraints(
            minHeight: 18,
            minWidth: 18,
          ),
          errorStyle: const TextStyle(
            color: Colors.red,
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
            if (value.isNotEmpty) {
              Utils.nameValid = true;
            } else {
              Utils.nameValid = false;
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
