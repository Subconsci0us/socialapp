import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socialapp/core/common/error_text.dart';
import 'package:socialapp/core/common/loader.dart';
import 'package:socialapp/feature/whatshot/community/controller/community_controller.dart';
import 'package:socialapp/feature/whatshot/post/controller/post_controller.dart';
import 'package:socialapp/feature/whatshot/post/widget/post_card.dart';
import 'package:socialapp/feature/whatshot/post/widget/write_something_widget.dart';
import 'package:socialapp/theme/theme.dart';

class FeedScreen extends ConsumerWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeNotifierProvider);

    return ref.watch(userCommunitiesProvider).when(
          data: (communities) => ref.watch(userPostsProvider(communities)).when(
                data: (data) {
                  return ListView.builder(
                    itemCount: data.length + 1, // Adjust the item count
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return const WriteSomethingWidget(); // The widget to write something new
                      } else {
                        final post = data[index - 1];
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          child: PostCard(post: post),
                        );
                      }
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
