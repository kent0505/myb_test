import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/buttons/yellow_button.dart';
import '../widgets/app_logo_widget.dart';
import '../widgets/policy_buttons_widget.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: Column(
            children: [
              const AppLogoWidget(),
              const Spacer(),
              YellowButton(
                title: 'Войти',
                active: true,
                onPressed: () {
                  context.push('/phone');
                },
              ),
              const Spacer(),
              const PolicyButtonsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
