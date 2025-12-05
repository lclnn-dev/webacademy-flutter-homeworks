import 'package:flutter/material.dart';
import 'package:first_project/homework11/models/comment.dart';
import 'package:first_project/homework11/repositories/post_repository_impl.dart';
import 'package:first_project/homework11/services/post_service.dart';

class CommentsScreen extends StatelessWidget {
  final int postId;
  final String postTitle;

  const CommentsScreen(
      {super.key, required this.postId, required this.postTitle});

  @override
  Widget build(BuildContext context) {
    final repository = PostRepositoryImpl(PostService());

    return Scaffold(
      appBar: AppBar(title: const Text('Коментарі до посту')),
      body: FutureBuilder<List<Comment>>(
        future: repository.getComments(postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Помилка: ${snapshot.error}'));
          }
          final comments = snapshot.data ?? [];
          if (comments.isEmpty) {
            return const Center(child: Text('Немає коментарів'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: comments.length,
            itemBuilder: (_, i) {
              final comment = comments[i];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(comment.name,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(comment.email,
                          style: TextStyle(color: Colors.grey[700])),
                      const SizedBox(height: 8),
                      Text(comment.body),
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
