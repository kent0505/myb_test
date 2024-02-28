import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../core/utils.dart';
import '../../core/widgets/loading/loading_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void check() async {
    await Utils.getTokens();

    final decodedToken = JwtDecoder.tryDecode(Utils.token);
    final now = DateTime.now().millisecondsSinceEpoch / 1000;

    Future.delayed(const Duration(seconds: 1), () {
      if (Utils.token.isNotEmpty &&
          decodedToken != null &&
          decodedToken['exp'] >= now) {
        if (Utils.blockSettings == false) {
          context.go('/block_settings');
        } else {
          context.go('/home');
        }
      } else {
        context.go('/auth');
      }
    });
  }

  @override
  initState() {
    super.initState();
    check();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoadingWidget(),
    );
  }
}
