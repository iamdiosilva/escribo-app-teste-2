import '../../domain/entities/e_book_entity.dart';

class EBookModel extends EBookEntity {
  EBookModel({
    required super.id,
    required super.title,
    required super.author,
    required super.coverUrl,
    required super.downloadUrl,
  });

  factory EBookModel.fromJson(Map<String, dynamic> json) {
    return EBookModel(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      coverUrl: json['cover_url'],
      downloadUrl: json['download_url'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'cover_url': coverUrl,
        'download_url': downloadUrl,
      };
}
