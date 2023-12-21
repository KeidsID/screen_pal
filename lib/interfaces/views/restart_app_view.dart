import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:screen_pal/core/entities.dart';
import 'package:screen_pal/interfaces/providers/remote/extras/extras_providers.dart';
import 'package:screen_pal/interfaces/widgets.dart';

class RestartAppView extends StatelessWidget {
  const RestartAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer(builder: (context, ref, _) {
          final extrasState = ref.watch(extrasDependenciesStateProvider);

          return extrasState.when(
            skipLoadingOnRefresh: false,
            loading: () => const SizedCircularProgressIndicator.expand(),

            //
            error: (_, __) => SizedExceptionWidget.expand(
              const BasicException(
                name: 'Something went wrong',
                message: 'Some contents are missing due to bad network. '
                    'Please reload it by clicking the button below.',
              ),
              action: ElevatedButton.icon(
                onPressed: () => extrasDependenciesStateProvider.dependencies
                    ?.forEach((e) => ref.invalidate(e)),
                icon: const Icon(Icons.restart_alt),
                label: const Text('Restart'),
              ),
            ),

            //
            data: (_) => const SizedBox.expand(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16.0),
                  Text('Redirecting...'),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
