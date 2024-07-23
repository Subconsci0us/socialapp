import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialapp/feature/auth/controller/auth_controller.dart';
import 'package:socialapp/feature/whatshot/feed/feed_screen.dart';
import 'package:socialapp/feature/whatshot/home/delegates/search_community_delegate.dart';
import 'package:socialapp/feature/whatshot/home/drawers/community_list_drawer.dart';

class WhatshotHomeScreen extends ConsumerWidget {
  const WhatshotHomeScreen({
    super.key,
  });

  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'What\'s Hot',
          style: GoogleFonts.roboto(
            textStyle: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
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
        ],
      ),
      drawer: const CommunityListDrawer(),
      body: const FeedScreen(),
    );
  }
}
