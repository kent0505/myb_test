import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_colors.dart';
import '../../../core/widgets/buttons/yellow_button.dart';
import '../models/page_model.dart';
import '../widgets/page_widget.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentPage = 0;
  PageController pageController = PageController();

  final pages = [
    PageModel(
      iconPath: 'assets/images/user_search.svg',
      title: 'Определяйте входящие звонки',
      subtitle: 'Узнайте, кто скрывается за незнакомым номером',
    ),
    PageModel(
      iconPath: 'assets/images/remove.svg',
      title: 'Фильтруйте СМС-сообщения',
      subtitle:
          'Игнорируйте СМС от спамеров, мошенников, коллекторов и надоедливых сервисов',
    ),
    PageModel(
      iconPath: 'assets/images/cloud_add.svg',
      title: 'Составляйте свою базу номеров',
      subtitle:
          'Соберите личный список нежелательных номеров и помогите сервису рабоать лучше',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 18),
            SvgPicture.asset('assets/images/logo.svg'),
            const SizedBox(height: 100),
            Expanded(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  return PageWidget(pageModel: pages[index]);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: pages.map((e) {
                int ind = pages.indexOf(e);
                return Container(
                  height: 12,
                  width: 12,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ind == currentPage
                        ? AppColors.primaryOrange
                        : AppColors.basicWhite1,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: currentPage == 2
                  ? YellowButton(
                      title: 'Включить',
                      active: true,
                      onPressed: () {
                        context.go('/block_settings');
                      },
                    )
                  : YellowButton(
                      title: 'Далее',
                      active: true,
                      onPressed: () {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear,
                        );
                      },
                    ),
            ),
            const SizedBox(height: 76),
          ],
        ),
      ),
    );
  }
}
