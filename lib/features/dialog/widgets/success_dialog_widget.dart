import 'package:blocker/features/dialog/bloc/dialog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../mydb/bloc/mydb_bloc.dart';
import '../../../core/app_colors.dart';
import '../../../core/widgets/buttons/yellow_button.dart';

class SuccessDialogWidget extends StatelessWidget {
  const SuccessDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 342,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 40),
          SvgPicture.asset(
            'assets/icons/check-circle-2.svg',
            height: 65,
            width: 65,
          ),
          const SizedBox(height: 18),
          const Text(
            'Номер добавлен в спам!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Спасибо, что пополняете базу\nнежелательных номеров.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryBlack,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Это поможет другим пользователям.',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.basicGrey1,
            ),
          ),
          const SizedBox(height: 40),
          YellowButton(
            title: 'В главное меню',
            active: true,
            onPressed: () {
              context.pop();
              context.read<DialogBloc>().add(ChangeStateEvent());
              context.read<MydbBloc>().add(GetBlacklistEvent());
              // deactivateSwitches();
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
