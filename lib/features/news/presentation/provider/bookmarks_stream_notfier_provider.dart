import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_papper/features/news/data/bookmark_stream.dart';
import 'package:p_papper/features/news/domain/article_model.dart';

final bookmarksStreamNotifierProvider =
    StreamNotifierProvider<
      BookmarkStreamNotifier,
      List<ArticleModel>
    >(BookmarkStreamNotifier.new);
