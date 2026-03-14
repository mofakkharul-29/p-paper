import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:p_papper/core/error/auth_exception.dart';
import 'package:p_papper/features/auth/domain/app_user.dart';
import 'package:p_papper/features/auth/domain/auth_repo.dart';

class FirebaseRepo implements AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

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
      await _writeUserDataToFirestore(appUser);

      return appUser;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw const AuthException(
            code: 'email-in-use',
            message: 'Email already registered.',
          );

        case 'weak-password':
          throw const AuthException(
            code: 'weak-password',
            message: 'Password is too weak.',
          );

        case 'invalid-email':
          throw const AuthException(
            code: 'invalid-email',
            message: 'Invalid email address.',
          );

        default:
          throw AuthException(
            code: e.code,
            message: e.message ?? 'Registration failed',
          );
      }
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
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw const AuthException(
            code: 'user-not-found',
            message: 'No account found with this email.',
          );

        case 'wrong-password':
          throw const AuthException(
            code: 'wrong-password',
            message: 'Incorrect password.',
          );

        case 'invalid-email':
          throw const AuthException(
            code: 'invalid-email',
            message: 'Invalid email address.',
          );

        case 'network-request-failed':
          throw const AuthException(
            code: 'network-error',
            message:
                'Network error. Check your connection.',
          );

        default:
          throw AuthException(
            code: e.code,
            message: e.message ?? 'Login failed.',
          );
      }
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
      await _writeUserDataToFirestore(user);
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

  Future<void> _writeUserDataToFirestore(
    AppUser user,
  ) async {
    await _firestore.collection('users').doc(user.uid).set({
      ...user.toMap(),
    }, SetOptions(merge: true));
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
  Future<void> deleteAccount({String? password}) async {
    try {
      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('No authenticated user found');
      }

      final String? providerId =
          currentUser.providerData.isNotEmpty
          ? currentUser.providerData.first.providerId
          : null;

      if (providerId == 'google.com') {
        final GoogleSignInAccount? googleSignInAccount =
            await _googleSignIn.signIn();
        if (googleSignInAccount == null) {
          throw Exception('Re-authentication cancelled');
        }
        final GoogleSignInAuthentication authentication =
            await googleSignInAccount.authentication;
        final OAuthCredential credential =
            GoogleAuthProvider.credential(
              idToken: authentication.idToken,
              accessToken: authentication.accessToken,
            );

        await currentUser.reauthenticateWithCredential(
          credential,
        );
      } else if (providerId == 'password') {
        if (password == null || password.isEmpty) {
          throw Exception(
            'password is required to delete account',
          );
        }
        final credential = EmailAuthProvider.credential(
          email: currentUser.email!,
          password: password,
        );
        await currentUser.reauthenticateWithCredential(
          credential,
        );
      }
      await _deleteUserFirestoreData(currentUser.uid);
      await currentUser.delete();
      await Future.wait([
        _googleSignIn.signOut(),
        _auth.signOut(),
      ]);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'requires-recent-login':
          throw const AuthException(
            code: 'requires-recent-login',
            message:
                'Please log out and log back in before deleting.',
          );
        case 'wrong-password':
          throw const AuthException(
            code: 'wrong-password',
            message:
                'Incorrect password. Please try again.',
          );
        case 'invalid-credential':
          throw const AuthException(
            code: 'invalid-credential',
            message:
                'Invalid credentials. Please try again.',
          );
        case 'network-request-failed':
          throw const AuthException(
            code: 'network-request-failed',
            message:
                'Network error. Check your connection.',
          );
        case 'user-not-found':
          throw const AuthException(
            code: 'user-not-found',
            message: 'Account not found.',
          );
        default:
          throw AuthException(
            code: e.code,
            message: e.message ?? 'Delete account failed',
          );
      }
    } catch (e) {
      throw AuthException(
        code: 'some-thing_went_wrong',
        message: e.toString(),
      );
    }
  }

  Future<void> _deleteUserFirestoreData(String uid) async {
    final WriteBatch batch = _firestore.batch();
    final DocumentReference userDoc = _firestore
        .collection('users')
        .doc(uid);
    batch.delete(userDoc);

    // Delete sub-collections
    final List<String> subCollections = ['comments'];

    for (final String col in subCollections) {
      final QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection(col)
          .get();

      for (final QueryDocumentSnapshot doc
          in snapshot.docs) {
        batch.delete(doc.reference);
      }
    }

    await batch.commit();
  }
}

final firebaseRepoProvider = Provider<FirebaseRepo>((ref) {
  return FirebaseRepo();
});
