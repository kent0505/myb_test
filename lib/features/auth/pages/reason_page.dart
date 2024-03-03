import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/buttons/yellow_button.dart';
import '../../../core/widgets/checkbox/checkbox_widget.dart';
import '../../../core/widgets/text/yellow_line_widget.dart';
import '../bloc/auth/auth_bloc.dart';
import '../widgets/app_logo_widget.dart';
import '../widgets/policy_buttons_widget.dart';

class ReasonPage extends StatefulWidget {
  const ReasonPage({super.key});

  @override
  State<ReasonPage> createState() => _ReasonPageState();
}

class _ReasonPageState extends State<ReasonPage> {
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21),
        child: Column(
          children: [
            const AppLogoWidget(),
            const Spacer(),
            const YellowLineTextWidget(
              'Для каких целей\nВы будете использовать приложение?',
              size: 20,
              width: 102,
              right: 10,
              bottom: 18,
            ),
            const SizedBox(height: 55),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: Column(
                children: [
                  CheckboxWidget(
                    'Защищаюсь от коллекторов/банков',
                    checked: checked1,
                    onTap: () {
                      change(true);
                    },
                  ),
                  CheckboxWidget(
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
            const PolicyButtonsWidget(),
          ],
        ),
      ),
    );
  }
}
