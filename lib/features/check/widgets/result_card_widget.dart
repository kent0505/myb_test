import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/app_colors.dart';
import '../bloc/check_bloc.dart';

class ResultCardWidget extends StatelessWidget {
  const ResultCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckBloc, CheckState>(
      builder: (context, state) {
        if (state is CheckResultState) {
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
                  state.phone,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    SvgPicture.asset(
                      state.blocked == 0
                          ? 'assets/icons/tick.svg'
                          : 'assets/icons/search.svg',
                      width: 18,
                      height: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      state.blocked == 0
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
                state.blocked == 0
                    ? Container()
                    : const Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: [
                            _ResultCategoryWidget(
                              text: 'Коллектор',
                              textColor: AppColors.brandRed,
                              containerColor: Color(0x1af4404c),
                              containerWidth: 70,
                            ),
                            _ResultCategoryWidget(
                              text: 'Кредитор',
                              textColor: AppColors.brandRed,
                              containerColor: Color(0x1af4404c),
                              containerWidth: 70,
                            ),
                            _ResultCategoryWidget(
                              text: 'Мошенники  ',
                              textColor: AppColors.brandRed,
                              containerColor: Color(0x1af4404c),
                              containerWidth: 80,
                            ),
                            _ResultCategoryWidget(
                              text: 'Спам',
                              textColor: AppColors.statusOrange,
                              containerColor: Color(0x2aFB8D0F),
                              containerWidth: 50,
                            ),
                            _ResultCategoryWidget(
                              text: 'Риелторы',
                              textColor: AppColors.brandSky,
                              containerColor: Color(0x3300B2FF),
                              containerWidth: 70,
                            ),
                            _ResultCategoryWidget(
                              text: 'Реклама',
                              textColor: AppColors.statusOrange,
                              containerColor: Color(0x20FB8D0F),
                              containerWidth: 70,
                            ),
                          ],
                        ),
                      ),
                state.operator.isNotEmpty && state.region.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: Row(
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
                            Text(
                              '${state.operator}\n${state.region}',
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: AppColors.primaryBlack,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                const SizedBox(height: 24),
                _SearchInternetButton(
                  active: false,
                  onPressed: () {},
                ),
              ],
            ),
          );
        }

        return Container();
      },
    );
  }
}

class _ResultCategoryWidget extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color containerColor;
  final double containerWidth;

  const _ResultCategoryWidget({
    required this.text,
    required this.textColor,
    required this.containerColor,
    required this.containerWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerWidth,
      height: 40,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
      ),
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
