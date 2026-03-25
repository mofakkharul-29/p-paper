import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_papper/core/error/custom_exception.dart';
import 'package:p_papper/core/utils/custom_text.dart';
import 'package:p_papper/features/news/presentation/provider/bookmarks_stream_notfier_provider.dart';

class BookMark extends ConsumerWidget {
  const BookMark({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarks = ref.watch(
      bookmarksStreamNotifierProvider,
    );

    return SafeArea(
      child: bookmarks.when(
        data: (articles) {
          if (articles.isEmpty) {
            return const Center(
              child: CustomText(
                text: 'No item added yet !',
                color: Colors.black87,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            );
          }

          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return Container();
            },
          );
        },
        error: (e, st) {
          final errorMessage = e is CustomException
              ? e.message
              : 'Something went wrong';

          return Center(
            child: CustomText(
              text: errorMessage,
              color: Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          );
        },
        loading: () => const CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
