import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/buttons/txt_button.dart';

class PolicyButtonsWidget extends StatelessWidget {
  const PolicyButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 76),
      child: Center(
        child: SizedBox(
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TxtButton(
                title: 'Политика конфиденциальности',
                onTap: () {
                  context.push('/policy');
                },
              ),
              TxtButton(
                title: 'Условия использования',
                onTap: () {
                  context.push('/terms');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
