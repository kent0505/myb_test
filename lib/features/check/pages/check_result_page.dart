import 'package:blocker/core/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/appbar/app_bar_widget.dart';
import '../../../core/widgets/buttons/border_button.dart';
import '../../../core/widgets/buttons/yellow_button.dart';
import '../../../core/widgets/loading/loading_widget.dart';
import '../../../core/widgets/textfields/phone_field.dart';
import '../../dialog/pages/check_page_dialog.dart';
import '../bloc/check_bloc.dart';
import '../widgets/result_card_widget.dart';

class CheckResultPage extends StatefulWidget {
  const CheckResultPage({super.key});

  @override
  State<CheckResultPage> createState() => _CheckResultPageState();
}

class _CheckResultPageState extends State<CheckResultPage> {
  final controller = TextEditingController();

  void onPhoneFieldChanged() {
    context.read<CheckBloc>().add(ListenEvent());
  }

  void searchButton() {
    context.read<CheckBloc>().add(CheckButtonEvent(controller.text));
    controller.clear();
  }

  void notSpamButton() {
    context.pop();
  }

  void spamButton(String phone, bool add) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return CheckPageDialog(
          phone: phone,
          add: add,
        );
      },
    );
  }

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const TextWidget(
              'Узнайте, кто вам звонил',
              size: 24,
              weight: 700,
              color: AppColors.basicBlack3,
            ),
            const SizedBox(height: 18),
            BlocBuilder<CheckBloc, CheckState>(
              builder: (context, state) {
                return Row(
                  children: [
                    Expanded(
                      child: PhoneField(
                        controller: controller,
                        onChanged: onPhoneFieldChanged,
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 80,
                      child: YellowButton(
                        title: 'Узнать',
                        active: Utils.phoneValid,
                        onPressed: searchButton,
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
                        operator: state.operator,
                        region: state.region,
                        categories: state.categories,
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: BorderButton(
                              title: 'Не спам',
                              active: true,
                              onPressed: notSpamButton,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: YellowButton(
                              title: 'Спам',
                              icon: 'alert',
                              active: true,
                              onPressed: () {
                                spamButton(
                                  state.phone,
                                  state.categories.isEmpty,
                                );
                              },
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
