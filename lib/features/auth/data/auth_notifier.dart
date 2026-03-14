import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_papper/features/auth/domain/app_user.dart';
import 'package:p_papper/features/auth/domain/repository/firebase_repo.dart';

class AuthNotifier extends AsyncNotifier<AppUser?> {
  late final FirebaseRepo _authRepo;

  @override
  Future<AppUser?> build() async {
    _authRepo = ref.read(firebaseRepoProvider);

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

      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    state = const AsyncValue.loading();
    try {
      final AppUser? user = await _authRepo
          .loginWithEmailAndPassword(email, password);
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> loginWithGoogle() async {
    state = const AsyncValue.loading();
    try {
      final AppUser? user = await _authRepo
          .logInWithGoogle();
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> logOut() async {
    state = const AsyncValue.loading();
    try {
      await _authRepo.logout();
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteAccount({String? password}) async {
    state = AsyncValue.loading();
    try {
      await _authRepo.deleteAccount(password: password);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<String> sendPasswordResetEmail(
    String email,
  ) async {
    try {
      return await _authRepo.sendPasswordResetEmail(email);
    } catch (e) {
      rethrow;
    }
  }
}
