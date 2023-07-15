import 'package:flutter/material.dart'; // FlutterのUIコンポーネントを使用するために必要なパッケージ
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpodパッケージを使用するために必要なパッケージ

void main() {
  runApp(const MyApp());
}

// StreamProviderを定義します。これは1秒ごとに値を増やすストリームを作成します。
final counterProvider = StreamProvider<int>((ref) {
  return Stream.periodic(const Duration(seconds: 1), (count) => count);
});

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: const Text('StreamProvider Example')),
          body: const CounterPage(),
        ),
      ),
    );
  }
}

class CounterPage extends ConsumerWidget {
  const CounterPage({super.key});

  @override
  build(context, WidgetRef ref) {
    // StreamProviderからストリームの現在の状態を取得します。
    AsyncValue<int> counter = ref.watch(counterProvider);

    return Center(
      child: counter.when(
        data: (value) => Text(
          'Counter: $value',
          style: const TextStyle(fontSize: 30),
        ), // データが存在する場合はその値を表示します。
        loading: () =>
            const CircularProgressIndicator(), // ローディング中の場合はローディングインジケーターを表示します。
        error: (_, __) =>
            const Text('An error occurred'), // エラーが発生した場合はエラーメッセージを表示します。
      ),
    );
  }
}
