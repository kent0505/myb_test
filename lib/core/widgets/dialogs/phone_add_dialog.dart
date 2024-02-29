import 'package:blocker/core/widgets/loading/loading_widget.dart';
import 'package:blocker/features/check/bloc/check_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../features/mydb/bloc/mydb_bloc.dart';
import '../../app_colors.dart';
import '../../utils.dart';
import '../buttons/border_button.dart';
import '../buttons/yellow_button.dart';
import '../checkbox/checkbox_widget.dart';
import '../textfields/txt_field.dart';

class PhoneAddDialog extends StatefulWidget {
  const PhoneAddDialog({
    super.key,
    required this.phone,
  });

  final String phone;

  @override
  State<PhoneAddDialog> createState() => _PhoneAddDialogState();
}

class _PhoneAddDialogState extends State<PhoneAddDialog> {
  final controller = TextEditingController();
  final scrollController = ScrollController();
  List<int> cid = [];

  void getCid() {
    cid = [];
    for (var category in Utils.categories) {
      if (category.checked) {
        cid.add(category.id);
      }
    }
  }

  void deactivateSwitches() {
    for (var category in Utils.categories) {
      if (category.checked) {
        category.checked = false;
      }
    }
  }

  bool checkActiveSwitches() {
    for (var category in Utils.categories) {
      if (category.checked) {
        return true;
      }
    }
    return false;
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: BlocBuilder<CheckBloc, CheckState>(
          builder: (context, state) {
            if (state is CheckLoadingState) {
              return const SizedBox(
                height: 342,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadingWidget(),
                  ],
                ),
              );
            }

            if (state is ErrorState) {
              return SizedBox(
                height: 342,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Spacer(),
                    const Text(
                      'Произошла ошибка!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryText,
                      ),
                    ),
                    const Spacer(),
                    YellowButton(
                      title: 'В главное меню',
                      active: true,
                      onPressed: () {
                        context.go('/home');
                        deactivateSwitches();
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              );
            }

            if (state is AddedState) {
              return SizedBox(
                height: 342,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 40),
                    SvgPicture.asset(
                      'assets/icons/check-circle-2.svg',
                      height: 65,
                      width: 65,
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Номер добавлен в спам!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryText,
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Спасибо, что пополняете базу\nнежелательных номеров.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryBlack,
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Это поможет другим пользователям.',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.basicGrey1,
                      ),
                    ),
                    const SizedBox(height: 40),
                    YellowButton(
                      title: 'В главное меню',
                      active: true,
                      onPressed: () {
                        context.go('/home');
                        context.read<MydbBloc>().add(GetBlacklistEvent());
                        deactivateSwitches();
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              );
            }

            return SingleChildScrollView(
              reverse: true,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 900),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 24),
                    const Text(
                      'Добавление номера',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.basicGrey4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.phone,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryText,
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Пометить как:',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.basicGrey1,
                      ),
                    ),
                    const SizedBox(height: 5),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 284,
                        minHeight: 0,
                      ),
                      child: RawScrollbar(
                        controller: scrollController,
                        thumbColor: AppColors.basicWhite2,
                        thickness: 5,
                        radius: const Radius.circular(18),
                        thumbVisibility: true,
                        scrollbarOrientation: ScrollbarOrientation.right,
                        child: ListView.builder(
                          controller: scrollController,
                          shrinkWrap: true,
                          itemCount: Utils.categories.length,
                          itemBuilder: (context, index) {
                            return CheckboxWidget(
                              title: Utils.categories[index].name,
                              checked: Utils.categories[index].checked,
                              onTap: () {
                                setState(() {
                                  Utils.categories[index].checked =
                                      !Utils.categories[index].checked;
                                });
                                getCid();
                                print(cid);
                                print(Utils.categories[index].id);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TxtField(
                      controller: controller,
                      hintText: 'Оставьте комментарий',
                      onChanged: () {},
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: BorderButton(
                            title: 'Отменить',
                            active: true,
                            onPressed: () {
                              context.pop();
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: YellowButton(
                            title: 'Готово',
                            active: checkActiveSwitches(),
                            onPressed: () {
                              context.read<CheckBloc>().add(AddToBlacklistEvent(
                                    widget.phone,
                                    cid,
                                    controller.text,
                                  ));
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      // child: Stack(
      //   children: [

      //     Positioned(
      //       top: 12,
      //       right: 12,
      //       child: InkWell(
      //         onTap: () {
      //           context.pop();
      //         },
      //         child: SvgPicture.asset(
      //           'assets/icons/x.svg',
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
