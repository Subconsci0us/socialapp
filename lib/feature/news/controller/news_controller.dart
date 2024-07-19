import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:socialapp/core/error/exceptions.dart';
import 'package:socialapp/core/failure.dart';
import 'package:socialapp/feature/news/repository/news_repository.dart';
import 'package:socialapp/models/news_model.dart';

import 'package:uuid/uuid.dart';

final newsControllerProvider =
    StateNotifierProvider<NewsController, bool>((ref) {
  final newsRepository = ref.watch(newsRepositoryProvider);
  // final storageRepository = ref.watch(storageRepositoryProvider);
  return NewsController(
    newsRepository: newsRepository,
    //  ref: ref,

    //  connectionChecker: ref.watch(ConnectionChecker)
  );
});

final newsProvider = FutureProvider<List<NewsModel>>((ref) async {
  final newsRepository = ref.watch(newsRepositoryProvider);
  return await newsRepository.getAllNews();
});

class NewsController extends StateNotifier<bool> {
  final NewsRepository _newsRepository;
  // final ConnectionChecker _connectionChecker;
  // final Ref _ref;

  NewsController({
    required NewsRepository newsRepository,
//    required Ref ref,
    // required ConnectionChecker connectionChecker,
  })  : _newsRepository = newsRepository,
        //  _ref = ref,
        //    _connectionChecker = connectionChecker,
        super(false);

  Future<Either<Failure, NewsModel>> uploadNews({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      // if (!await (_connectionChecker.isConnected)) {
      //     return left(Failure(Constants.noConnectionErrorMessage));
      //  }
      state = true;

      NewsModel newsModel = NewsModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );

      final imageUrl = await _newsRepository.uploadNewsImage(
        image: image,
        news: newsModel,
      );

      newsModel = newsModel.copyWith(
        imageUrl: imageUrl,
      );

      final uploadedNews = await _newsRepository.uploadNews(newsModel);
      state = false;

      return right(uploadedNews);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  Future<Either<Failure, List<NewsModel>>> getAllNews() async {
    try {
      //   if (!await (connectionChecker.isConnected)) {
      //     final news = newsLocalDataSource.loadNews();
      //     return right(news);
      //    }
      state = true;

      final news = await _newsRepository.getAllNews();
      // newsLocalDataSource.uploadLocalBlogs(news: news);
      state = false;

      return right(news);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
