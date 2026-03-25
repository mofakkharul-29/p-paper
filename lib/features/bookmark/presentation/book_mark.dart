import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_papper/core/utils/custom_exception.dart';
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
          throw CustomException(
            message: e.toString(),
            code: 'error',
            stackTrace: st,
          );
        },
        loading: () => const CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
