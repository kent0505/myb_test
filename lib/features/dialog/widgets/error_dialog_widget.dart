import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/widgets/buttons/yellow_button.dart';
import '../../../core/widgets/text/text_widget.dart';
import '../bloc/dialog_bloc.dart';

class ErrorDialogWidget extends StatelessWidget {
  const ErrorDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 342,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Spacer(),
          const TextWidget(
            'Произошла ошибка!',
            size: 24,
            weight: 500,
            color: AppColors.primaryText,
          ),
          const Spacer(),
          YellowButton(
            title: 'В главное меню',
            active: true,
            onPressed: () {
              context.pop();
              context.read<DialogBloc>().add(ChangeStateEvent());
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
