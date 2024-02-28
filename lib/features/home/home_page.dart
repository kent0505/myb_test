import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_colors.dart';
import '../../core/utils.dart';
import '../check/check_page.dart';
import '../help/help_page.dart';
import '../menu/bloc/menu_bloc.dart';
import '../menu/menu_page.dart';
import '../mydb/bloc/mydb_bloc.dart';
import '../mydb/mydb_page.dart';
import '../settings/settings_page.dart';
import 'bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _widgetOptions = <Widget>[
    const MenuPage(),
    const MydbPage(),
    const CheckPage(),
    const HelpPage(),
    const SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
    context.read<MenuBloc>().add(GetCategoriesEvent());
    context.read<MydbBloc>().add(GetBlacklistEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeInitial) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.dark,
              ),
              title: const Text(
                'МЮБ Спам-защитник',
                style: TextStyle(
                  color: AppColors.basicBlack3,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              centerTitle: true,
              actions: [
                if (state.index == 4)
                  IconButton(
                    onPressed: () async {
                      await Utils.saveData('token', '').then((_) {
                        context.go('/auth');
                      });
                    },
                    icon: const Icon(Icons.logout),
                  )
              ],
            ),
            body: SafeArea(
              child: _widgetOptions.elementAt(state.index),
            ),
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 40,
                    color: AppColors.basicWhite2,
                    offset: Offset(0, 1),
                  )
                ],
              ),
              child: BottomNavigationBar(
                elevation: 0,
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                currentIndex: state.index,
                onTap: (value) {
                  context.read<HomeBloc>().add(ChangePageEvent(value));
                },
                unselectedLabelStyle: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
                selectedLabelStyle: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
                unselectedItemColor: AppColors.basicGrey4,
                selectedItemColor: AppColors.primaryBlack,
                items: navbarItems.map((e) {
                  return BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: SvgPicture.asset(e.unselectedIconPath),
                    ),
                    activeIcon: Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: SvgPicture.asset(e.selectedIconPath),
                    ),
                    label: e.label,
                  );
                }).toList(),
              ),
            ),
          );
        }

        return Container();
      },
    );
  }
}

class NavBarItem {
  String label;
  String selectedIconPath;
  String unselectedIconPath;

  NavBarItem({
    required this.label,
    required this.selectedIconPath,
    required this.unselectedIconPath,
  });
}

final List<NavBarItem> navbarItems = [
  NavBarItem(
    label: 'Меню',
    selectedIconPath: 'assets/navbar_icons/home_filled.svg',
    unselectedIconPath: 'assets/navbar_icons/home.svg',
  ),
  NavBarItem(
    label: 'Моя База',
    selectedIconPath: 'assets/navbar_icons/driver_filled.svg',
    unselectedIconPath: 'assets/navbar_icons/driver.svg',
  ),
  NavBarItem(
    label: 'Проверка',
    selectedIconPath: 'assets/navbar_icons/search_filled.svg',
    unselectedIconPath: 'assets/navbar_icons/search.svg',
  ),
  NavBarItem(
    label: 'Помощь',
    selectedIconPath: 'assets/navbar_icons/message_filled.svg',
    unselectedIconPath: 'assets/navbar_icons/message.svg',
  ),
  NavBarItem(
    label: 'Настройки',
    selectedIconPath: 'assets/navbar_icons/settings_filled.svg',
    unselectedIconPath: 'assets/navbar_icons/settings.svg',
  ),
];
