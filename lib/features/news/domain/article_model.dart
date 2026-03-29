import 'package:cloud_firestore/cloud_firestore.dart';

class ArticleModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String webUrl;
  final String section;
  final DateTime publishedAt;
  final DateTime? savedAt;

  ArticleModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.webUrl,
    required this.section,
    required this.publishedAt,
    this.savedAt,
  });

  ArticleModel copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? webUrl,
    String? section,
    DateTime? publishedAt,
    DateTime? savedAt,
  }) {
    return ArticleModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      webUrl: webUrl ?? this.webUrl,
      section: section ?? this.section,
      publishedAt: publishedAt ?? this.publishedAt,
      savedAt: savedAt ?? this.savedAt,
    );
  }

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    final fields = json['fields'] ?? {};

    return ArticleModel(
      id: json['id'] ?? '',
      title: fields['headline'] ?? json['webTitle'] ?? '',
      description: fields['trailText'] ?? '',
      imageUrl: fields['thumbnail'] ?? '',
      webUrl: json['webUrl'] ?? '',
      section: json['sectionName'] ?? '',
      publishedAt: json['webPublicationDate'] != null
          ? DateTime.parse(json['webPublicationDate'])
          : DateTime.now(),
      savedAt: null,
    );
  }

  Map<String, dynamic> toMap({DateTime? saveAt}) {
    return {
      'id': id,
      'title': title,
      'description': description.length > 100
          ? description.substring(0, 100)
          : description,
      'imageUrl': imageUrl,
      'webUrl': webUrl,
      'section': section,
      'publishedAt': publishedAt,
      'savedAt': saveAt,
    };
  }

  factory ArticleModel.fromFirestore(
    Map<String, dynamic> json,
  ) {
    DateTime? parseTimestamp(dynamic value) {
      if (value == null) return null;

      if (value is DateTime) return value;

      if (value is Timestamp) return value.toDate();

      return null;
    }

    return ArticleModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      webUrl: json['webUrl'] ?? '',
      section: json['section'] ?? '',
      publishedAt:
          parseTimestamp(json['publishedAt']) ??
          DateTime.now(),
      savedAt:
          parseTimestamp(json['savedAt']) ??
          DateTime.fromMillisecondsSinceEpoch(0),
    );
  }
}
