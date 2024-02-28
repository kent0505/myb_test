import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app_colors.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/appbar/app_bar_widget.dart';
import '../../../core/widgets/buttons/border_button.dart';
import '../../../core/widgets/buttons/yellow_button.dart';
import '../../../core/widgets/loading/loading_widget.dart';
import '../../../core/widgets/textfields/phone_field.dart';
import '../bloc/check_bloc.dart';
import '../widgets/result_card_widget.dart';

class CheckResultPage extends StatefulWidget {
  const CheckResultPage({super.key});

  @override
  State<CheckResultPage> createState() => _CheckResultPageState();
}

class _CheckResultPageState extends State<CheckResultPage> {
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
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              'Узнайте, кто вам звонил',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.basicBlack3,
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 18),
            BlocBuilder<CheckBloc, CheckState>(
              builder: (context, state) {
                return Row(
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
                      child: YellowButton(
                        title: 'Узнать',
                        active: Utils.phoneValid,
                        onPressed: () {
                          context
                              .read<CheckBloc>()
                              .add(CheckButtonEvent(controller.text));
                          controller.clear();
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 40),
            BlocBuilder<CheckBloc, CheckState>(
              builder: (context, state) {
                if (state is CheckLoadingState) {
                  return const Expanded(
                    child: LoadingWidget(),
                  );
                }

                if (state is CheckResultState) {
                  return Column(
                    children: [
                      ResultCardWidget(
                        phone: state.phone,
                        blocked: state.blocked,
                        operator: state.operator,
                        region: state.region,
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: BorderButton(
                              title: 'Не спам',
                              active: true,
                              onPressed: () {},
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: YellowButton(
                              title: 'Спам',
                              icon: 'alert',
                              active: true,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }

                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
