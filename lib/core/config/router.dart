import 'package:go_router/go_router.dart';

import '../../features/auth/pages/otp_page.dart';
import '../../features/auth/pages/phone_page.dart';
import '../../features/auth/pages/reason_page.dart';
import '../../features/check/pages/check_result_page.dart';
import '../../features/check/pages/web_page.dart';
import '../../features/help/pages/help_status_page.dart';
import '../../features/settings/pages/contact_page.dart';
import '../../features/settings/pages/contact_status_page.dart';
import '../../features/splash/splash_page.dart';
import '../../features/auth/pages/auth_page.dart';
import '../../features/home/home_page.dart';
import '../../features/onboarding/pages/onboarding_page.dart';
import '../../features/onboarding/pages/blocker_settings_page.dart';
import '../../features/terms/pages/policy_page.dart';
import '../../features/terms/pages/terms_page.dart';
// import '../../features/test/test_page.dart';

final routerConfig = GoRouter(
  initialLocation: '/splash',
  routes: [
    // GoRoute(
    //   path: '/test',
    //   builder: (context, state) => const TestPage(),
    // ),
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthPage(),
    ),
    GoRoute(
      path: '/phone',
      builder: (context, state) => const PhonePage(),
      onExit: (context) => true,
    ),
    GoRoute(
      path: '/otp',
      builder: (context, state) => const OtpPage(),
      onExit: (context) => true,
    ),
    GoRoute(
      path: '/reason',
      builder: (context, state) => const ReasonPage(),
      onExit: (context) => true,
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
      path: '/check_result',
      builder: (context, state) => const CheckResultPage(),
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
