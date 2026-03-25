import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookmarkNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() {
    return {};
  }

  bool addArticle(String articleId) {
    if (state.contains(articleId)) return false;

    state = {...state, articleId};
    return true;
  }

  bool removeArticle(String articleId) {
    if (!state.contains(articleId)) return false;

    state = state.where((id) => id != articleId).toSet();
    return false;
  }

  bool isArticleBookedMarked(String articleId) {
    return state.contains(articleId);
  }

  void toggleBookmarked(String articleId) {
    if (state.contains(articleId)) {
      state = state.where((id) => id != articleId).toSet();
    } else {
      state = {...state, articleId};
    }
  }
}
