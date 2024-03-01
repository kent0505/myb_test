import 'package:flutter/material.dart';

import '../../../core/widgets/loading/loading_widget.dart';

class LoadingDialogWidget extends StatelessWidget {
  const LoadingDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 342,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadingWidget(),
        ],
      ),
    );
  }
}
