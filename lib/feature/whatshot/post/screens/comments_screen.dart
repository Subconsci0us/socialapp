import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socialapp/core/common/error_text.dart';
import 'package:socialapp/core/common/loader.dart';
import 'package:socialapp/feature/whatshot/post/controller/post_controller.dart';
import 'package:socialapp/feature/whatshot/post/widget/comment_card.dart';
import 'package:socialapp/feature/whatshot/post/widget/post_card.dart';
import 'package:socialapp/models/post_model.dart';

class CommentsScreen extends ConsumerStatefulWidget {
  static Route<dynamic> route(String postId) => MaterialPageRoute(
        builder: (context) => CommentsScreen(postId: postId),
      );
  final String postId;
  const CommentsScreen({
    super.key,
    required this.postId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends ConsumerState<CommentsScreen> {
  final commentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    commentController.dispose();
  }

  void addComment(Post post) {
    ref.read(postControllerProvider.notifier).addComment(
          context: context,
          text: commentController.text.trim(),
          post: post,
        );
    setState(() {
      commentController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ref.watch(getPostByIdProvider(widget.postId)).when(
          data: (data) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  PostCard(post: data),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onSubmitted: (val) => addComment(data),
                      controller: commentController,
                      decoration: const InputDecoration(
                        hintText: 'What are your thoughts?',
                        filled: true,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  ref.watch(getPostCommentsProvider(widget.postId)).when(
                      data: (comments) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: comments.length,
                          itemBuilder: (BuildContext context, int index) {
                            final comment = comments[index];
                            return CommentCard(comment: comment);
                          },
                        );
                      },
                      error: (error, stackTrace) {
                        return ErrorText(
                          error: error.toString(),
                        );
                      },
                      loading: () => Loader(
                            color: Colors.red,
                          )),
                ],
              ),
            );
          },
          error: (error, stackTrace) => ErrorText(
                error: error.toString(),
              ),
          loading: () => Loader(
                color: Colors.red,
              )),
    );
  }
}
