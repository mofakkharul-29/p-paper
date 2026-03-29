import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_papper/features/news/data/news_state.dart';
import 'package:p_papper/features/news/presentation/provider/dio_provider.dart';

class NewsNotifier extends Notifier<NewsState> {
  Timer? _debounce;

  @override
  NewsState build() {
    ref.onDispose(() {
      _debounce?.cancel();
    });

    return NewsState();
  }

  void onSearchChanged(String query) {
    _debounce?.cancel();

    _debounce = Timer(
      const Duration(milliseconds: 500),
      () {
        state = state.copyWith(searchQuery: query);
        fetchNews();
      },
    );
  }

  Future<void> fetchNews({bool loadMore = false}) async {
    if (state.isLoading || (!state.hasMore && loadMore)) {
      return;
    }

    try {
      state = state.copyWith(isLoading: true);
      final nextPage = loadMore ? state.page + 1 : 1;
      final news = await ref
          .read(newsRepositoryProvider)
          .getNews(
            page: nextPage,
            query: state.searchQuery,
          );
      state = state.copyWith(
        articles: loadMore
            ? [...state.articles, ...news]
            : news,
        page: nextPage,
        isLoading: false,
        hasMore: news.isNotEmpty,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}
