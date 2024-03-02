import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_colors.dart';
import '../../../core/utils.dart';
import '../bloc/settings_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Text(
              'Настройки',
              style: TextStyle(
                color: AppColors.basicGrey5,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Нежелательные звонки',
              style: TextStyle(
                color: AppColors.basicGrey4,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 12),
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return _SwitchTile(
                  title: 'Предупреждать',
                  subtitle:
                      'Предупреждать о нежелательных звонках, с определением номера',
                  active: Utils.warn,
                  onTap: () {
                    context.read<SettingsBloc>().add(SwitchEvent(true, false));
                  },
                );
              },
            ),
            const SizedBox(height: 24),
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return _SwitchTile(
                  title: 'Блокировать',
                  subtitle: 'Блокироать нежелательные звонки',
                  active: Utils.block,
                  onTap: () {
                    context.read<SettingsBloc>().add(SwitchEvent(false, true));
                  },
                );
              },
            ),
            const SizedBox(height: 40),
            const Text(
              'Дополнительно',
              style: TextStyle(
                color: AppColors.basicGrey4,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 12),
            _AdditionalButton(
              title: 'Политика конфиденциальности',
              asset: 'document',
              onTap: () {
                context.push('/policy');
              },
            ),
            const SizedBox(height: 12),
            _AdditionalButton(
              title: 'Условия использования',
              asset: 'clipboard_tick',
              onTap: () {
                // context.push('/terms');
                context.replace('/auth');
                Utils.token = '';
                Utils.saveData('token', '');
                Utils.saveBool('blockSettings', false);
              },
            ),
            const SizedBox(height: 12),
            _AdditionalButton(
              title: 'Связаться с нами',
              asset: 'support',
              blue: true,
              onTap: () {
                context.push('/contact');
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  const _SwitchTile({
    required this.title,
    required this.subtitle,
    required this.active,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final bool active;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: const TextStyle(
                  color: AppColors.basicGrey1,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              )
            ],
          ),
        ),
        const SizedBox(width: 50),
        _SwitchWidget(
          active: active,
          onTap: onTap,
        ),
      ],
    );
  }
}

class _SwitchWidget extends StatelessWidget {
  const _SwitchWidget({
    required this.onTap,
    required this.active,
  });

  final void Function() onTap;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 24,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: active ? AppColors.primaryOrange : AppColors.basicWhite1,
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            right: active ? 3 : 19,
            left: active ? 19 : 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 3,
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 18,
                width: 18,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: active ? Colors.white : AppColors.basicGrey5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AdditionalButton extends StatelessWidget {
  const _AdditionalButton({
    required this.title,
    required this.asset,
    this.blue = false,
    required this.onTap,
  });

  final String title;
  final String asset;
  final bool blue;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SvgPicture.asset('assets/icons/$asset.svg', height: 18),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: onTap,
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              shadows: [
                Shadow(
                  color: blue ? AppColors.brandSky : AppColors.primaryBlack,
                  offset: const Offset(0, -1.5),
                )
              ],
              color: Colors.transparent,
              decoration: TextDecoration.underline,
              decorationColor:
                  blue ? AppColors.brandSky : AppColors.primaryBlack,
              decorationThickness: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
