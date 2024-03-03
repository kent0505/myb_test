import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/buttons/border_button.dart';
import '../../../core/widgets/text/text_widget.dart';

class ResultCardWidget extends StatelessWidget {
  const ResultCardWidget({
    super.key,
    required this.phone,
    required this.operator,
    required this.region,
    required this.categories,
  });

  final String phone;
  final String operator;
  final String region;
  final List<int> categories;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 24,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            blurRadius: 20,
            offset: Offset(0, 0),
            color: Color(0xffdee6ef),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            phone,
            size: 24,
            weight: 500,
            color: AppColors.primaryText,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              SvgPicture.asset(
                categories.isEmpty
                    ? 'assets/icons/tick.svg'
                    : 'assets/icons/search.svg',
                width: 18,
                height: 18,
              ),
              const SizedBox(width: 8),
              TextWidget(
                categories.isEmpty
                    ? 'Номер не числится в спам-базах'
                    : 'Найденные отметки у номера:',
                size: 14,
                weight: 400,
                color: AppColors.basicGrey1,
              ),
            ],
          ),
          categories.isEmpty
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: [
                      for (var id in categories) ...[
                        for (var category in Utils.categories) ...[
                          if (category.id == id) ...[
                            _ResultCategoryWidget(
                              text: category.name,
                              id: category.id,
                            ),
                          ]
                        ]
                      ],
                    ],
                  ),
                ),
          operator.isNotEmpty && region.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextWidget(
                        'Информация \nо номере:',
                        size: 14,
                        weight: 400,
                        color: AppColors.basicGrey1,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              operator,
                              size: 14,
                              weight: 400,
                              color: AppColors.primaryBlack,
                            ),
                            TextWidget(
                              region,
                              size: 14,
                              weight: 400,
                              color: AppColors.primaryBlack,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          const SizedBox(height: 24),
          BorderButton(
            title: 'Искать в интернете',
            active: false,
            icon: 'global_search',
            onPressed: () {
              // context.push('/web', extra: '79005555555');
            },
          ),
        ],
      ),
    );
  }
}

class _ResultCategoryWidget extends StatelessWidget {
  final String text;
  final int id;

  const _ResultCategoryWidget({
    required this.text,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          height: 40,
          decoration: BoxDecoration(
            color: getColor(id),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: TextWidget(
              text,
              size: 12,
              weight: 400,
              color: getTextColor(id),
            ),
          ),
        ),
      ],
    );
  }
}
