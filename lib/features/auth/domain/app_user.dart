import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final String? name;
  final String email;
  final String? photoUrl;
  final DateTime createdAt;

  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.createdAt,
  });

  AppUser copyWith(
    String? uid,
    String? email,
    String? name,
    String? photoUrl,
    DateTime? createdAt,
  ) {
    return AppUser(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory AppUser.fromMap(Map<String, dynamic> user) {
    return AppUser(
      uid: user['uid'] as String,
      name: user['name'] as String,
      email: user['email'] as String,
      photoUrl: user['photoUrl'] as String?,
      createdAt: user['createdAt'] is Timestamp
          ? (user['createdAt'] as Timestamp).toDate()
          : DateTime.parse(user['createdAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'createdAt': createdAt,
    };
  }
}
