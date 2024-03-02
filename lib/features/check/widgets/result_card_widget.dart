import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/app_colors.dart';
import '../../../core/utils.dart';

class ResultCardWidget extends StatelessWidget {
  const ResultCardWidget({
    super.key,
    required this.phone,
    required this.blocked,
    required this.operator,
    required this.region,
    required this.categories,
  });

  final String phone;
  final int blocked;
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
          Text(
            phone,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              SvgPicture.asset(
                blocked == 0
                    ? 'assets/icons/tick.svg'
                    : 'assets/icons/search.svg',
                width: 18,
                height: 18,
              ),
              const SizedBox(width: 8),
              Text(
                blocked == 0
                    ? 'Номер не числится в спам-базах'
                    : 'Найденные отметки у номера:',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.basicGrey1,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          blocked == 0
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: [
                      if (categories.isEmpty) ...[
                        const _ResultCategoryWidget(
                          text: 'Другое',
                          id: 0,
                        ),
                      ],
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
                      const Text(
                        'Информация \nо номере:',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: AppColors.basicGrey1,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              operator,
                              style: const TextStyle(
                                color: AppColors.primaryBlack,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              region,
                              style: const TextStyle(
                                color: AppColors.primaryBlack,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          const SizedBox(height: 24),
          _SearchInternetButton(
            active: false,
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
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: getTextColor(id),
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SearchInternetButton extends StatelessWidget {
  const _SearchInternetButton({
    required this.active,
    required this.onPressed,
  });

  final bool active;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: active ? onPressed : null,
        borderRadius: BorderRadius.circular(8),
        splashColor: Colors.yellow[600],
        splashFactory: InkRipple.splashFactory,
        child: Ink(
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: active ? AppColors.primaryOrange : AppColors.basicWhite2,
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/global_search.svg',
                width: 18,
                height: 18,
              ),
              const SizedBox(width: 8),
              const Text(
                'Искать в интернете',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.primaryBlack,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
