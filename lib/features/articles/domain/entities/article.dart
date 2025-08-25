import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String id;
  final String title;
  final String description;
  final String url;
  final String? urlToImage;
  final DateTime publishedAt;
  final String sourceName;

  const Article({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    required this.sourceName,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    url,
    urlToImage,
    publishedAt,
    sourceName,
  ];
}
