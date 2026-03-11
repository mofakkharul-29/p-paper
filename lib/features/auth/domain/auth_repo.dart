import 'package:p_papper/features/auth/domain/app_user.dart';

abstract class AuthRepo {
  Future<AppUser?> registerWithEmailPassword(
    String email,
    String password,
    String name,
  );

  Future<AppUser?> loginWithEmailAndPassword(
    String email,
    String password,
  );

  Future<AppUser?> logInWithGoogle();

  Future<void> logout();

  Future<String> sendPasswordResetEmail(String email);

  Future<AppUser?> getCurrentUser();

  Future<void> deleteAccount({String? password});
}
