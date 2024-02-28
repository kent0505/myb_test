import 'package:flutter/material.dart';
import 'package:blocker/core/widgets/buttons/border_button.dart';
import 'package:blocker/core/widgets/buttons/yellow_button.dart';

import '../../core/app_colors.dart';
import '../../core/widgets/checkbox/checkbox_widget.dart';

class MydbPage extends StatefulWidget {
  const MydbPage({super.key});

  @override
  State<MydbPage> createState() => _MydbPageState();
}

class _MydbPageState extends State<MydbPage> {
  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21),
      child: LayoutBuilder(builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Text(
              'Моя база номеров',
              style: TextStyle(
                color: AppColors.basicGrey5,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              height: 390,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.basicWhite2,
                    blurRadius: 20,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 28),
                  const Text(
                    'Данные номера находятся в\nЧерном Списке',
                    style: TextStyle(
                      color: AppColors.primaryBlack,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 130,
                      maxHeight: 288,
                    ),
                    child: RawScrollbar(
                      controller: scrollController,
                      thumbColor: AppColors.basicWhite2,
                      thickness: 5,
                      radius: const Radius.circular(18),
                      thumbVisibility: true,
                      scrollbarOrientation: ScrollbarOrientation.right,
                      child: ListView.builder(
                        shrinkWrap: true,
                        controller: scrollController,
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return const CheckboxWidget(
                            title: '+79001235533',
                            checked: false,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 21),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: BorderButton(
                    title: 'Удалить',
                    active: false,
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: YellowButton(
                    title: 'Добавить',
                    icon: 'plus-circle',
                    active: true,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
