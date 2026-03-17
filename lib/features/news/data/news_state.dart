import 'package:p_papper/features/news/domain/article_model.dart';

class NewsState {
  final List<ArticleModel> articles;
  final bool isLoading;
  final int page;
  final String? error;

  NewsState({
    this.articles = const [],
    this.isLoading = false,
    this.page = 1,
    this.error,
  });

  NewsState copyWith({
    List<ArticleModel>? articles,
    bool? isLoading,
    int? page,
    String? error,
  }) {
    return NewsState(
      articles: articles ?? this.articles,
      isLoading: isLoading ?? this.isLoading,
      page: page ?? this.page,
      error: error,
    );
  }
}
