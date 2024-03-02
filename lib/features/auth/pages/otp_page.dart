import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/app_colors.dart';
import '../../../core/widgets/buttons/txt_button.dart';
import '../../../core/widgets/buttons/yellow_button.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/timer/timer_bloc.dart';
import '../widgets/app_logo_widget.dart';
import '../widgets/policy_buttons_widget.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final controller = TextEditingController();
  final errorController = StreamController<ErrorAnimationType>();

  @override
  void initState() {
    super.initState();
    context.read<TimerBloc>().add(StartTimerEvent());
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (_) {
        print('POP SCOPE FROM OTP PAGE');
        context.read<TimerBloc>().add(StopTimerEvent());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppLogoWidget(),
              const Spacer(),
              const Text(
                'Введите код, отправленный на Ваш номер  телефона',
                style: TextStyle(
                  color: AppColors.basicGrey5,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 22),
              PinCodeTextField(
                length: 4,
                appContext: context,
                controller: controller,
                errorAnimationController: errorController,
                obscureText: false,
                animationType: AnimationType.fade,
                textStyle: const TextStyle(
                  fontSize: 24,
                  color: Color(0xff141414),
                ),
                mainAxisAlignment: MainAxisAlignment.center,
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                pinTheme: PinTheme(
                  errorBorderColor: Colors.redAccent,
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 60,
                  fieldWidth: 60,
                  activeColor: AppColors.basicWhite1,
                  activeFillColor: AppColors.basicWhite1,
                  inactiveColor: AppColors.basicWhite1,
                  inactiveFillColor: AppColors.basicWhite1,
                  selectedColor: AppColors.basicWhite1,
                  selectedFillColor: AppColors.basicWhite1,
                  fieldOuterPadding: const EdgeInsets.symmetric(horizontal: 11),
                ),
                onCompleted: (value) {
                  setState(() {});
                },
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 30),
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is BlockerSettingsState) {
                    context.go('/block_settings');
                    context.read<TimerBloc>().add(StopTimerEvent());
                  }

                  if (state is HomeState) {
                    context.go('/home');
                    context.read<TimerBloc>().add(StopTimerEvent());
                  }

                  if (state is ReasonState) {
                    context.go('/reason');
                    context.read<TimerBloc>().add(StopTimerEvent());
                  }

                  if (state is OtpErrorState) {
                    errorController.add(ErrorAnimationType.shake);
                    controller.clear();
                  }
                },
                child: YellowButton(
                  title: 'Войти',
                  active: controller.text.length == 4,
                  onPressed: () {
                    context
                        .read<AuthBloc>()
                        .add(CheckOtpEvent(controller.text));
                  },
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: BlocBuilder<TimerBloc, TimerState>(
                  builder: (context, state) {
                    if (state is TimerStoppedState) {
                      final phone = context.read<AuthBloc>().phone;

                      return TxtButton(
                        title: 'Отправить повторно',
                        onTap: () {
                          context.read<TimerBloc>().add(StartTimerEvent());
                          context.read<AuthBloc>().add(LoginEvent(phone!));
                        },
                      );
                    } else {
                      final seconds = context.read<TimerBloc>().seconds;

                      return TxtButton(
                        title: 'Отправить повторно ($seconds)',
                        onTap: null,
                      );
                    }
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
