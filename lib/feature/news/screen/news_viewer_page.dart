import 'package:flutter/material.dart';
import 'package:socialapp/core/utils.dart';

import 'package:socialapp/models/news_model.dart';
import 'package:socialapp/theme/pallete.dart';

class NewsViewerPage extends StatelessWidget {
  static route(NewsModel news) => MaterialPageRoute(
        builder: (context) => NewsViewerPage(
          news: news,
        ),
      );
  final NewsModel news;
  const NewsViewerPage({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  news.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'By ${news.posterName}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  formatDateBydMMMYYYY(news.updatedAt),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppPallete.blackColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(news.imageUrl),
                ),
                const SizedBox(height: 20),
                Text(
                  news.content,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 2,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
