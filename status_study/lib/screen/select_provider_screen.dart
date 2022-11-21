import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:status_study/layout/default_layout.dart';
import 'package:status_study/provider/select_provider.dart';

class SelectProviderScreen extends ConsumerWidget {
  const SelectProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('build');
    // final state = ref.watch(selectProvider);

    // select 로 원하는 항목만 바뀔때 watch 할 수 있음
    // 실제로는 값이 바뀌지만 화면은 build 되지 않음, select 항목이 바뀌었을때만 재빌드
    final state = ref.watch(selectProvider.select((value) => value.isSpicy));
    ref.listen(selectProvider.select((value) => value.hasBought),
        (previous, next) {
      print(next);
    });

    return DefaultLayout(
      title: 'SelectProviderScreen',
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(state.name),
            // Text(state.isSpicy.toString()),
            // Text(state.hasBought.toString()),
            ElevatedButton(
              onPressed: () {
                ref.read(selectProvider.notifier).toggleIsSpicy();
              },
              child: Text('spicy toggle'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(selectProvider.notifier).toggleHasBought();
              },
              child: Text('HasBought toggle'),
            ),
          ],
        ),
      ),
    );
  }
}
