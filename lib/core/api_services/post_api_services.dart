import 'package:chopper/chopper.dart';
import 'package:cv_test_project/core/models/post_model.dart';
part 'post_api_services.chopper.dart';

@ChopperApi(baseUrl: '/posts')
abstract class PostApiServices extends ChopperService {
  // get all posts from server
  @Get()
  Future<Response<List<PostModel>>> getAllPosts();

  // get special post from server
  @Get(path: '/{id}')
  Future<Response> specialPost(@Path() int id);

  // send post to server
  @Post()
  Future<Response<PostModel>> sendPost(@Body() Map<String, dynamic> data);

  // delete post from server
  @Delete(path: '/{id}')
  Future<Response<PostModel>> deletePost(@Path() int id);

  // update post
  @Put(path: '/{id}')
  Future<Response<PostModel>> updatePost(
      @Path() int id, @Body() Map<String, dynamic> data);

  // make request to server and create instance from this abstract class
  static PostApiServices create() {
    final client = ChopperClient(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      services: [_$PostApiServices()],
      converter: const JsonConverter(),
      // interceptors: [
      //   const HeadersInterceptor({
      //     'Content-Type': 'application/json',
      //   }),
      //   (Request request) async {
      //     return request;
      //   },
      //   (Response response) async {
      //     if (response.statusCode == 404) {
      //       chopperLogger.severe('404 Not Found');
      //     }
      //     return response;
      //   },
      // ],
    );
    return _$PostApiServices(client);
  }
}
