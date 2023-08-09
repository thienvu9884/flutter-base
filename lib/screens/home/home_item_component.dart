import 'package:flutter/material.dart';
import 'package:flutter_base/models/post_model.dart';

class HomeItemComponent extends StatelessWidget {
  final Post post;
  const HomeItemComponent({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('ID: ${post.id}'),
              const SizedBox(
                width: 16,
              ),
              Text('User ID: ${post.userId}'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              post.title,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          Text(post.body)
        ],
      ),
    );
  }
}
