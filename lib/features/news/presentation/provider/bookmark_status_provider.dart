import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_papper/features/news/data/bookmark_notifier.dart';

final bookmarkNotifierProvider =
    NotifierProvider<BookmarkNotifier, Set<String>>(
      BookmarkNotifier.new,
    );
