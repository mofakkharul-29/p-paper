import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentPage extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void onPageChange(int value) {
    state = value;
    return;
  }
}
