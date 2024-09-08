import 'package:intl/intl.dart';

class BlogEntity {
  final String id;
  final String posterId;
  final String title;
  final String content;
  final String imageUrl;
  final String posterName;
  final List<String> topics;
  final DateTime createdAt;
  final DateTime updatedAt;

  BlogEntity(
      {required this.id,
      required this.posterId,
      required this.imageUrl,
      required this.posterName,
      required this.topics,
      required this.title,
      required this.content,
      required this.createdAt,
      required this.updatedAt});

  get getUpdatedAt => DateFormat('d MMM, yyyy').format(updatedAt);
}
