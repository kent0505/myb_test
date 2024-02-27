import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/widgets/loading/loading_widget.dart';
import 'bloc/help_bloc.dart';
import 'widgets/help_error_widget.dart';
import 'widgets/help_widget.dart';
import 'widgets/help_success_widget.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    print('BUILD HELP PAGE');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21),
      child: BlocBuilder<HelpBloc, HelpState>(
        builder: (context, state) {
          if (state is HelpInitial) {
            return const HelpWidget();
          }

          if (state is HelpLoadingState) {
            return const LoadingWidget();
          }

          if (state is HelpSuccessState) {
            return const HelpSuccessWidget();
          }

          if (state is HelpErrorState) {
            return const HelpErrorWidget();
          }

          return Container();
        },
      ),
    );
  }
}
