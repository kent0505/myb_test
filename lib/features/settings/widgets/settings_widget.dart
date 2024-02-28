import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:blocker/core/utils.dart';

import '../../../core/app_colors.dart';
import '../bloc/settings_bloc.dart';
import 'switch_widget.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            onTap: () {},
          ),
          const SizedBox(height: 12),
          _AdditionalButton(
            title: 'Условия использования',
            asset: 'clipboard_tick',
            onTap: () {},
          ),
          const SizedBox(height: 12),
          _AdditionalButton(
            title: 'Связаться с нами',
            asset: 'support',
            blue: true,
            onTap: () {
              context.read<SettingsBloc>().add(AppealButtonEvent());
            },
          ),
          const SizedBox(height: 30),
        ],
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
        SwitchWidget(
          active: active,
          onTap: onTap,
        ),
      ],
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
      children: [
        SvgPicture.asset('assets/icons/$asset.svg', height: 18),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: onTap,
          child: Text(
            title,
            style: TextStyle(
              color: blue ? AppColors.brandSky : AppColors.primaryBlack,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
