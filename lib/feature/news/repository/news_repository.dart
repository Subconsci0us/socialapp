import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socialapp/core/error/exceptions.dart';
import 'package:socialapp/core/providers/firebase_providers.dart';
import 'package:socialapp/models/news_model.dart';

final newsRepositoryProvider = Provider((ref) {
  return NewsRepository(
      firebaseStorage: ref.watch(storageProvider),
      firestore: ref.watch(firestoreProvider));
});

class NewsRepository {
  final FirebaseStorage _firebaseStorage;
  final FirebaseFirestore _firestore;

  NewsRepository({
    required FirebaseFirestore firestore,
    required FirebaseStorage firebaseStorage,
  })  : _firestore = firestore,
        _firebaseStorage = firebaseStorage;

  Future<NewsModel> uploadNews(NewsModel news) async {
    try {
      final newsData = await _firestore.collection('news').add(news.toMap());

      final docSnapshot = await newsData.get();

      return NewsModel.fromMap(docSnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<String> uploadNewsImage({
    required File image,
    required NewsModel news,
  }) async {
    try {
      final storageRef = _firebaseStorage
          .ref()
          .child('news_images/${news.id.split('/').last}');
      await storageRef.putFile(image);
      final downloadUrl = await storageRef.getDownloadURL();

      return downloadUrl;
    } on FirebaseStorage catch (e) {
      throw ServerException(e.toString());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<List<NewsModel>> getAllNews() async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('news')
          .orderBy('updated_at', descending: true)
          .get();

      final List<NewsModel> news =
          await Future.wait(snapshot.docs.map((doc) async {
        final data = doc.data() as Map<String, dynamic>;

        // Assuming each news document contains a 'posterId' field
        final String posterId = data['poster_id'];

        final DocumentSnapshot userSnapshot =
            await _firestore.collection('users').doc(posterId).get();

        if (userSnapshot.exists) {
          final userData = userSnapshot.data() as Map<String, dynamic>;

          return NewsModel.fromMap(data).copyWith(
            posterName: userData['name'],
          );
        } else {
          return NewsModel.fromMap(
              data); // Return without posterName if user not found
        }
      }).toList());

      return news;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Stream<List<NewsModel>> searchNews(String query) {
    return _firestore
        .collection('news')
        .where(
          'title',
          isGreaterThanOrEqualTo: query,
          isLessThan: query.isEmpty
              ? null
              : query.substring(0, query.length - 1) +
                  String.fromCharCode(
                    query.codeUnitAt(query.length - 1) + 1,
                  ),
        )
        .snapshots()
        .map((event) {
      List<NewsModel> newsList = [];
      for (var doc in event.docs) {
        newsList.add(NewsModel.fromMap(doc.data()));
      }
      return newsList;
    });
  }
}
