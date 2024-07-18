import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socialapp/feature/whatshot/post/screens/add_post_type_screen.dart';

class WriteSomethingWidget extends ConsumerWidget {
  const WriteSomethingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context)
                        .push(AddPostTypeScreen.route('text')),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 1.0, color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: const Text(
                        'Write something here...',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context)
                      .push(AddPostTypeScreen.route('link')),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.link,
                        size: 24.0,
                        color: Colors.pink,
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        'Link',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 24,
                  child: VerticalDivider(color: Colors.grey[600]),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context)
                      .push(AddPostTypeScreen.route('image')),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.photo_library,
                        size: 24.0,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        'Photo',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
