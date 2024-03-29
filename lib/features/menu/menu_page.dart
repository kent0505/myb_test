import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/config/app_colors.dart';
import '../../core/utils.dart';
import '../../core/widgets/text/yellow_line_widget.dart';
import '../../core/widgets/buttons/border_button.dart';
import '../../core/widgets/buttons/yellow_button.dart';
import '../../core/widgets/checkbox/checkbox_widget.dart';
import '../dialog/pages/menu_page_dialog.dart';
import '../../core/widgets/loading/loading_widget.dart';
import '../home/bloc/home_bloc.dart';
import 'bloc/menu_bloc.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
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
          const YellowLineTextWidget(
            'Какие звонки \nВы хотите блокировать?',
            size: 20,
            width: 58,
            top: 2,
            left: 56,
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
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 15,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: 374,
                  maxHeight: 374,
                ),
                child: BlocBuilder<MenuBloc, MenuState>(
                  builder: (context, state) {
                    if (state is MenuLoadingState) {
                      return const LoadingWidget();
                    }

                    if (state is MenuLoadedState) {
                      return RawScrollbar(
                        controller: scrollController,
                        thumbColor: AppColors.basicWhite2,
                        thickness: 5,
                        radius: const Radius.circular(18),
                        thumbVisibility: true,
                        scrollbarOrientation: ScrollbarOrientation.right,
                        child: ListView(
                          controller: scrollController,
                          shrinkWrap: true,
                          children: [
                            CheckboxWidget(
                              'Все незнакомые номера',
                              checked: Utils.allNumbers,
                              onTap: () {
                                context.read<MenuBloc>().add(BlockAllNumbers());
                              },
                            ),
                            CheckboxWidget(
                              'Моя база номеров',
                              checked: Utils.mydbNumbers,
                              onTap: () {
                                context
                                    .read<MenuBloc>()
                                    .add(BlockMydbNumbers());
                              },
                            ),
                            const SizedBox(height: 12),
                            for (var category in state.categories) ...[
                              CheckboxWidget(
                                category.name,
                                checked: category.checked,
                                onTap: () {
                                  context
                                      .read<MenuBloc>()
                                      .add(BlockCategory(category.id));
                                },
                              ),
                            ],
                          ],
                        ),
                      );
                    }

                    return Container();
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          const _InfoButton(),
          const SizedBox(height: 4),
          Stack(
            children: [
              YellowButton(
                title: 'Обновить базу',
                active: true,
                onPressed: () {
                  context.read<MenuBloc>().add(GetCategoriesEvent());
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          BorderButton(
            title: 'Блокировать / Предупреждать',
            active: true,
            onPressed: () {
              context.read<HomeBloc>().add(ChangePageEvent(4));
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _InfoButton extends StatelessWidget {
  const _InfoButton();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Material(
        borderRadius: BorderRadius.circular(50),
        child: InkWell(
          onTap: () async {
            await showDialog(
              context: context,
              builder: (context) {
                return const MenuPageDialog();
              },
            );
          },
          borderRadius: BorderRadius.circular(50),
          child: Ink(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Center(
              child: Text('?'),
            ),
          ),
        ),
      ),
    );
  }
}
