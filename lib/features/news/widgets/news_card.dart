import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p_papper/core/constant/app_colors.dart';
import 'package:p_papper/core/utils/custom_text.dart';
import 'package:p_papper/features/news/domain/article_model.dart';
import 'package:p_papper/features/news/widgets/custom_bookmark.dart';

class NewsCard extends StatelessWidget {
  final ArticleModel news;

  const NewsCard({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat.yMMMd().format(
      news.publishedAt,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // 👉 later: open article / webview
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
                        ? Image.network(
                            news.imageUrl,
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) =>
                                _buildPlaceholder(),
                          )
                        : _buildPlaceholder(),
                  ),
                  CustomBookmark(onTap: () {}),
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
                            // color: Colors.blue,
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
                        // color: Colors.black87,
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
