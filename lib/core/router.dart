import 'package:go_router/go_router.dart';

import '../features/splash/splash_screen.dart';
import '../features/auth/auth_page.dart';
import '../features/home/home_page.dart';
import '../features/onboarding/pages/onboarding_page.dart';
import '../features/onboarding/pages/blocker_settings_page.dart';
import '../features/test/test_page.dart';

final routerConfig = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/test',
      builder: (context, state) => const TestPage(),
    ),
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/onboard',
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: '/block_settings',
      builder: (context, state) => const BlockerSettingsPage(),
    ),
  ],
);
