import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socialapp/feature/whatshot/feed/feed_screen.dart';
import 'package:socialapp/feature/whatshot/home/delegates/search_community_delegate.dart';
import 'package:socialapp/feature/whatshot/home/drawers/community_list_drawer.dart';
import 'package:socialapp/feature/whatshot/home/drawers/profile_drawer.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'What\'s Hot',
        ),
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
              icon: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/default_avatar.jpg'),
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
    );
  }
}
