import 'package:flutter/material.dart';

class PageTemplate extends StatefulWidget {
  final Widget child;
  const PageTemplate({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<PageTemplate> createState() => _PageTemplateState();
}

class _PageTemplateState extends State<PageTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
    );
  }
}
