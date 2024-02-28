import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_colors.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/appbar/app_bar_widget.dart';
import '../../../core/widgets/buttons/yellow_button.dart';
import '../../../core/widgets/textfields/email_field.dart';
import '../../../core/widgets/textfields/name_field.dart';
import '../../../core/widgets/textfields/phone_field.dart';
import '../bloc/help_bloc.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
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
    print('BUILD HELP PAGE');
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Text(
              'Помощь',
              style: TextStyle(
                color: AppColors.basicGrey5,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    const Text(
                      'Поможем выйти \nиз трудной ситуации',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                      ),
                    ),
                    Positioned(
                      bottom: 24,
                      right: 0,
                      child: Container(
                        height: 3,
                        width: 96,
                        color: AppColors.primaryOrange,
                      ),
                    ),
                  ],
                ),
                SvgPicture.asset(
                  'assets/images/heart.svg',
                  width: 56,
                  height: 56,
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              'Предоставим бесплатную консультацию по борьбе с долгами, общению с кредиторами и всем возможным способам избавления от кредитов.',
              style: TextStyle(
                color: AppColors.basicGrey1,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Как с Вами связаться?',
              style: TextStyle(
                color: AppColors.basicGrey4,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            NameField(
              controller: controller1,
              onChanged: () {
                context.read<HelpBloc>().add(CheckEvent());
              },
            ),
            const SizedBox(height: 10),
            PhoneField(
              controller: controller2,
              shadow: false,
              onChanged: () {
                context.read<HelpBloc>().add(CheckEvent());
              },
            ),
            const SizedBox(height: 10),
            EmailField(
              controller: controller3,
              onChanged: () {
                context.read<HelpBloc>().add(CheckEvent());
              },
            ),
            const SizedBox(height: 40),
            BlocBuilder<HelpBloc, HelpState>(
              builder: (context, state) {
                return YellowButton(
                  title: 'Получить консультацию',
                  active:
                      Utils.nameValid && Utils.phoneValid && Utils.emailValid,
                  onPressed: () {
                    context.read<HelpBloc>().add(HelpButtonEvent(
                          controller1.text,
                          controller2.text,
                          controller3.text,
                        ));
                    context.go('/help_status');
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
