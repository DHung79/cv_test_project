import 'package:cv_test_project/core/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:cv_test_project/routes/route_names.dart';
import 'package:cv_test_project/screens/layout_template.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class DraggableScreen extends StatefulWidget {
  const DraggableScreen({Key? key}) : super(key: key);

  @override
  State<DraggableScreen> createState() => _DraggableScreenState();
}

class _DraggableScreenState extends State<DraggableScreen> {

  Widget dynamicIcon = Text('Drag the icon in here');
  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: TextButton(
              onPressed: () {
                navigateTo(cameraRoute);
              },
              child: const Text('Open Camera'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Draggable<Widget>(
                data: Icon(Icons.adb_sharp),
                feedback: Container(
                  height: 100,
                  width: 100,
                  child: const Center(
                    child: Icon(Icons.adb_sharp),
                  ),
                ),
                childWhenDragging: Container(
                  height: 100.0,
                  width: 100.0,
                  child: const Center(
                    child: Icon(Icons.adb_sharp),
                  ),
                ),
                child: Container(
                  height: 100.0,
                  width: 100.0,
                  child: const Center(
                    child: Icon(Icons.adb_sharp),
                  ),
                ),
              ),
              Draggable<Widget>(
                data: Icon(Icons.face),
                feedback: Container(
                  height: 100,
                  width: 100,
                  child: const Center(
                    child: Icon(Icons.face),
                  ),
                ),
                childWhenDragging: Container(
                  height: 100.0,
                  width: 100.0,
                  child: const Center(
                    child: Icon(Icons.face),
                  ),
                ),
                child: Container(
                  height: 100.0,
                  width: 100.0,
                  child: const Center(
                    child: Icon(Icons.face),
                  ),
                ),
              ),
            ],
          ),
          DragTarget(
            builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return _buildDraggable();
            },
            onAccept: (Widget data) {
              setState(() {
                dynamicIcon = data;
              });
            },
          ),
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
