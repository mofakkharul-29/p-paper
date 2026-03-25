import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_papper/features/auth/presentation/provider/auth_notifier_provider.dart';
import 'package:p_papper/features/news/domain/article_model.dart';
import 'package:p_papper/features/news/presentation/provider/article_firestore_service_provider.dart';

class BookmarkStreamNotifier
    extends StreamNotifier<List<ArticleModel>> {
  @override
  Stream<List<ArticleModel>> build() {
    final userId = ref
        .watch(authNotifierProvider)
        .value
        ?.uid;

    if (userId == null) {
      return Stream.value([]);
    }

    final articleFirestore = ref.watch(
      articleFirestoreServicesProvider,
    );

    return articleFirestore.streamBookmarks(userId);
  }
}
