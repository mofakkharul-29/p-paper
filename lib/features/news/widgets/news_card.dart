import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p_papper/core/utils/custom_text.dart';
import 'package:p_papper/features/news/domain/article_model.dart';

class NewsCard extends StatelessWidget {
  final ArticleModel news;

  const NewsCard({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat.yMMMd().format(
      news.publishedAt,
    );

    return GestureDetector(
      onTap: () {
        // 👉 later: open article / webview
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              color: Colors.black.withAlpha(
                (0.08 * 255).toInt(),
              ),
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
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
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.withAlpha(
                            (0.1 * 255).toInt(),
                          ),
                          borderRadius:
                              BorderRadius.circular(6),
                        ),
                        child: CustomText(
                          text: news.section,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 8),
                      CustomText(
                        text: formattedDate,
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),
                  CustomText(
                    text: news.title,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    maxLines: 2,
                  ),

                  const SizedBox(height: 6),
                  if (news.description.isNotEmpty)
                    CustomText(
                      text: news.description,
                      fontSize: 14,
                      color: Colors.black87,
                      maxLines: 2,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      height: 180,
      width: double.infinity,
      color: Colors.grey.shade300,
      child: const Icon(
        Icons.image_not_supported,
        size: 40,
        color: Colors.grey,
      ),
    );
  }
}
