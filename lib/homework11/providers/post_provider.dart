import 'package:first_project/homework11/models/post.dart';
import 'package:flutter/material.dart';

import 'package:first_project/homework11/repositories/post_repository.dart';
import 'package:first_project/homework11/repositories/post_repository_impl.dart';
import 'package:first_project/homework11/services/post_service.dart';

class PostProvider with ChangeNotifier {
  late final PostRepository _repository = PostRepositoryImpl(PostService());

  List<Post> _posts = [];
  bool _isLoading = false;
  String? _error;

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadPosts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _posts = await _repository.getPosts();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deletePost(int postId) async {
    try {
      await _repository.deletePost(postId);
      _posts.removeWhere((post) => post.id == postId);
      notifyListeners();
    } catch (e) {
      throw Exception('Не вдалося видалити пост: $e');
    }
  }
}
