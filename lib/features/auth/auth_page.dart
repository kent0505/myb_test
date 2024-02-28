import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/app_colors.dart';
import '../../core/widgets/buttons/yellow_button.dart';
import '../../core/widgets/buttons/txt_button.dart';
import 'bloc/auth/auth_bloc.dart';
import 'bloc/timer/timer_bloc.dart';
import 'widgets/phone_widget.dart';
import 'widgets/otp_widget.dart';
import 'widgets/reason_widget.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    print('AUTH PAGE');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: Column(
            children: [
              _AppLogo(),
              _AppName(),
              Expanded(
                child: BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is HomeState) {
                      context.go('/home');
                      context.read<TimerBloc>().add(StopTimerEvent());
                    }

                    if (state is ReasonState) {
                      context.read<TimerBloc>().add(StopTimerEvent());
                    }
                  },
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is PhoneState) {
                        return const PhoneWidget();
                      }

                      if (state is OtpState || state is HomeState) {
                        return const OtpWidget();
                      }

                      if (state is ReasonState) {
                        return const ReasonWidget();
                      }

                      return Center(
                        child: YellowButton(
                          title: 'Войти',
                          active: true,
                          onPressed: () {
                            context.read<AuthBloc>().add(LoginInitialEvent());
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 40),
              _PolicyButtons(),
              const SizedBox(height: 76),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 40),
      child: SizedBox(
        height: 104,
        child: SvgPicture.asset('assets/images/logo.svg'),
      ),
    );
  }
}

class _AppName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'МЮБ ',
          style: TextStyle(
            color: AppColors.primaryText,
            fontSize: 20,
            fontFamily: 'Roboto Condensed',
            fontWeight: FontWeight.w700,
            height: 0.06,
            letterSpacing: -0.60,
          ),
        ),
        Text(
          'Спам-защитник',
          style: TextStyle(
            color: AppColors.primaryText,
            fontSize: 20,
            fontFamily: 'Roboto Condensed',
            fontWeight: FontWeight.w500,
            height: 0.06,
            letterSpacing: -0.60,
          ),
        ),
      ],
    );
  }
}

class _PolicyButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TxtButton(
            title: 'Политика конфиденциальности',
            onTap: () {
              context.go('/home');
            },
          ),
          TxtButton(
            title: 'Условия использования',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
