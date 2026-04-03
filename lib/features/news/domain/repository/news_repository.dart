import 'package:p_papper/features/news/domain/article_model.dart';
import 'package:p_papper/features/news/service/news_service.dart';

class NewsRepository {
  final NewsService service;

  NewsRepository(this.service);

  Future<List<ArticleModel>> getNews({
    int page = 1,
    String? query,
    String? section,
  }) async {
    return await service.fetchNews(
      page: page,
      query: query,
      section: section,
    );
  }
}
