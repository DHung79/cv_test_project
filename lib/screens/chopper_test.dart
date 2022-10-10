import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'package:cv_test_project/routes/route_names.dart';
import 'package:flutter/material.dart';
import '../core/bloc/post_bloc.dart';
import '../core/models/post_model.dart';
import '../main.dart';
import 'layout_template.dart';

class ChopperScreen extends StatefulWidget {
  const ChopperScreen({Key? key}) : super(key: key);

  @override
  State<ChopperScreen> createState() => _ChopperScreenState();
}

class _ChopperScreenState extends State<ChopperScreen> {
  final _postBloc = PostBloc();
  @override
  void initState() {
    _postBloc.getPosts();
    super.initState();
  }

  @override
  void dispose() {
    _postBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Chopper Test'),
          TextButton(
            onPressed: () async {},
            child: const Icon(Icons.add),
          ),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return StreamBuilder<Response<List<PostModel>>>(
      stream: _postBloc.allData,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          List response = jsonDecode(snapshot.data!.bodyString);
          List<PostModel> posts =
              response.map((e) => PostModel.fromJson(e)).toList();
          return SizedBox(
            height: 500,
            child: _buildPosts(context, posts),
          );
        } else {
          return const CircularProgressIndicator();
        }
      }),
    );
  }

  Widget _buildPosts(BuildContext context, List<PostModel> posts) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return SizedBox(
          height: 200,
          child: Card(
            child: ListTile(
              title: Text(
                post.title!,
              ),
              subtitle: Text(
                post.body!,
              ),
              onTap: () {
                navigateTo('$homeRoute/${post.id}');
              },
            ),
          ),
        );
      },
    );
  }
}
