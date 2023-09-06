import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_task/models/users.dart';
import 'package:riverpod_task/models/get_users.dart';

void main() => runApp(const ProviderScope(child: const MyApp()));

final userProvider = FutureProvider<List<Welcome>?>((ref) async {
  final getInfo = getProvider();
  return getInfo;
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Welcome>?> config = ref.watch(userProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'riverpod task',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('riverpod task'),
        ),
        body: Container(
          child: config.when(
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) => Text('Error: $error'),
            data: (data) {
              return ListView.builder(
                itemCount: data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('${data[index].id}. ${data[index].name}'),
                    subtitle:
                        Text('${data[index].email} - ${data[index].phone}'),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
