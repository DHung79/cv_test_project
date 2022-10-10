import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';

import '../core/bloc/post_bloc.dart';
import '../core/models/post_model.dart';
import 'layout_template.dart';

class SinglePostPage extends StatefulWidget {
  final String postId;
  const SinglePostPage({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  State<SinglePostPage> createState() => _SinglePostPageState();
}

class _SinglePostPageState extends State<SinglePostPage> {
  final _postBloc = PostBloc();
  @override
  void initState() {
    _postBloc.specialPost(int.tryParse(widget.postId)!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      child: StreamBuilder<Response<dynamic>>(
        stream: _postBloc.postData,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            var response = jsonDecode(snapshot.data!.bodyString);

            PostModel post = PostModel.fromJson(response);
            return _buildPost(post);
          } else {
            return const CircularProgressIndicator();
          }
        }),
      ),
    );
  }

  Widget _buildPost(PostModel post) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            post.title!,
          ),
          Text(
            post.body!,
          ),
        ],
      ),
    );
  }
}
