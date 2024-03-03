import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/buttons/yellow_button.dart';
import '../../../core/widgets/textfields/phone_field.dart';
import '../bloc/auth/auth_bloc.dart';
import '../widgets/app_logo_widget.dart';
import '../widgets/policy_buttons_widget.dart';

class PhonePage extends StatefulWidget {
  const PhonePage({super.key});

  @override
  State<PhonePage> createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppLogoWidget(),
              const Spacer(),
              const Text(
                'Введите номер телефона, чтобы войти',
                style: TextStyle(
                  color: AppColors.basicGrey5,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return PhoneField(
                    controller: controller,
                    onChanged: () {
                      context.read<AuthBloc>().add(CheckEvent());
                    },
                  );
                },
              ),
              const SizedBox(height: 30),
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is OtpState) {
                    context.push('/otp');
                  }
                },
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return YellowButton(
                      title: 'Войти',
                      active: Utils.phoneValid,
                      onPressed: () {
                        context
                            .read<AuthBloc>()
                            .add(LoginEvent(controller.text));
                        controller.clear();
                      },
                    );
                  },
                ),
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
