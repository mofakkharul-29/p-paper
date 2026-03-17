import 'package:dio/dio.dart';
import 'package:p_papper/core/network/api_exception.dart';
import 'package:p_papper/core/network/error_handler.dart';
import 'package:p_papper/features/news/domain/article_model.dart';

class NewsService {
  final Dio dio;

  NewsService(this.dio);

  Future<List<ArticleModel>> fetchNews({
    int page = 1,
  }) async {
    try {
      final response = await dio.get(
        '/search',
        queryParameters: {'page': page, 'page-size': 10},
      );

      final results = response.data['response']['results'];

      return results
          .map<ArticleModel>((article) => ArticleModel.fromJson(article))
          .toList();
    } on DioException catch (e) {
      throw ApiException(handleDioError(e));
    }
  }
}
