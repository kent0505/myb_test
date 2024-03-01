import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/app_colors.dart';
import '../../core/widgets/buttons/border_button.dart';
import '../../core/widgets/buttons/yellow_button.dart';
import '../../core/widgets/checkbox/checkbox_widget.dart';
import '../../core/widgets/dialogs/info_dialog.dart';
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
    print('BUILD MENU PAGE');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21),
      child: BlocBuilder<MenuBloc, MenuState>(
        builder: (context, state) {
          if (state is MenuLoadingState) {
            return const LoadingWidget();
          }

          if (state is MenuLoadedState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Stack(
                  children: [
                    const Text(
                      'Какие звонки \nВы хотите блокировать?',
                      style: TextStyle(
                        color: AppColors.basicBlack3,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Positioned(
                      top: 2,
                      left: 56,
                      child: Container(
                        height: 3,
                        width: 58,
                        color: AppColors.primaryOrange,
                      ),
                    ),
                  ],
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
                        minHeight: 130,
                        maxHeight: 408,
                      ),
                      child: RawScrollbar(
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
                            const CheckboxWidget(
                              title: 'Все незнакомые номера',
                              checked: false,
                            ),
                            const CheckboxWidget(
                              title: 'Моя база номеров',
                              checked: false,
                            ),
                            const SizedBox(height: 12),
                            for (var category in state.categories) ...[
                              CheckboxWidget(
                                title: category.name,
                                checked: false,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                const _InfoButton(),
                const SizedBox(height: 4),
                // const SizedBox(height: 24),
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
            );
          }

          return Container();
        },
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
              builder: (context) => const InfoDialog(),
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
