import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_papper/features/onboarding/data/current_page.dart';

final currentPageProvider =
    NotifierProvider<CurrentPage, int>(CurrentPage.new);
