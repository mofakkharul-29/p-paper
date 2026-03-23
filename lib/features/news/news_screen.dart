import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_papper/core/constant/app_colors.dart';
import 'package:p_papper/features/news/domain/article_model.dart';
import 'package:p_papper/features/news/presentation/provider/news_notifier_provoder.dart';
import 'package:p_papper/features/news/widgets/news_card.dart';

class NewsScreen extends ConsumerStatefulWidget {
  const NewsScreen({super.key});

  @override
  ConsumerState<NewsScreen> createState() =>
      _NewsScreenState();
}

class _NewsScreenState extends ConsumerState<NewsScreen> {
  final ScrollController _scrollController =
      ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref
          .read(newsNotifierProvider.notifier)
          .fetchNews(),
    );
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final notifier = ref.read(
      newsNotifierProvider.notifier,
    );
    final state = ref.read(newsNotifierProvider);

    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent -
                200 &&
        !state.isLoading &&
        state.hasMore) {
      notifier.fetchNews(loadMore: true);
    }
  }

  Future<void> _onRefresh() async {
    await ref
        .read(newsNotifierProvider.notifier)
        .fetchNews();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(newsNotifierProvider);

    if (state.isLoading && state.articles.isEmpty) {
      return const Scaffold(
        backgroundColor: AppColors.screenBackground,
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.spinnerColor,
          ),
        ),
      );
    }

    if (state.error != null && state.articles.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.screenBackground,
        body: Center(child: Text(state.error!)),
      );
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: AppColors.refreshForeground,
      backgroundColor: AppColors.refreshBackground,
      child: ListView.builder(
        controller: _scrollController,
        itemCount:
            state.articles.length +
            (state.isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < state.articles.length) {
            final ArticleModel article =
                state.articles[index];
            return NewsCard(news: article);
          }

          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.spinnerColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
