import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // For formatting dates
import 'package:socialapp/models/news_model.dart';

class NewsViewerPage extends StatelessWidget {
  final NewsModel news;

  const NewsViewerPage({super.key, required this.news});

  static Route route(NewsModel news) {
    return MaterialPageRoute(
      builder: (context) => NewsViewerPage(news: news),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          // Display the image at the top
          CachedNetworkImage(
            imageUrl: news.imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          const SizedBox(height: 16),
          // Display the title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              news.title,
              style: GoogleFonts.noticiaText(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Display the poster's name if available
          if (news.posterName != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'By ${news.posterName}',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
          // Display the topics
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 8,
              children: news.topics
                  .map((topic) => Chip(
                        label: Text(topic),
                        backgroundColor: Colors.blueAccent.withOpacity(0.2),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 16),
          // Display the content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              news.content,
              style: GoogleFonts.roboto(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Display the last updated date
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Updated at: ${DateFormat('yyyy-MM-dd HH:mm').format(news.updatedAt)}',
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
