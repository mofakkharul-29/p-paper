import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_papper/features/news/domain/article_model.dart';
import 'package:p_papper/features/news/presentation/provider/bookmark_status_provider.dart';

class CustomBookmark extends ConsumerWidget {
  final ArticleModel currentArticle;
  final Function()? onTap;
  const CustomBookmark({
    super.key,
    required this.onTap,
    required this.currentArticle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBookmarked = ref
        .watch(bookmarkNotifierProvider)
        .contains(currentArticle.id);

    return Positioned(
      top: 10,
      right: 10,
      child: Material(
        color: Colors.black.withAlpha(120),
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            // 👉 later: save to firestore
            ref
                .read(bookmarkNotifierProvider.notifier)
                .toggleBookmarked(currentArticle.id);
          },
          child: Padding(
            padding: EdgeInsets.all(6),
            child: Icon(
              isBookmarked
                  ? Icons.bookmark
                  : Icons.bookmark_border,
              color: Colors.amber,
              fontWeight: FontWeight.w700,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
