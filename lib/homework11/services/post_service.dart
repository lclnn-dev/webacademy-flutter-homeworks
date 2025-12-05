import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:first_project/homework11/models/post.dart';
import 'package:first_project/homework11/models/comment.dart';

class PostService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Post>> getPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Post.fromJson(json)).toList();
    }
    throw Exception('Failed to load posts');
  }

  Future<List<Comment>> getComments(int postId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/posts/$postId/comments'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Comment.fromJson(json)).toList();
    }
    throw Exception('Failed to load comments');
  }

  Future<void> deletePost(int postId) async {
    final response = await http.delete(Uri.parse('$baseUrl/posts/$postId'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete post');
    }
  }
}
