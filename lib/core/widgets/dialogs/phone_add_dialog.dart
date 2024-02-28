import 'package:blocker/core/widgets/textfields/txt_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../app_colors.dart';
import '../buttons/border_button.dart';
import '../buttons/yellow_button.dart';

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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  const Spacer(),
                  TxtField(
                    controller: controller,
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
            Positioned(
              top: 12,
              right: 12,
              child: InkWell(
                onTap: () {
                  context.pop();
                },
                child: SvgPicture.asset(
                  'assets/icons/x.svg',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
