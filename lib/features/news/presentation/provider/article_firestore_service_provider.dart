import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_papper/features/news/service/article_firestore_service.dart';

final articleFirestoreServicesProvider =
    Provider<ArticleFirestoreService>(
      (ref) => ArticleFirestoreService(),
    );
