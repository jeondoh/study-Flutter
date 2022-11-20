import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:status_study/provider/state_provider.dart';

import '../layout/default_layout.dart';

class StateProviderScreen extends ConsumerWidget {
  const StateProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(numberProvider);

    return DefaultLayout(
      title: 'StateProviderScreen',
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(provider.toString()),
            ElevatedButton(
              onPressed: () {
                ref.read(numberProvider.notifier).update((state) => state + 1);
              },
              child: const Text('UP'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const _NextScreen(),
                  ),
                );
              },
              child: const Text('NextScreen'),
            ),
          ],
        ),
      ),
    );
  }
}

class _NextScreen extends ConsumerWidget {
  const _NextScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(numberProvider);

    return DefaultLayout(
      title: 'StateProviderScreen',
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(provider.toString()),
            ElevatedButton(
              onPressed: () {
                ref.read(numberProvider.notifier).update((state) => state + 1);
              },
              child: const Text('UP'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(numberProvider.notifier).state =
                    ref.read(numberProvider.notifier).state - 1;
              },
              child: const Text('DOWN'),
            ),
          ],
        ),
      ),
    );
  }
}
