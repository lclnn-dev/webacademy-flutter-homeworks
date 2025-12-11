import 'package:first_project/homework11/providers/post_provider.dart';
import 'package:first_project/homework11/screens/posts_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Homework11Screen extends StatelessWidget {
  const Homework11Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostProvider(),
      child: const PostListScreen(),
    );
  }
}