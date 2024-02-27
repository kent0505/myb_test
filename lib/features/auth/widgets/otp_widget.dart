import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/app_colors.dart';
import '../../../core/widgets/buttons/yellow_button.dart';
import '../../../core/widgets/buttons/txt_button.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/timer/timer_bloc.dart';

class OtpWidget extends StatefulWidget {
  const OtpWidget({super.key});

  @override
  State<OtpWidget> createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpWidget> {
  final controller = TextEditingController();
  final errorController = StreamController<ErrorAnimationType>();

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
        YellowButton(
          title: 'Войти',
          active: controller.text.length == 4,
          onPressed: () {
            final otp = context.read<AuthBloc>().otp;

            if (controller.text == otp) {
              context.read<AuthBloc>().add(CheckOtpEvent(controller.text));
            } else {
              errorController.add(ErrorAnimationType.shake);
              controller.clear();
              setState(() {});
            }
          },
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
      ],
    );
  }
}
