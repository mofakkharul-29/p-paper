import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_papper/features/news/data/news_notifier.dart';
import 'package:p_papper/features/news/data/news_state.dart';

final newsNotifierProvider =
    NotifierProvider<NewsNotifier, NewsState>(
      NewsNotifier.new,
    );
