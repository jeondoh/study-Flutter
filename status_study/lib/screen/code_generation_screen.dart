import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:status_study/layout/default_layout.dart';
import 'package:status_study/provider/code_generation_provider.dart';

class CodeGenerationScreen extends ConsumerWidget {
  const CodeGenerationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('build');
    final state1 = ref.watch(gStateProvider);
    final state2 = ref.watch(gStateFutureProvider);
    final state3 = ref.watch(gStateFuture2Provider);
    final state4 = ref.watch(
      gStateMultiplyProvider(
        number1: 10,
        number2: 20,
      ),
    );

    return DefaultLayout(
      title: 'CodeGenerationScreen',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('State1 : $state1'),
          state2.when(
            data: (data) {
              return Text(
                data.toString(),
                textAlign: TextAlign.center,
              );
            },
            error: (err, stack) => Text(
              err.toString(),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
          state3.when(
            data: (data) {
              return Text(
                data.toString(),
                textAlign: TextAlign.center,
              );
            },
            error: (err, stack) => Text(
              err.toString(),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
          Text('State4 : $state4'),
          // 리랜더링이 안되기 위해 새로운 위젯을 생성해야 한다..
          // _StateFiveWidget(),
          // Consumer를 이용하면 매번 새로운 위젯을 생성하지 않아도 된다.
          // 원하는 위젯만 랜더링 할 수 있게 설계 가능
          Consumer(
            builder: (context, ref, child) {
              final state5 = ref.watch(gStateNotifierProvider);
              return Row(
                children: [
                  Text('state5: $state5'),
                  // 아래 child 의 값을 가져올 수 있음
                  // 새로 랜더링 하는 위젯이 부분적일 때 사용한다.
                  // child 는 단 한번만 랜더링됨
                  // 그 외 builder 내에 있는 아이들은 변경될 때 마다 랜더링
                  child!,
                ],
              );
            },
            child: const Text('Consumer Child'),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  ref.read(gStateNotifierProvider.notifier).increment();
                },
                child: const Text('Increment'),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(gStateNotifierProvider.notifier).decrement();
                },
                child: const Text('Decrement'),
              ),
            ],
          ),
          // invalidate()
          // 유효하지 않게 하다
          ElevatedButton(
            onPressed: () {
              ref.invalidate(gStateNotifierProvider);
            },
            child: const Text('Invalidate'),
          ),
        ],
      ),
    );
  }
}

class _StateFiveWidget extends ConsumerWidget {
  const _StateFiveWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state5 = ref.watch(gStateNotifierProvider);
    return Text('State5 : $state5');
  }
}
