import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/widgets/appbar/app_bar_widget.dart';
import '../../../core/widgets/buttons/yellow_button.dart';
import '../../../core/widgets/loading/loading_widget.dart';
import '../bloc/help_bloc.dart';

class HelpStatusPage extends StatelessWidget {
  const HelpStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21),
        child: BlocBuilder<HelpBloc, HelpState>(
          builder: (context, state) {
            if (state is HelpLoadingState) {
              return const LoadingWidget();
            }

            if (state is HelpErrorState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Произошла ошибка, повторите чуть позже',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                    ),
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

            if (state is HelpSuccessState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Благодарим за доверие!',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'В ближайшее время с вами свяжется юрист для уточнения деталей Вашей ситуации.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Пожалуйста, ответьте на входящий звонок.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.basicGrey1,
                    ),
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
