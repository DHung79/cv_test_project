import 'package:cv_test_project/core/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:cv_test_project/routes/route_names.dart';
import 'package:cv_test_project/screens/layout_template.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget dynamicIcon = Text('Drag the icon in here');
  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('this is home screen'),
        ],
      ),
    );
  }

  Widget _buildDraggable() {
    return Container(
      width: 200,
      height: 200,
      color: Colors.amber,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: dynamicIcon,
        ),
      ),
    );
  }
}
