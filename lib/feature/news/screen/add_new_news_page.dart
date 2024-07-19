import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socialapp/core/common/loader.dart';
import 'package:socialapp/core/constants/constants.dart';
import 'package:socialapp/core/utils.dart';
import 'package:socialapp/feature/auth/controller/auth_controller.dart';
import 'package:socialapp/feature/news/controller/news_controller.dart';
import 'package:socialapp/feature/news/widget/news_editor.dart';
import 'package:socialapp/theme/pallete.dart';

class AddNewNewsPage extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const AddNewNewsPage(),
      );
  const AddNewNewsPage({super.key});

  @override
  ConsumerState<AddNewNewsPage> createState() => AddNewNewsPageState();
}

class AddNewNewsPageState extends ConsumerState<AddNewNewsPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<String> selectedTopics = [];
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage(false, 16, 9);
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  void uploadNews() async {
    final title = titleController.text.trim();
    final content = contentController.text.trim();
    final user = ref.watch(userProvider);

    if (formKey.currentState!.validate() &&
        selectedTopics.isNotEmpty &&
        image != null) {
      await ref.read(newsControllerProvider.notifier).uploadNews(
          image: image!,
          title: title,
          content: content,
          posterId: user!.uid,
          topics: selectedTopics);

      ref.refresh(newsProvider);

      Navigator.pop(context);
    } else {
      showSnackBar(context, "Please fill all fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(newsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: uploadNews,
            icon: const Icon(Icons.done_rounded),
          ),
        ],
      ),
      body: isLoading
          ? Loader(
              color: Colors.red,
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      image != null
                          ? GestureDetector(
                              onTap: selectImage,
                              child: SizedBox(
                                  width: double.infinity,
                                  height: 150,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      image!,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            )
                          : GestureDetector(
                              onTap: selectImage,
                              child: DottedBorder(
                                color: AppPallete.borderColor,
                                dashPattern: const [10, 4],
                                radius: const Radius.circular(10),
                                borderType: BorderType.RRect,
                                strokeCap: StrokeCap.round,
                                child: Container(
                                  height: 150,
                                  width: double.infinity,
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.folder_open,
                                        size: 40,
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        'Select your image',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      const SizedBox(height: 20),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: Constants.topics
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (selectedTopics.contains(e)) {
                                          selectedTopics.remove(e);
                                        } else {
                                          selectedTopics.add(e);
                                        }
                                      });
                                    },
                                    child: Chip(
                                      label: Text(e),
                                      backgroundColor:
                                          selectedTopics.contains(e)
                                              ? AppPallete.gradient1
                                              : null,
                                      side: selectedTopics.contains(e)
                                          ? null
                                          : BorderSide(
                                              color: AppPallete.borderColor,
                                            ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      NewsEditor(
                        controller: titleController,
                        hintText: 'News Title',
                      ),
                      const SizedBox(height: 10),
                      NewsEditor(
                        controller: contentController,
                        hintText: 'News Content',
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
