import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socialapp/core/common/error_text.dart';
import 'package:socialapp/core/common/loader.dart';
import 'package:socialapp/feature/news/controller/news_controller.dart';
import 'package:socialapp/feature/news/screen/news_viewer_page.dart';

class SearchNewsDelegate extends SearchDelegate {
  final WidgetRef ref;

  SearchNewsDelegate(this.ref);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          // Refresh suggestions when query is cleared
          showSuggestions(context);
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement a view for showing results based on the query if needed
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final queryProvider = searchNewsProvider(query);
        final queryResult = ref.watch(queryProvider);

        return queryResult.when(
            data: (news) {
              if (news.isEmpty) {
                return const Center(child: Text('No News found.'));
              }
              return ListView.builder(
                itemCount: news.length,
                itemBuilder: (BuildContext context, int index) {
                  final News = news[index];
                  return ListTile(
                    title: Text('r/${News.title}'),
                    onTap: () => Navigator.of(context).push(
                      NewsViewerPage.route(News),
                    ),
                  );
                },
              );
            },
            error: (error, stackTrace) => ErrorText(
                  error: error.toString(),
                ),
            loading: () => Loader(
                  color: Colors.red,
                ));
      },
    );
  }
}
