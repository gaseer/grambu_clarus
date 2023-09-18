import 'package:flutter/material.dart';
import 'package:grambu_task/screens/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: First(),
    );
  }
}

class First extends ConsumerStatefulWidget {
  const First({Key? key}) : super(key: key);

  @override
  ConsumerState<First> createState() => _FirstState();
}

class _FirstState extends ConsumerState<First> {
  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}
