import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../features/check/bloc/check_bloc.dart';
import '../../app_colors.dart';
import '../../utils.dart';
import '../buttons/border_button.dart';
import '../buttons/yellow_button.dart';
import '../checkbox/checkbox_widget.dart';
import '../textfields/txt_field.dart';
import 'widgets/error_dialog_widget.dart';
import 'widgets/loading_dialog_widget.dart';
import 'widgets/success_dialog_widget.dart';

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

  void checkboxButton(int index) {
    setState(() {
      Utils.categories[index].checked = !Utils.categories[index].checked;
    });
    Utils.getCid();
  }

  void cancelButton() {
    context.pop();
    Utils.clearData();
  }

  void addButton() {
    context.read<CheckBloc>().add(AddToBlacklistEvent(
          widget.phone,
          Utils.cid,
          controller.text,
        ));
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
              return const LoadingDialogWidget();
            }

            if (state is ErrorState) {
              return const ErrorDialogWidget();
            }

            if (state is AddedState) {
              return const SuccessDialogWidget();
            }

            return SingleChildScrollView(
              reverse: true,
              child: SizedBox(
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
                                checkboxButton(index);
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
                            onPressed: cancelButton,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: YellowButton(
                            title: 'Готово',
                            active: Utils.checkActiveCheckboxes(),
                            onPressed: addButton,
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
    );
  }
}
