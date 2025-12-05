import 'package:first_project/homework11/models/post.dart';
import 'package:first_project/homework11/models/comment.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts();
  Future<List<Comment>> getComments(int postId);
  Future<void> deletePost(int postId);
}
