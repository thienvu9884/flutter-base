import 'package:flutter_base/models/post_model.dart';

abstract class ApiInterface {
  // Get posts
  Future<List<Post>> requestGetPosts();

  // Get posts
  Future<Post> requestGetDetailPost(int id);
}