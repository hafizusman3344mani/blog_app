part of 'add_blog_cubit.dart';

enum AddBlogStatus { initial, loading, success, error }

class AddBlogState {
  final List<BlogTopic> topics;
  final BlogEntity? blogEntity;
  final AddBlogStatus addBlogStatus;

  AddBlogState(
      {required this.topics, required this.addBlogStatus, this.blogEntity});

  factory AddBlogState.initial() {
    return AddBlogState(
      topics: [
        BlogTopic(title: 'Technology'),
        BlogTopic(title: 'Business'),
        BlogTopic(title: 'Programming'),
        BlogTopic(title: 'Entertainment'),
      ],
      addBlogStatus: AddBlogStatus.initial,
    );
  }

  AddBlogState copyWith(
      {List<BlogTopic>? topics,
      AddBlogStatus? addBlogStatus,
      BlogEntity? blogEntity}) {
    return AddBlogState(
        topics: topics ?? this.topics,
        addBlogStatus: addBlogStatus ?? this.addBlogStatus,
        blogEntity: blogEntity);
  }
}

class BlogTopic {
  final String title;
  bool isSelected;

  BlogTopic({
    required this.title,
    this.isSelected = false,
  });
}
