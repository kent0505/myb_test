import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blocker/core/utils.dart';

import '../../../core/app_colors.dart';
import '../../../core/widgets/buttons/yellow_button.dart';
import '../../../core/widgets/textfields/email_field.dart';
import '../../../core/widgets/textfields/name_field.dart';
import '../../../core/widgets/textfields/txt_field.dart';
import '../bloc/settings_bloc.dart';

class AppealWidget extends StatefulWidget {
  const AppealWidget({super.key});

  @override
  State<AppealWidget> createState() => _AppealWidgetState();
}

class _AppealWidgetState extends State<AppealWidget> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 21),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          const Text(
            'Связаться с нами',
            style: TextStyle(
              color: AppColors.basicGrey5,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Вы можете написать разработчикам',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Если у Вас возникли вопросы, связанные с работой приложения, или Вы хотите написать отзыв, это можно сделать, заполнив форму ниже.',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryBlack,
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Как с Вами связаться?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.basicGrey4,
            ),
          ),
          const SizedBox(height: 16),
          NameField(
            controller: controller1,
            onChanged: () {
              context.read<SettingsBloc>().add(AppealButtonEvent());
            },
          ),
          const SizedBox(height: 10),
          EmailField(
            controller: controller2,
            onChanged: () {
              context.read<SettingsBloc>().add(AppealButtonEvent());
            },
          ),
          const SizedBox(height: 10),
          TxtField(
            controller: controller3,
            onChanged: () {
              context.read<SettingsBloc>().add(AppealButtonEvent());
            },
          ),
          Container(
            // color: Colors.redAccent,
            height: 14,
          ),
          BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              return YellowButton(
                title: 'Отправить',
                active: Utils.nameValid && Utils.emailValid && Utils.txtValid,
                onPressed: () {
                  context.read<SettingsBloc>().add(SubmitButtonEvent(
                        controller1.text,
                        controller2.text,
                        controller3.text,
                      ));
                },
              );
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
