import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialapp/core/common/error_text.dart';
import 'package:socialapp/core/common/loader.dart';
import 'package:socialapp/feature/auth/controller/auth_controller.dart';
import 'package:socialapp/feature/news/delegates/search_news_delegate.dart';
import 'package:socialapp/feature/news/screen/add_new_news_page.dart';
import 'package:socialapp/feature/news/widget/news_card.dart';
import 'package:socialapp/feature/news/controller/news_controller.dart';
import 'package:socialapp/models/user_model.dart'; // Ensure this is correctly implemented

class NewsPage extends ConsumerWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'News',
            style: GoogleFonts.merriweather(
              textStyle: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        leading: user!.userType == UserType.admin ||
                user.userType == UserType.moderator
            ? Builder(
                builder: (context) {
                  return IconButton(
                    onPressed: () async {
                      await Navigator.of(context).push(AddNewNewsPage.route());
                    },
                    icon: const Icon(Icons.add_circle_outline_outlined),
                  );
                },
              )
            : Container(), // Return an empty container if not admin or moderator
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchNewsDelegate(ref),
              );
            },
          ),
        ],
      ),
      body: ref.watch(newsProvider).when(
            data: (news) {
              return ListView.builder(
                itemCount: news.length,
                itemBuilder: (BuildContext context, int index) {
                  final newsItem = news[index];
                  return NewsCard(news: newsItem);
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
            ),
          ),
    );
  }
}
