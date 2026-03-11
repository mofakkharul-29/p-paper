import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:p_papper/features/auth/domain/app_user.dart';
import 'package:p_papper/features/auth/domain/auth_repo.dart';

class FirebaseRepo implements AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<AppUser?> registerWithEmailPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      final UserCredential credential = await _auth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

      final User? firebaseUser = credential.user;

      if (firebaseUser == null) return null;

      await credential.user!.updateDisplayName(name);

      final AppUser appUser = AppUser(
        uid: firebaseUser.uid,
        name: name,
        email: email,
        photoUrl: firebaseUser.photoURL,
        createdAt:
            firebaseUser.metadata.creationTime ??
            DateTime.now(),
      );
      return appUser;
    } catch (e) {
      throw Exception('Sign up failed: $e');
    }
  }

  @override
  Future<AppUser?> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final UserCredential userCredintial = await _auth
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          );
      final User? firebaseUser = userCredintial.user;
      if (firebaseUser == null) return null;
      final AppUser user = AppUser(
        uid: firebaseUser.uid,
        name: firebaseUser.displayName,
        email: email,
        photoUrl: firebaseUser.photoURL,
        createdAt:
            firebaseUser.metadata.creationTime ??
            DateTime.now(),
      );
      return user;
    } catch (e) {
      throw Exception('login failed: $e');
    }
  }

  @override
  Future<AppUser?> logInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleAccount =
          await _googleSignIn.signIn();

      if (googleAccount == null) return null;

      final GoogleSignInAuthentication authentication =
          await googleAccount.authentication;

      final OAuthCredential oAuthCredential =
          GoogleAuthProvider.credential(
            accessToken: authentication.accessToken,
            idToken: authentication.idToken,
          );

      final UserCredential userCredential = await _auth
          .signInWithCredential(oAuthCredential);

      final User? firebaseUser = userCredential.user;
      if (firebaseUser == null) return null;

      final AppUser user = AppUser(
        uid: firebaseUser.uid,
        name: firebaseUser.displayName,
        email: firebaseUser.email ?? '',
        photoUrl: firebaseUser.photoURL,
        createdAt:
            firebaseUser.metadata.creationTime ??
            DateTime.now(),
      );
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code ==
          'account-exists-with-different-credential') {
        throw Exception(
          'Account exists with different sign-in method',
        );
      } else if (e.code == 'invalid-credential') {
        throw Exception('Invalid credentials');
      } else if (e.code == 'operation-not-allowed') {
        throw Exception('Google sign-in not enabled');
      }
      throw Exception(
        'Google sign-in failed: ${e.message}',
      );
    } catch (e) {
      throw Exception('Login in failed: $e');
    }
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    try {
      final User? firebaseUser = _auth.currentUser;
      if (firebaseUser == null) return null;

      final AppUser user = AppUser(
        uid: firebaseUser.uid,
        name: firebaseUser.displayName,
        email: firebaseUser.email ?? '',
        photoUrl: firebaseUser.photoURL,
        createdAt:
            firebaseUser.metadata.creationTime ??
            DateTime.now(),
      );

      return user;
    } catch (e) {
      throw Exception('problem getting user: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await Future.wait([
        _googleSignIn.signOut(),
        _auth.signOut(),
      ]);
    } catch (e) {
      throw Exception('log out failed: $e');
    }
  }

  @override
  Future<String> sendPasswordResetEmail(
    String email,
  ) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return 'Password reset email! Check your inbox';
    } catch (e) {
      throw Exception('failed sending email: $e');
    }
  }
  
  @override
  Future<void> deleteAccount({String? password}) {
    
  }
}
