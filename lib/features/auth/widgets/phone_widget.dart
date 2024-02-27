import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app_colors.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/buttons/yellow_button.dart';
import '../../../core/widgets/textfields/phone_field.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/timer/timer_bloc.dart';

class PhoneWidget extends StatefulWidget {
  const PhoneWidget({super.key});

  @override
  State<PhoneWidget> createState() => _PhoneWidgetState();
}

class _PhoneWidgetState extends State<PhoneWidget> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('PHONE WIDGET');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Введите номер телефона, чтобы войти',
          style: TextStyle(
            color: AppColors.basicGrey5,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        PhoneField(
          controller: controller,
          onChanged: () {
            context.read<AuthBloc>().add(CheckValidEvent());
          },
        ),
        const SizedBox(height: 30),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is OtpState) {
              context.read<TimerBloc>().add(StartTimerEvent());
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return YellowButton(
                title: 'Войти',
                active: Utils.phoneValid,
                onPressed: () {
                  context.read<AuthBloc>().add(LoginEvent(controller.text));
                },
              );
            },
          ),
        )
      ],
    );
  }
}
