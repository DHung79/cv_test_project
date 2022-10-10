import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'layout_template.dart';

class VideoPage extends StatefulWidget {
  final File file;

  const VideoPage({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.file(widget.file)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((value) => _videoPlayerController.play());
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      child: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: VideoPlayer(_videoPlayerController),
        ),
      ),
    );
  }
}
