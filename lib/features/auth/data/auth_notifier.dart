import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_papper/features/auth/domain/app_user.dart';
import 'package:p_papper/features/auth/domain/repository/firebase_repo.dart';

class AuthNotifier extends AsyncNotifier<AppUser?> {
  late final FirebaseRepo _authRepo;
  late final FirebaseFirestore _firestore;

  @override
  Future<AppUser?> build() async {
    _authRepo = FirebaseRepo();
    _firestore = FirebaseFirestore.instance;
    final AppUser? user = await _authRepo.getCurrentUser();

    return user;
  }

  void reset() {
    state = const AsyncValue.data(null);
  }

  Future<void> registerWithEmailAndPassword(
    String email,
    String name,
    String password,
  ) async {
    state = const AsyncValue.loading();
    try {
      final AppUser? user = await _authRepo
          .registerWithEmailPassword(email, password, name);

      if (user != null) {
        await _firestore
            .collection('users')
            .doc(user.uid)
            .set({
              ...user.toMap(),
            }, SetOptions(merge: true));

        state = AsyncValue.data(user);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
