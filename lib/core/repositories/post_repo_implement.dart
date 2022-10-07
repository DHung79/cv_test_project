import 'package:chopper/chopper.dart';
import '../api_services/post_api_services.dart';
import '../models/post_model.dart';

class PostRepoImplement {
  final PostApiServices _postApiServices = PostApiServices.create();

  Future<Response<List<PostModel>>> getPosts() {
    var response = _postApiServices.getAllPosts();
    return response;
  }

  Future<Response> specialPost(id) {
    var response = _postApiServices.specialPost(id);
    return response;
  }

  Future<Response<PostModel>> setPost(model) {
    var response = _postApiServices.sendPost(model);
    return response;
  }

  Future<Response<PostModel>> deletePost(id) {
    var response = _postApiServices.deletePost(id);
    return response;
  }

  Future<Response<PostModel>> updatePost(id, model) {
    var response = _postApiServices.updatePost(id, model);
    return response;
  }
}
