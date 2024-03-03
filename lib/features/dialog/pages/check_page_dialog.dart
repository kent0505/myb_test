import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_colors.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/buttons/border_button.dart';
import '../../../core/widgets/buttons/yellow_button.dart';
import '../../../core/widgets/checkbox/checkbox_widget.dart';
import '../../../core/widgets/textfields/txt_field.dart';
import '../widgets/error_dialog_widget.dart';
import '../widgets/loading_dialog_widget.dart';
import '../widgets/success_dialog_widget.dart';
import '../bloc/dialog_bloc.dart';

class CheckPageDialog extends StatefulWidget {
  const CheckPageDialog({
    super.key,
    required this.phone,
    required this.add,
  });

  final String phone;
  final bool add;

  @override
  State<CheckPageDialog> createState() => _CheckPageDialogState();
}

class _CheckPageDialogState extends State<CheckPageDialog> {
  final controller = TextEditingController();
  final scrollController = ScrollController();

  void checkboxButton(int index) {
    context.read<DialogBloc>().add(CheckboxEvent(index));
  }

  void cancelButton() {
    context.pop();
    context.read<DialogBloc>().add(ChangeStateEvent());
  }

  void onPopInvoked(bool didPop) {
    print('POP SCOPE');
    context.read<DialogBloc>().add(ChangeStateEvent());
  }

  void addButton() {
    context.read<DialogBloc>().add(AddButtonEvent(
          widget.add,
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
    return PopScope(
      onPopInvoked: onPopInvoked,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: BlocBuilder<DialogBloc, DialogState>(
            builder: (context, state) {
              if (state is DialogLoadingState) {
                return const LoadingDialogWidget();
              }

              if (state is DialogErrorState) {
                return const ErrorDialogWidget();
              }

              if (state is DialogSuccessState) {
                return SuccessDialogWidget(phone: widget.phone);
              }

              return SingleChildScrollView(
                reverse: true,
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 24),
                      Text(
                        widget.add ? 'Добавление номера' : 'Изменение номера',
                        style: const TextStyle(
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
                          BlocBuilder<DialogBloc, DialogState>(
                            builder: (context, state) {
                              return Expanded(
                                child: YellowButton(
                                  title: 'Готово',
                                  active: Utils.checkActiveCheckboxes(),
                                  onPressed: addButton,
                                ),
                              );
                            },
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
      ),
    );
  }
}
