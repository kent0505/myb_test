import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/widgets/appbar/app_bar_widget.dart';
import '../../../core/widgets/buttons/yellow_button.dart';
import '../../../core/widgets/loading/loading_widget.dart';
import '../../../core/widgets/text/text_widget.dart';
import '../bloc/settings_bloc.dart';

class ContactStatusPage extends StatelessWidget {
  const ContactStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21),
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            if (state is SettingsLoadingState) {
              return const LoadingWidget();
            }

            if (state is SettingsErrorState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextWidget(
                    'Произошла ошибка, повторите чуть позже',
                    size: 25,
                    weight: 700,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 40),
                  YellowButton(
                    title: 'В главное меню',
                    active: true,
                    onPressed: () {
                      context.go('/home');
                    },
                  ),
                ],
              );
            }

            if (state is SettingsSuccessState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextWidget(
                    'Благодарим за обращение!',
                    size: 25,
                    weight: 700,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 30),
                  const TextWidget(
                    'Мы ценим каждое обращение. Вы помогаете нам стать лучше и эффективнее.',
                    size: 14,
                    weight: 400,
                    center: true,
                    color: AppColors.primaryBlack,
                  ),
                  const SizedBox(height: 16),
                  const TextWidget(
                    'Спасибо!',
                    size: 14,
                    weight: 400,
                    color: AppColors.basicGrey1,
                  ),
                  const SizedBox(height: 40),
                  YellowButton(
                    title: 'В главное меню',
                    active: true,
                    onPressed: () {
                      context.go('/home');
                    },
                  ),
                ],
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
