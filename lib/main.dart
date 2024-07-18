import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socialapp/core/common/error_text.dart';
import 'package:socialapp/core/common/loader.dart';
import 'package:socialapp/core/navigation/navigation.dart';
import 'package:socialapp/feature/auth/controller/auth_controller.dart';
import 'package:socialapp/feature/auth/screens/login_screen.dart';
import 'package:socialapp/firebase_options.dart';
import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;

  Future<void> getData(WidgetRef ref, User data) async {
    userModel = await ref
        .read(authControllerProvider.notifier)
        .getUserData(data.uid)
        .first;
    ref.read(userProvider.notifier).update((state) => userModel);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social App',
      theme: ref.watch(themeNotifierProvider),
      home: ref.watch(authStateChangeProvider).when(
            data: (user) {
              if (user != null) {
                if (userModel == null) {
                  getData(ref, user);
                }
                return const Navigation();
              }
              return const LoginPage();
            },
            error: (error, stackTrace) => ErrorText(error: error.toString()),
            loading: () => const Loader(),
          ),
    );
  }
}
