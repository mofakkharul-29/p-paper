import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:p_papper/core/error/custom_exception.dart';
import 'package:p_papper/features/news/domain/article_model.dart';

class ArticleFirestoreService {
  final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;

  String _safeId(String id) {
    return id.replaceAll('/', '_');
  }

  Future<void> writeToFirestore(
    String userId,
    ArticleModel article,
  ) async {
    final data = article
        .copyWith(savedAt: DateTime.now())
        .toMap();

    try {
      await _firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('bookmarks')
          .doc(_safeId(article.id))
          .set(data, SetOptions(merge: true));
    } on FirebaseException catch (e, st) {
      throw CustomException(
        message: e.message ?? 'Something went wrong',
        code: e.code,
        stackTrace: st,
      );
    }
  }

  Future<List<ArticleModel>> readFromFirestore(
    String userId,
  ) async {
    try {
      final snapshot = await _firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('bookmarks')
          .orderBy('savedAt', descending: true)
          .get();

      return snapshot.docs
          .map(
            (doc) => ArticleModel.fromFirestore(doc.data()),
          )
          .toList();
    } on FirebaseException catch (e, st) {
      throw CustomException(
        message: e.message.toString(),
        code: e.code,
        stackTrace: st,
      );
    }
  }

  Stream<List<ArticleModel>> streamBookmarks(
    String userId,
  ) {
    return _firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('bookmarks')
        .orderBy('savedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) =>
                    ArticleModel.fromFirestore(doc.data()),
              )
              .toList(),
        );
  }

  Future<void> deleteFromFirestore(
    String userId,
    String articleId,
  ) async {
    try {
      final docRef = _firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('bookmarks')
          .doc(_safeId(articleId));

      final docSnapshot = await docRef.get();

      if (!docSnapshot.exists) {
        throw CustomException(
          message: 'Article not found in the bookmarks',
          code: 'not-found',
          stackTrace: StackTrace.current,
        );
      }

      await docRef.delete();
    } on FirebaseException catch (e, st) {
      throw CustomException(
        message: e.message.toString(),
        code: e.code,
        stackTrace: st,
      );
    }
  }
}
