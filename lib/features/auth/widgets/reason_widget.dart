import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_colors.dart';
import '../../../core/widgets/checkbox/checkbox_widget.dart';
import '../../../core/widgets/buttons/yellow_button.dart';
import '../bloc/auth/auth_bloc.dart';

class ReasonWidget extends StatefulWidget {
  const ReasonWidget({super.key});

  @override
  State<ReasonWidget> createState() => _ReasonWidgetState();
}

class _ReasonWidgetState extends State<ReasonWidget> {
  bool checked1 = false;
  bool checked2 = false;

  void change(bool first) {
    setState(() {
      if (first) {
        if (checked2) {
          checked2 = false;
        }
        checked1 = !checked1;
      } else {
        if (checked1) {
          checked1 = false;
        }
        checked2 = !checked2;
      }
    });
    print(checked1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const Spacer(),
        Stack(
          children: [
            const Text(
              'Для каких целей\nВы будете использовать приложение?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryBlack,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Positioned(
              bottom: 18,
              right: 10,
              child: Container(
                height: 3,
                width: 102,
                color: AppColors.primaryOrange,
              ),
            ),
          ],
        ),
        const SizedBox(height: 55),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45),
          child: Column(
            children: [
              CheckboxWidget(
                title: 'Защищаюсь от коллекторов/банков',
                checked: checked1,
                onTap: () {
                  change(true);
                },
              ),
              CheckboxWidget(
                title:
                    'Я занятой человек, не хочу получать нежелательные звонки',
                checked: checked2,
                onTap: () {
                  change(false);
                },
              ),
            ],
          ),
        ),
        const Spacer(),
        YellowButton(
          title: 'Войти',
          active: checked1 || checked2,
          onPressed: () {
            context.read<AuthBloc>().add(ReasonEvent(checked1));
            context.go('/onboard');
          },
        ),
      ],
    );
  }
}
