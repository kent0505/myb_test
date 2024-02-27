import 'package:flutter/material.dart';
import 'package:myb_test/core/widgets/buttons/border_button.dart';
import 'package:myb_test/core/widgets/checkbox/checkbox_widget.dart';

import '../../core/app_colors.dart';
// import '../../core/widgets/custom_checkbox_widget.dart';
import '../../core/widgets/buttons/yellow_button.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    print('BUILD MENU PAGE');
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Text(
              'Какие звонки \nВы хотите блокировать?',
              style: TextStyle(
                color: AppColors.basicBlack3,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 20,
                    color: Color(0xffdee6ef),
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CheckboxWidget(
                      title: 'Коллекторы',
                      checked: false,
                    ),
                    CheckboxWidget(
                      title: 'Мобильные операторы',
                      checked: false,
                    ),
                    CheckboxWidget(
                      title: 'Интернет провайдеры',
                      checked: false,
                    ),
                    CheckboxWidget(
                      title: 'Мошенники',
                      checked: false,
                    ),
                    CheckboxWidget(
                      title: 'Банки, Микрозаймы',
                      checked: false,
                    ),
                    CheckboxWidget(
                      title: 'Социальные опросы',
                      checked: false,
                    ),
                    CheckboxWidget(
                      title: 'Риелторы',
                      checked: false,
                    ),
                    CheckboxWidget(
                      title: 'Реклама',
                      checked: false,
                    ),
                    SizedBox(height: 12),
                    CheckboxWidget(
                      title: 'Все незнакомые номера',
                      checked: false,
                    ),
                    CheckboxWidget(
                      title: 'Моя база номеров',
                      checked: false,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            YellowButton(
              title: 'Обновить базу',
              active: true,
              onPressed: () {},
            ),
            const SizedBox(height: 16),
            BorderButton(
              title: 'Блокировать / Предупреждать',
              active: true,
              onPressed: () {},
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
