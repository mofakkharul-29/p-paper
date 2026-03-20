import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_papper/features/news/data/news_state.dart';
import 'package:p_papper/features/news/presentation/provider/dio_provider.dart';

class NewsNotifier extends Notifier<NewsState> {
  @override
  NewsState build() {
    return NewsState();
  }

  Future<void> fetchNews({bool loadMore = false}) async {
    try {
      state = state.copyWith(isLoading: true);
      final web = state.error;
      final nextPage = loadMore ? state.page + 1 : 1;
      final news = await ref
          .read(newsRepositoryProvider)
          .getNews(nextPage);
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
