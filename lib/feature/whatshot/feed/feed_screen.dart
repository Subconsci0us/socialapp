import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socialapp/core/common/error_text.dart';
import 'package:socialapp/core/common/loader.dart';
import 'package:socialapp/feature/whatshot/community/controller/community_controller.dart';
import 'package:socialapp/feature/whatshot/post/widget/post_card.dart';
import 'package:socialapp/feature/whatshot/post/widget/write_something_widget.dart';
import 'package:socialapp/models/post_model.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});

  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  // Counter for debugging
  int queryCallCount = 0;

  @override
  Widget build(BuildContext context) {
    return ref.watch(userCommunitiesProvider).when(
      data: (communities) {
        // Debugging statement to check the communities data

        final List<String> communityNames =
            communities.map((e) => e.name).toList();

        final Query<Post> query = FirebaseFirestore.instance
            .collection('posts')
            .where('communityName', whereIn: communityNames)
            .orderBy('createdAt', descending: true)
            .limit(3)
            .withConverter(
              fromFirestore: (snapshot, _) {
                // Increment query call count and debug statement
                queryCallCount++;
                //print('Query Call Count: $queryCallCount');
                //print('Document Data: ${snapshot.data()}');
                return Post.fromMap(snapshot.data()!);
              },
              toFirestore: (post, _) => post.toMap(),
            );

        return Column(
          children: [
            const WriteSomethingWidget(), // The widget to write something new
            Expanded(
              child: FirestoreListView<Post>(
                pageSize: 10,
                query: query,
                itemBuilder:
                    (BuildContext context, DocumentSnapshot<Post> snapshot) {
                  final post = snapshot.data();
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10.0),
                    child: PostCard(post: post!),
                  );
                },
              ),
            ),
          ],
        );
      },
      error: (error, stackTrace) {
        // Debugging statement to check error details
        print('Error: ${error.toString()}');
        return ErrorText(
          error: error.toString(),
        );
      },
      loading: () {
        // Debugging statement to check loading state
        print('Loading...');
        return Loader(
          color: Colors.red,
        );
      },
    );
  }
}
