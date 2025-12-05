import 'package:first_project/homework11/models/post.dart';
import 'package:first_project/homework11/models/comment.dart';
import 'package:first_project/homework11/repositories/post_repository.dart';
import 'package:first_project/homework11/services/post_service.dart';

class PostRepositoryImpl implements PostRepository {
  final PostService _postService;

  PostRepositoryImpl(this._postService);

  @override
  Future<List<Post>> getPosts() => _postService.getPosts();

  @override
  Future<List<Comment>> getComments(int postId) =>
      _postService.getComments(postId);

  @override
  Future<void> deletePost(int postId) => _postService.deletePost(postId);
}
