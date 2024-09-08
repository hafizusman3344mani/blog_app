import 'package:blog_app/features/blogs/domain/entities/blog_entity.dart';

class BlogModel extends BlogEntity {
  BlogModel(
      {required super.id,
      required super.posterId,
      required super.title,
      required super.content,
      required super.imageUrl,
      required super.posterName,
      required super.topics,
      required super.createdAt,
      required super.updatedAt});

  BlogModel copyWith({
    String? id,
    String? posterId,
    String? title,
    String? content,
    String? imageUrl,
    String? posterName,
    List<String>? topics,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BlogModel(
      id: id ?? this.id,
      posterId: posterId ?? this.posterId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      posterName: posterName ?? this.posterName,
      topics: topics ?? this.topics,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
      id: json['id'] ?? '',
      posterId: json['poster_id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      imageUrl: json['image_url'] ?? '',
      posterName: json['profiles'] != null ? json['profiles']['name'] : '',
      topics:
          List<String>.from(json['topics']).map((e) => e.toString()).toList(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']));

  Map<String, dynamic> toJson() => {
        'id': id,
        'poster_id': posterId,
        'title': title,
        'content': content,
        'image_url': imageUrl,
        'topics': topics,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
}
