import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/buttons/border_button.dart';
import '../../../core/widgets/buttons/yellow_button.dart';

class BlockerSettingsPage extends StatefulWidget {
  const BlockerSettingsPage({super.key});

  @override
  State<BlockerSettingsPage> createState() => _BlockerSettingsPageState();
}

class _BlockerSettingsPageState extends State<BlockerSettingsPage> {
  bool active = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: Column(
            children: [
              const SizedBox(height: 60),
              Row(
                children: [
                  SvgPicture.asset('assets/icons/setting_2.svg'),
                  const SizedBox(width: 8),
                  const Text(
                    'Настройки блокиратора',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryBlack,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              const Text(
                'Для работы приложения предоставьте доступ к блокировке вызовов',
                style: TextStyle(
                  color: AppColors.basicGrey4,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 60),
              const _StepsWidget(
                index: 1,
                title1: 'Перейдите в ',
                title2: 'Настройки ',
                title3: 'телефона;',
              ),
              const SizedBox(height: 30),
              const _StepsWidget(
                index: 2,
                title1: 'Выберите ',
                title2: '“Телефон”',
                title3: ';',
              ),
              const SizedBox(height: 30),
              const _StepsWidget(
                index: 3,
                title1: 'Выберите ',
                title2: '“Блокировка и идентификация вызова”',
                title3: ';',
              ),
              const SizedBox(height: 30),
              const _StepsWidget(
                index: 4,
                title1: 'Включите ',
                title2: '“МЮБ Спам-защитник”',
                title3: ';',
              ),
              const Spacer(),
              BorderButton(
                title: 'Перейти в настройки',
                active: true,
                onPressed: () async {
                  try {
                    await openAppSettings();
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              const SizedBox(height: 16),
              YellowButton(
                title: 'Готово',
                active: active,
                onPressed: () async {
                  await Utils.saveBool('blockSettings', true).then((_) {
                    context.go('/home');
                  });
                },
              ),
              const SizedBox(height: 76),
            ],
          ),
        ),
      ),
    );
  }
}

class _StepsWidget extends StatelessWidget {
  const _StepsWidget({
    required this.index,
    required this.title1,
    required this.title2,
    required this.title3,
  });

  final int index;
  final String title1;
  final String title2;
  final String title3;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              width: 1.5,
              color: AppColors.primaryOrange,
            ),
          ),
          child: Center(
            child: Text(
              index.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryBlack,
              ),
            ),
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: title1,
                  style: const TextStyle(
                    color: AppColors.primaryBlack,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: title2,
                  style: const TextStyle(
                    color: AppColors.primaryBlack,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: title3,
                  style: const TextStyle(
                    color: AppColors.primaryBlack,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
