import 'package:blog_app/core/config/routes/nav_router.dart';
import 'package:blog_app/core/constants/app_pallete.dart';
import 'package:blog_app/features/blogs/presentation/cubit/all_blogs_cubit.dart';
import 'package:blog_app/features/blogs/presentation/pages/blog_viewer_page.dart';
import 'package:blog_app/features/blogs/presentation/widgets/blog_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app/presentation/cubits/app_user_cubit.dart';
import '../../../../core/di/service_locator.dart';
import '../../domain/entities/blog_entity.dart';
import 'add_bolg_page.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appUser = context.read<AppUserCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blogs'),
        actions: [
          IconButton(
            onPressed: () {
              NavRouter.push(context, const AddBolgPage());
            },
            icon: const Icon(
              CupertinoIcons.add_circled,
            ),
          ),
          // BlocListener<AppUserCubit, AppUserState>(
          //   listener: (context, state) {
          //     if (state.userStatus == AppUserStatus.loaded) {
          //       if (state.userEntity == null) {
          //         NavRouter.pushReplacementUntil(context, const SignUpPage());
          //       }
          //     }
          //   },
          //   child: IconButton(
          //       onPressed: () {
          //         appUser.logout();
          //       },
          //       icon: const Icon(Icons.logout)),
          // )
        ],
      ),
      body: BlocProvider(
        create: (context) => sl<AllBlogsCubit>()..getAllBlogs(),
        child: BlocBuilder<AllBlogsCubit, AllBlogsState>(
          builder: (context, state) {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: state.blogs.length,
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 16,
                );
              },
              itemBuilder: (context, index) {
                BlogEntity blog = state.blogs[index];
                return BlogCardWidget(
                    onTap: () {
                      NavRouter.push(
                          context,
                          BlogViewerPage(
                            blogEntity: blog,
                          ));
                    },
                    blog: blog,
                    color: index % 2 == 0
                        ? AppPallete.gradient1
                        : AppPallete.gradient2);
              },
            );
          },
        ),
      ),
    );
  }
}
