import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/widgets/loading/loading_widget.dart';
import 'bloc/check_bloc.dart';
import 'widgets/check_result_widget.dart';
import 'widgets/check_widget.dart';

class CheckPage extends StatelessWidget {
  const CheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    print('BUILD CHECK PAGE');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21),
      child: BlocBuilder<CheckBloc, CheckState>(
        builder: (context, state) {
          if (state is CheckInitial) {
            return const CheckWidget();
          }

          if (state is CheckLoadingState) {
            return const LoadingWidget();
          }

          if (state is CheckResultState || state is CheckResultLoadingState) {
            return const CheckResultWidget();
          }

          return Container();
        },
      ),
    );
  }
}
