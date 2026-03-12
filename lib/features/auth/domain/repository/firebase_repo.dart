import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
      // await _deleteUserFirestoreData(currentUser.uid);
      await currentUser.delete();
      await Future.wait([
        _googleSignIn.signOut(),
        _auth.signOut(),
      ]);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'requires-recent-login':
          throw Exception(
            'Please log out and log back in before deleting.',
          );
        case 'wrong-password':
          throw Exception(
            'Incorrect password. Please try again.',
          );
        case 'invalid-credential':
          throw Exception(
            'Invalid credentials. Please try again.',
          );
        case 'network-request-failed':
          throw Exception(
            'Network error. Check your connection.',
          );
        case 'user-not-found':
          throw Exception('Account not found.');
        default:
          throw Exception(
            'Delete account failed: ${e.message}',
          );
      }
    } catch (e) {
      throw Exception('Delete account failed: $e');
    }
  }

  // Future<void> _deleteUserFirestoreData(String uid) async {
  //   final WriteBatch batch = _firestore.batch();
  //   final DocumentReference userDoc = _firestore
  //       .collection('users')
  //       .doc(uid);
  //   batch.delete(userDoc);

  //   // Delete sub-collections
  //   final List<String> subCollections = ['comments'];

  //   for (final String col in subCollections) {
  //     final QuerySnapshot snapshot = await _firestore
  //         .collection('users')
  //         .doc(uid)
  //         .collection(col)
  //         .get();

  //     for (final QueryDocumentSnapshot doc
  //         in snapshot.docs) {
  //       batch.delete(doc.reference);
  //     }
  //   }

  //   await batch.commit();
  // }
}
