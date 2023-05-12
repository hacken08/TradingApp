import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: SafeArea(
          child: Column(
        children: [
          const Center(
            child: Text("Home Page"),
          ),
          ElevatedButton(
              onPressed: () {
                context.go("/login");
              },
              child: const Text("Go to login page")),
        ],
      )),
    );
  }
}
