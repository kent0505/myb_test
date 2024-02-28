import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_colors.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/buttons/yellow_button.dart';
import '../../../core/widgets/textfields/phone_field.dart';
import '../bloc/check_bloc.dart';

class CheckPage extends StatefulWidget {
  const CheckPage({super.key});

  @override
  State<CheckPage> createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                const Text(
                  'Узнайте, кто вам звонил',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.basicBlack3,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
                Positioned(
                  top: 2,
                  right: 0,
                  child: Container(
                    height: 3,
                    width: 115,
                    color: AppColors.primaryOrange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: PhoneField(
                    controller: controller,
                    onChanged: () {
                      context.read<CheckBloc>().add(ListenEvent());
                    },
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 80,
                  child: BlocBuilder<CheckBloc, CheckState>(
                    builder: (context, state) {
                      return YellowButton(
                        title: 'Узнать',
                        active: Utils.phoneValid,
                        onPressed: () {
                          setState(() {});
                          context
                              .read<CheckBloc>()
                              .add(CheckButtonEvent(controller.text));
                          controller.clear();
                          context.push('/check_result');
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
