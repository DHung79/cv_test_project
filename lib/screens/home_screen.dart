import 'package:flutter/material.dart';
import 'package:cv_test_project/routes/route_names.dart';
import 'package:cv_test_project/screens/layout_template.dart';
import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PackageModel> packages = [
    PackageModel(name: 'graphql', route: graphqlRoute),
    PackageModel(name: 'chopper', route: chopperRoute),
  ];
  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: packages.length,
        itemBuilder: (context, index) {
          final package = packages[index];
          return Container(
            width: 150,
            height: 150,
            // color: Colors.blueAccent,
            child: TextButton(
              onPressed: () {
                navigateTo(package.route);
              },
              child: Center(child: Text(package.name)),
            ),
          );
        },
      ),
    );
  }
}

class PackageModel {
  final String name;
  final String route;
  PackageModel({
    required this.name,
    required this.route,
  });
}
