import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:socialapp/feature/auth/controller/auth_controller.dart';
import 'package:socialapp/feature/whatshot/feed/feed_screen.dart';
import 'package:socialapp/feature/whatshot/home/delegates/search_community_delegate.dart';
import 'package:socialapp/feature/whatshot/home/drawers/community_list_drawer.dart';
import 'package:socialapp/feature/whatshot/home/drawers/profile_drawer.dart';
import 'package:socialapp/feature/whatshot/post/screens/add_post_screen.dart';
import 'package:socialapp/theme/pallete.dart';

class WhatshotHomeScreen extends ConsumerWidget {
  const WhatshotHomeScreen({
    super.key,
  });

  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: false,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => displayDrawer(context),
          );
        }),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                  context: context, delegate: SearchCommunityDelegate(ref));
            },
            icon: const Icon(Icons.search),
          ),
          Builder(builder: (context) {
            return IconButton(
              icon: CircleAvatar(
                backgroundImage: NetworkImage(user.profilePic),
              ),
              onPressed: () {
                displayEndDrawer(context);
              },
            );
          })
        ],
      ),
      drawer: const CommunityListDrawer(),
      endDrawer: const ProfileDrawer(),
      body: const FeedScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(AddPostScreen.route());
        },
        backgroundColor: AppPallete.drawerColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
