import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_papper/features/auth/presentation/provider/auth_notifier_provider.dart';
import 'package:p_papper/features/news/domain/article_model.dart';
import 'package:p_papper/features/news/presentation/provider/article_firestore_service_provider.dart';
import 'package:p_papper/features/news/presentation/provider/bookmarks_stream_notfier_provider.dart';

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
    final bookMark = ref.watch(
      bookmarksStreamNotifierProvider,
    );

    final isBookmarked = bookMark.when(
      data: (articles) =>
          articles.any((a) => a.id == currentArticle.id),
      error: (_, _) => false,
      loading: () => false,
    );

    final userId = ref
        .watch(authNotifierProvider)
        .value
        ?.uid;

    return Positioned(
      top: 10,
      right: 10,
      child: Material(
        color: Colors.black.withAlpha(120),
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () async {
            if (userId == null) return;

            final firestore = ref.read(
              articleFirestoreServicesProvider,
            );

            try {
              if (isBookmarked) {
                await firestore.deleteFromFirestore(
                  userId,
                  currentArticle.id,
                );
              } else {
                await firestore.writeToFirestore(
                  userId,
                  currentArticle,
                );
              }
            } catch (e) {
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Something went wrong'),
                ),
              );
            }
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
