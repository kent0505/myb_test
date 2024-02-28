import 'package:flutter/material.dart';

import '../../../core/widgets/appbar/app_bar_widget.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Text('Terms'),
      ),
    );
  }
}
