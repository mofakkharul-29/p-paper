import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_papper/core/network/dio_client.dart';
import 'package:p_papper/features/news/domain/repository/news_repository.dart';
import 'package:p_papper/features/news/service/news_service.dart';

final dioProvider = Provider<Dio>((ref) {
  return DioClient().dio;
});

final newsServiceProvider = Provider<NewsService>((ref) {
  final dio = ref.watch(dioProvider);
  return NewsService(dio);
});

final newsRepositoryProvider = Provider<NewsRepository>((
  ref,
) {
  final service = ref.watch(newsServiceProvider);
  return NewsRepository(service);
});
