import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/buttons/additional_button.dart';
import '../../../core/widgets/checkbox/switch_widget.dart';
import '../../../core/widgets/text/text_widget.dart';
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
            const TextWidget(
              'Настройки',
              size: 20,
              weight: 500,
              color: AppColors.basicGrey5,
            ),
            const SizedBox(height: 40),
            const TextWidget(
              'Нежелательные звонки',
              size: 12,
              weight: 400,
              color: AppColors.basicGrey4,
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
            const TextWidget(
              'Дополнительно',
              size: 12,
              weight: 400,
              color: AppColors.basicGrey4,
            ),
            const SizedBox(height: 12),
            AdditionalButton(
              title: 'Политика конфиденциальности',
              asset: 'document',
              onTap: () {
                context.push('/policy');
              },
            ),
            const SizedBox(height: 12),
            AdditionalButton(
              title: 'Условия использования',
              asset: 'clipboard_tick',
              onTap: () {
                context.push('/terms');
              },
            ),
            const SizedBox(height: 12),
            AdditionalButton(
              title: 'Связаться с нами',
              asset: 'support',
              blue: true,
              onTap: () {
                context.push('/contact');
              },
            ),
            const SizedBox(height: 12),
            AdditionalButton(
              title: 'Выход',
              asset: '',
              onTap: () {
                context.replace('/auth');
                Utils.token = '';
                Utils.saveData('token', '');
                Utils.saveBool('blockSettings', false);
              },
            ),
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
              TextWidget(
                title,
                size: 14,
                weight: 500,
                color: AppColors.primaryText,
              ),
              const SizedBox(height: 6),
              TextWidget(
                subtitle,
                size: 12,
                weight: 400,
                color: AppColors.basicGrey1,
              ),
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
