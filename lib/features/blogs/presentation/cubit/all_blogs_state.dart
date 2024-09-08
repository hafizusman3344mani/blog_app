part of 'all_blogs_cubit.dart';

enum AllBlogsStatus { initial, loading, success, error }

class AllBlogsState {
  final AllBlogsStatus status;
  final List<BlogEntity> blogs;
  final String message;

  AllBlogsState({
    required this.status,
    required this.blogs,
    this.message = '',
  });

  factory AllBlogsState.initial() {
    return AllBlogsState(
      status: AllBlogsStatus.initial,
      blogs: [],
    );
  }

  AllBlogsState copyWith(
      {AllBlogsStatus? status, List<BlogEntity>? blogs, String? message}) {
    return AllBlogsState(
      status: status ?? this.status,
      blogs: blogs ?? this.blogs,
      message: message ?? '',
    );
  }
}
