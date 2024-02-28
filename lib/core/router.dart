import 'package:blocker/features/help/pages/help_status_page.dart';
import 'package:go_router/go_router.dart';

import '../features/check/pages/web_page.dart';
import '../features/settings/pages/contact_page.dart';
import '../features/settings/pages/contact_status_page.dart';
import '../features/splash/splash_screen.dart';
import '../features/auth/auth_page.dart';
import '../features/home/home_page.dart';
import '../features/onboarding/pages/onboarding_page.dart';
import '../features/onboarding/pages/blocker_settings_page.dart';
import '../features/terms/pages/policy_page.dart';
import '../features/terms/pages/terms_page.dart';
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
    GoRoute(
      path: '/policy',
      builder: (context, state) => const PolicyPage(),
    ),
    GoRoute(
      path: '/terms',
      builder: (context, state) => const TermsPage(),
    ),
    GoRoute(
      path: '/web',
      builder: (context, state) => WebPage(phone: state.extra as String),
    ),
    GoRoute(
      path: '/help_status',
      builder: (context, state) => const HelpStatusPage(),
    ),
    GoRoute(
      path: '/contact',
      builder: (context, state) => const ContactPage(),
    ),
    GoRoute(
      path: '/contact_status',
      builder: (context, state) => const ContactStatusPage(),
    ),
  ],
);
