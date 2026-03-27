import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_papper/features/news/presentation/provider/article_firestore_service_provider.dart';

final openedArticlesProvider =
    StreamProvider.family<List<String>, String>((
      ref,
      userId,
    ) {
      final service = ref.watch(
        articleFirestoreServicesProvider,
      );
      return service.openedArticles(userId: userId);
    });
