import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/post_provider.dart';
import 'screens/posts_screen.dart';

void main() {
  runApp(const PostsCommentsApp());
}

class PostsCommentsApp extends StatelessWidget {
  const PostsCommentsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Перегляд постів і коментарів',
        home: PostListScreen(),
      ),
    );
  }
}
