import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:p_papper/core/cache/custom_cache_manager.dart';
import 'package:p_papper/core/constant/app_colors.dart';
import 'package:p_papper/core/utils/custom_text.dart';
import 'package:p_papper/features/auth/presentation/provider/auth_notifier_provider.dart';
import 'package:p_papper/features/news/domain/article_model.dart';
import 'package:p_papper/features/news/presentation/provider/article_firestore_service_provider.dart';
import 'package:p_papper/features/news/widgets/custom_bookmark.dart';

class NewsCard extends ConsumerWidget {
  final ArticleModel news;
  final bool isUsingAnotherFile;

  const NewsCard({
    super.key,
    required this.news,
    this.isUsingAnotherFile = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formattedDate = DateFormat.yMMMd().format(
      news.publishedAt,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          final userId = ref
              .read(authNotifierProvider)
              .value
              ?.uid;
          final articleService = ref.read(
            articleFirestoreServicesProvider,
          );

          if (userId != null) {
            articleService
                .openArticle(userId, news.id)
                .catchError((e) {
                  debugPrint(
                    'Failed to log opened article: $e',
                  );
                });
          }

          if (!context.mounted) return;
          context.pushNamed(
            'article',
            extra: {
              'url': news.webUrl,
              'title': news.title,
            },
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: AppColors.cardSurface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                blurRadius: 12,
                spreadRadius: 0,
                color: AppColors.cardShadow.withAlpha(
                  (0.08 * 255).toInt(),
                ),
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                    child: news.imageUrl.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: news.imageUrl,
                            fadeInDuration: const Duration(
                              milliseconds: 300,
                            ),
                            memCacheWidth: 600,
                            cacheManager:
                                CustomCacheManager.instance,
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                Container(
                                  height: 180,
                                  width: double.infinity,
                                  color: AppColors
                                      .placeholderBg,
                                  child: const Center(
                                    child:
                                        CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: AppColors
                                              .spinnerColor,
                                        ),
                                  ),
                                ),
                            errorWidget:
                                (context, url, error) =>
                                    _buildPlaceholder(),
                          )
                        : _buildPlaceholder(),
                  ),
                  CustomBookmark(
                    currentArticle: news,
                    isUsingAnotherFile: isUsingAnotherFile,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding:
                              const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                          decoration: BoxDecoration(
                            color:
                                AppColors.badgeBackground,
                            borderRadius:
                                BorderRadius.circular(6),
                          ),
                          child: CustomText(
                            text: news.section,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.badgeText,
                          ),
                        ),
                        const SizedBox(width: 8),
                        CustomText(
                          text: formattedDate,
                          fontSize: 12,
                          color: AppColors.dateText,
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),
                    CustomText(
                      text: news.title,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      maxLines: 2,
                      color: AppColors.titleText,
                    ),

                    const SizedBox(height: 6),
                    if (news.description.isNotEmpty)
                      CustomText(
                        text: news.description,
                        fontSize: 14,
                        color: AppColors.bodyText,
                        maxLines: 2,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      height: 180,
      width: double.infinity,
      color: AppColors.placeholderBg,
      child: const Icon(
        Icons.image_not_supported,
        size: 40,
        color: AppColors.placeholderIcon,
      ),
    );
  }
}
