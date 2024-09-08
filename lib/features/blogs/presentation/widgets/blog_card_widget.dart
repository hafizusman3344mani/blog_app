import 'package:blog_app/features/blogs/domain/entities/blog_entity.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/calculate_reding_time.dart';
import 'chip_widget.dart';

class BlogCardWidget extends StatelessWidget {
  final BlogEntity blog;
  final Color color;
  final VoidCallback onTap;
  const BlogCardWidget(
      {super.key,
      required this.blog,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 200,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      blog.topics.length,
                      (index) => ChipWidget(
                        onTap: () {},
                        vPadding: 0,
                        title: blog.topics[index],
                        isSelected: false,
                      ),
                    ),
                  ),
                ),
                Text(
                  blog.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  blog.content,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Text('${calculateReadingTime(blog.content)} min'),
          ],
        ),
      ),
    );
  }
}
