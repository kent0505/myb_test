import 'package:blocker/core/widgets/checkbox/checkbox_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app_colors.dart';
import '../buttons/border_button.dart';
import '../buttons/yellow_button.dart';
import '../textfields/txt_field.dart';

class PhoneAddDialog extends StatefulWidget {
  const PhoneAddDialog({
    super.key,
    required this.phone,
  });

  final String phone;

  @override
  State<PhoneAddDialog> createState() => _PhoneAddDialogState();
}

class _PhoneAddDialogState extends State<PhoneAddDialog> {
  final controller = TextEditingController();
  final scrollController = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 900),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 24),
                const Text(
                  'Добавление номера',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.basicGrey4,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.phone,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryText,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Пометить как:',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.basicGrey1,
                  ),
                ),
                const SizedBox(height: 5),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 284,
                    minHeight: 0,
                  ),
                  child: RawScrollbar(
                    controller: scrollController,
                    thumbColor: AppColors.basicWhite2,
                    thickness: 5,
                    radius: const Radius.circular(18),
                    thumbVisibility: true,
                    scrollbarOrientation: ScrollbarOrientation.right,
                    child: ListView(
                      controller: scrollController,
                      shrinkWrap: true,
                      children: const [
                        CheckboxWidget(
                          title: 'Aaa',
                          checked: false,
                        ),
                        CheckboxWidget(
                          title: 'Aaa',
                          checked: false,
                        ),
                        CheckboxWidget(
                          title: 'Aaa',
                          checked: false,
                        ),
                        CheckboxWidget(
                          title: 'Aaa',
                          checked: false,
                        ),
                        CheckboxWidget(
                          title: 'Aaa',
                          checked: false,
                        ),
                        CheckboxWidget(
                          title: 'Aaa',
                          checked: false,
                        ),
                        CheckboxWidget(
                          title: 'Aaa',
                          checked: false,
                        ),
                        CheckboxWidget(
                          title: 'Aaa',
                          checked: false,
                        ),
                        CheckboxWidget(
                          title: 'Aaa',
                          checked: false,
                        ),
                        CheckboxWidget(
                          title: 'Aaa',
                          checked: false,
                        ),
                        CheckboxWidget(
                          title: 'Aaa',
                          checked: false,
                        ),
                        CheckboxWidget(
                          title: 'Aaa',
                          checked: false,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TxtField(
                  controller: controller,
                  hintText: 'Оставьте комментарий',
                  onChanged: () {},
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: BorderButton(
                        title: 'Отменить',
                        active: true,
                        onPressed: () {
                          context.pop();
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: YellowButton(
                        title: 'Готово',
                        active: true,
                        onPressed: () async {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
      // child: Stack(
      //   children: [

      //     Positioned(
      //       top: 12,
      //       right: 12,
      //       child: InkWell(
      //         onTap: () {
      //           context.pop();
      //         },
      //         child: SvgPicture.asset(
      //           'assets/icons/x.svg',
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
