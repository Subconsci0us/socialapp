import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socialapp/feature/auth/controller/auth_controller.dart';

class WhatshotScreen extends ConsumerWidget {
  const WhatshotScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;

    return Scaffold(
      body: Center(child: Text(user.name)),
    );
  }
}
