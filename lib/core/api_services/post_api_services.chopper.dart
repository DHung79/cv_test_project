// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_api_services.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$PostApiServices extends PostApiServices {
  _$PostApiServices([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = PostApiServices;

  @override
  Future<Response<List<PostModel>>> getAllPosts() {
    final $url = '/posts';
    final $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<PostModel>, PostModel>($request);
  }

  @override
  Future<Response> specialPost(int id) {
    final $url = '/posts/${id}';
    final $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<PostModel>> sendPost(Map<String, dynamic> data) {
    final $url = '/posts';
    final $body = data;
    final $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<PostModel, PostModel>($request);
  }

  @override
  Future<Response<PostModel>> deletePost(int id) {
    final $url = '/posts/${id}';
    final $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<PostModel, PostModel>($request);
  }

  @override
  Future<Response<PostModel>> updatePost(
    int id,
    Map<String, dynamic> data,
  ) {
    final $url = '/posts/${id}';
    final $body = data;
    final $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<PostModel, PostModel>($request);
  }
}
