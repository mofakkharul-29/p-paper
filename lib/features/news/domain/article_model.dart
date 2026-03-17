class ArticleModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String webUrl;
  final String section;
  final DateTime publishedAt;

  ArticleModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.webUrl,
    required this.section,
    required this.publishedAt,
  });

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
    );
  }
}
