
import 'package:flutter_base/constants/api_constants.dart';
import 'package:flutter_base/models/post_model.dart';
import 'package:flutter_base/services/api_interfaces.dart';
import 'package:flutter_base/services/dio_client.dart';

class ApiCall implements ApiInterface {

  @override
  Future<List<Post>> requestGetPosts() async {
    var response = await DioClient().get(baseUrl, apiGetPosts);
    if (response == null) return [];
    Iterable list = response;
    return list.map((e) => Post.fromJson(e)).toList();
  }

  @override
  Future<Post> requestGetDetailPost(int id) {
    // TODO: implement requestGetDetailPost
    throw UnimplementedError();
  }
}