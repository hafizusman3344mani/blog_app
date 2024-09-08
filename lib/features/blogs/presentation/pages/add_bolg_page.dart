import 'package:blog_app/core/app/presentation/cubits/app_user_cubit.dart';
import 'package:blog_app/core/app_text_field.dart';
import 'package:blog_app/core/common/cubits/image_picker_cubit.dart';
import 'package:blog_app/core/config/routes/nav_router.dart';
import 'package:blog_app/core/di/service_locator.dart';
import 'package:blog_app/features/blogs/domain/usecases/upload_blog_use_case.dart';
import 'package:blog_app/features/blogs/presentation/cubit/add_blog_cubit.dart';
import 'package:blog_app/features/blogs/presentation/widgets/add_blog_image_widget.dart';
import 'package:blog_app/features/blogs/presentation/widgets/chip_widget.dart';
import 'package:blog_app/features/blogs/presentation/widgets/dotted_border_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBolgPage extends StatefulWidget {
  const AddBolgPage({super.key});

  @override
  State<AddBolgPage> createState() => _AddBolgPageState();
}

class _AddBolgPageState extends State<AddBolgPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AddBlogCubit(uploadBlogUseCase: sl<UploadBlogUseCase>()),
        ),
        BlocProvider(
          create: (context) => ImagePickerCubit(),
        ),
      ],
      child: BlocBuilder<ImagePickerCubit, ImagePickerState>(
        builder: (context, imageState) {
          return BlocConsumer<AddBlogCubit, AddBlogState>(
            listener: (context, state) {
              if (state.addBlogStatus == AddBlogStatus.success &&
                  state.blogEntity != null) {
                NavRouter.pop(context);
              }
            },
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Add Blog'),
                  actions: [
                    IconButton(
                      onPressed: state.addBlogStatus == AddBlogStatus.loading
                          ? null
                          : () {
                              final userState =
                                  context.read<AppUserCubit>().state;
                              BlogInputModel blogInputModel = BlogInputModel(
                                  image: imageState.image!,
                                  title: _titleController.text.trim(),
                                  content: _contentController.text.trim(),
                                  posterId: userState.userEntity!.id,
                                  topics: state.topics
                                      .where((e) => e.isSelected)
                                      .map((e) => e.title)
                                      .toList());
                              context
                                  .read<AddBlogCubit>()
                                  .uploadBlog(blogInputModel: blogInputModel);
                            },
                      icon: state.addBlogStatus == AddBlogStatus.loading
                          ? const CircularProgressIndicator()
                          : const Icon(
                              Icons.done_rounded,
                            ),
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  child: Column(
                    children: [
                      imageState.image != null
                          ? AddBlogImageWidget(
                              image: imageState.image!,
                              onTap: () {
                                context.read<ImagePickerCubit>().pickImage();
                              },
                            )
                          : DottedBorderWidget(
                              onTap: () {
                                context.read<ImagePickerCubit>().pickImage();
                              },
                            ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              state.topics.length,
                              (index) => ChipWidget(
                                    title: state.topics[index].title,
                                    isSelected: state.topics[index].isSelected,
                                    onTap: () => context
                                        .read<AddBlogCubit>()
                                        .selectTop(index),
                                  )),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      AppTextField(
                        hintText: 'Blog Title',
                        controller: _titleController,
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      AppTextField(
                        hintText: 'Blog Content',
                        controller: _contentController,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
