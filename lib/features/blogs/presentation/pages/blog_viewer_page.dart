import 'package:blog_app/core/constants/app_pallete.dart';
import 'package:blog_app/core/utils/calculate_reding_time.dart';
import 'package:blog_app/features/blogs/domain/entities/blog_entity.dart';
import 'package:flutter/material.dart';

class BlogViewerPage extends StatelessWidget {
  final BlogEntity blogEntity;
  const BlogViewerPage({super.key, required this.blogEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                blogEntity.title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'By ${blogEntity.posterName}',
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                '${blogEntity.getUpdatedAt} .  ${calculateReadingTime(blogEntity.content)} min',
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppPallete.greyColor),
              ),
              const SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(blogEntity.imageUrl),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                blogEntity.content,
                style: const TextStyle(fontSize: 16, height: 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
