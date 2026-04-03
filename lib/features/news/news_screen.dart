import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_papper/core/constant/app_colors.dart';
import 'package:p_papper/features/news/domain/article_model.dart';
import 'package:p_papper/features/news/presentation/provider/news_notifier_provoder.dart';
import 'package:p_papper/features/news/widgets/category_section.dart';
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
  final FocusNode _focusNode = FocusNode();

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
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(newsNotifierProvider);

    if (state.isLoading && state.articles.isEmpty) {
      return Scaffold(
        backgroundColor: Theme.of(
          context,
        ).scaffoldBackgroundColor,
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.spinnerColor,
          ),
        ),
      );
    }

    if (state.error != null && state.articles.isEmpty) {
      return Scaffold(
        backgroundColor: Theme.of(
          context,
        ).scaffoldBackgroundColor,
        body: Center(child: Text(state.error!)),
      );
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: AppColors.refreshForeground,
      backgroundColor: AppColors.refreshBackground,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 5,
            ),
            child: TextField(
              focusNode: _focusNode,
              textInputAction: TextInputAction.done,
              onTapOutside: (event) {
                _focusNode.unfocus();
              },
              style: TextStyle(
                color: Theme.of(
                  context,
                ).textTheme.bodyMedium?.color,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              onChanged: (value) {
                ref
                    .read(newsNotifierProvider.notifier)
                    .onSearchChanged(value);
              },
              decoration: _inputDecoration(),
            ),
          ),
          const CategorySection(),
          const SizedBox(height: 5),
          Expanded(
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
          ),
        ],
      ),
    );
  }

  InputDecoration? _inputDecoration() {
    return InputDecoration(
      hintText: 'Search news...',
      hintStyle: TextStyle(
        color: Theme.of(context).textTheme.bodySmall?.color,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color:
              Theme.of(
                context,
              ).textTheme.bodyMedium?.color ??
              Colors.white,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      prefixIcon: Icon(
        Icons.search,
        color: Theme.of(
          context,
        ).textTheme.bodyMedium?.color,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
