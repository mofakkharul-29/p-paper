import 'package:flutter_riverpod/legacy.dart';
import 'package:p_papper/features/news/data/news_state.dart';
import 'package:p_papper/features/news/domain/repository/news_repository.dart';

class NewsNotifier extends StateNotifier<NewsState> {
  final NewsRepository repository;

  NewsNotifier(this.repository) : super(NewsState());

  Future<void> fetchNews({bool loadMore = false}) async {
    try {
      state = state.copyWith(isLoading: true);
      final nextPage = loadMore ? state.page + 1 : 1;

      final news = await repository.getNews(nextPage);

      state = state.copyWith(
        articles: loadMore
            ? [...state.articles, ...news]
            : news,
        page: nextPage,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}
