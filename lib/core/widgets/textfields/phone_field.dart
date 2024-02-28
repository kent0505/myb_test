import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../app_colors.dart';
import '../../utils.dart';
import 'widgets/check_icon.dart';
import 'widgets/label_text.dart';

class PhoneField extends StatefulWidget {
  const PhoneField({
    super.key,
    required this.controller,
    this.shadow = true,
    required this.onChanged,
  });

  final TextEditingController controller;
  final bool shadow;
  final void Function() onChanged;

  @override
  State<PhoneField> createState() => PhoneFieldState();
}

class PhoneFieldState extends State<PhoneField> {
  final maskFormatter = MaskTextInputFormatter(mask: '+7 (###) ###-##-##');
  bool prefix = false;
  bool shadow = false;

  @override
  void initState() {
    super.initState();
    Utils.phoneValid = false;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            blurRadius: widget.shadow && shadow ? 20 : 0,
            spreadRadius: 0,
            offset: const Offset(0, 0),
            color: AppColors.basicWhite2,
          )
        ],
      ),
      child: TextField(
        controller: widget.controller,
        inputFormatters: [maskFormatter],
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        style: const TextStyle(
          fontSize: 13,
        ),
        cursorColor: Colors.black,
        cursorWidth: 1,
        decoration: InputDecoration(
          label: widget.shadow
              ? const LabelText(label: 'Введите номер телефона')
              : const LabelText(label: 'Введите номер телефона', star: true),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          prefixText: prefix ? '+7' : null,
          prefixStyle: const TextStyle(
            fontSize: 13,
          ),
          hintStyle: const TextStyle(
            color: AppColors.basicGrey4,
            fontSize: 13,
          ),
          fillColor: shadow ? Colors.white : AppColors.basicWhite1,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          suffixIcon: Utils.phoneValid ? const CheckIcon() : null,
          suffixIconConstraints: const BoxConstraints(
            minHeight: 20,
            minWidth: 20,
          ),
          // errorText: phoneErrorText,
          errorStyle: const TextStyle(
            color: Colors.red,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red),
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
        onTap: () {
          if (widget.shadow) {
            setState(() {
              shadow = true;
            });
          }

          if (widget.controller.text.isEmpty) {
            setState(() {
              print('PREFIX TRUE');
              prefix = true;
            });
          } else {
            print('PREFIX FALSE');
          }
        },
        onChanged: (value) {
          if (prefix) {
            setState(() {
              prefix = false;
            });
          }

          setState(() {
            if (value.isNotEmpty && value.length > 17) {
              Utils.phoneValid = true;
            } else {
              Utils.phoneValid = false;
            }
          });
          widget.onChanged();
        },
        onEditingComplete: () {
          if (widget.shadow && shadow) {
            setState(() {
              shadow = false;
            });
          }
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onTapOutside: (_) {
          if (widget.shadow && shadow) {
            setState(() {
              shadow = false;
            });
          }
          FocusManager.instance.primaryFocus?.unfocus();
        },
      ),
    );
  }
}
