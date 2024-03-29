import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/config/app_colors.dart';
import '../../core/utils.dart';
import '../../core/widgets/buttons/border_button.dart';
import '../../core/widgets/buttons/yellow_button.dart';
import '../../core/widgets/checkbox/checkbox_widget.dart';
import '../../core/widgets/loading/loading_widget.dart';
import '../../core/widgets/text/text_widget.dart';
import '../dialog/pages/mydb_page_dialog.dart';
import 'bloc/mydb_bloc.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          const TextWidget(
            'Моя база номеров',
            size: 20,
            weight: 500,
            color: AppColors.basicGrey5,
          ),
          const SizedBox(height: 30),
          Container(
            height: 390,
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
            child: BlocBuilder<MydbBloc, MydbState>(
              builder: (context, state) {
                if (state is MydbLodingState) {
                  return const LoadingWidget();
                }

                if (state is MydbLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 28),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextWidget(
                          'Данные номера находятся в\nЧерном Списке',
                          size: 16,
                          weight: 500,
                          color: AppColors.primaryBlack,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 4,
                        ),
                        child: ConstrainedBox(
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
                            child: RefreshIndicator(
                              onRefresh: () async {
                                context
                                    .read<MydbBloc>()
                                    .add(GetBlacklistEvent());
                              },
                              child: ListView.builder(
                                controller: scrollController,
                                physics: const AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.blacklist.length,
                                itemBuilder: (context, index) {
                                  return CheckboxWidget(
                                    state.blacklist[index].phone,
                                    checked: state.blacklist[index].checked,
                                    onTap: () {
                                      context
                                          .read<MydbBloc>()
                                          .add(CheckboxEvent(index));
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 21),
                    ],
                  );
                }

                return Container();
              },
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<MydbBloc, MydbState>(
                builder: (context, state) {
                  return Expanded(
                    child: BorderButton(
                      title: 'Удалить',
                      active: Utils.phoneChecked() && state is! MydbLodingState,
                      onPressed: () {
                        context.read<MydbBloc>().add(DeletePhoneEvent());
                      },
                    ),
                  );
                },
              ),
              const SizedBox(width: 12),
              Expanded(
                child: YellowButton(
                  title: 'Добавить',
                  icon: 'plus-circle',
                  active: true,
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return const MydbPageDialog();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
