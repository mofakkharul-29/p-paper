import 'package:p_papper/features/news/domain/article_model.dart';

class NewsState {
  final List<ArticleModel> articles;
  final bool isLoading;
  final int page;
  final String? error;
  final bool hasMore;

  NewsState({
    this.articles = const [],
    this.isLoading = false,
    this.page = 1,
    this.error,
    this.hasMore = true,
  });

  NewsState copyWith({
    List<ArticleModel>? articles,
    bool? isLoading,
    int? page,
    String? error,
    bool? hasMore,
  }) {
    return NewsState(
      articles: articles ?? this.articles,
      isLoading: isLoading ?? this.isLoading,
      page: page ?? this.page,
      error: error,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
