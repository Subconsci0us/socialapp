import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socialapp/core/common/error_text.dart';
import 'package:socialapp/core/common/loader.dart';
import 'package:socialapp/feature/auth/controller/auth_controller.dart';
import 'package:socialapp/feature/whatshot/community/controller/community_controller.dart';
import 'package:socialapp/feature/whatshot/post/controller/post_controller.dart';
import 'package:socialapp/feature/whatshot/post/widget/post_card.dart';

class FeedScreen extends ConsumerWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;

    return ref.watch(userCommunitiesProvider).when(
          data: (communities) => ref.watch(userPostsProvider(communities)).when(
                data: (data) {
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      final post = data[index];
                      return PostCard(post: post);
                    },
                  );
                },
                error: (error, stackTrace) {
                  return ErrorText(
                    error: error.toString(),
                  );
                },
                loading: () => const Loader(),
              ),
          error: (error, stackTrace) => ErrorText(
            error: error.toString(),
          ),
          loading: () => const Loader(),
        );
  }
}
