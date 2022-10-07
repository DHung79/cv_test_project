import 'package:cv_test_project/screens/graphql_screen.dart';
import 'package:flutter/material.dart';
import '../screens/camera_screen.dart';
import '../screens/chopper_test.dart';
import '../screens/home_screen.dart';
import '../screens/post_page.dart';
import 'no_animation_transition_delegate.dart';
import 'route_names.dart';
import 'route_path.dart';

class AppRouterDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();
  String _routePath = '';

  @override
  AppRoutePath get currentConfiguration => AppRoutePath.routeFrom(_routePath);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      transitionDelegate: NoAnimationTransitionDelegate(),
      pages: [
        _pageFor(_routePath),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        notifyListeners();

        return true;
      },
    );
  }

  _pageFor(String route) {
    return MaterialPage(
      key: const ValueKey('HomeService'),
      child: _screenFor(route),
    );
  }

  _screenFor(String route) {
    if (route == initialRoute) {
      return const HomeScreen();
    }
    if (route == cameraRoute) {
      return const CameraScreen();
    }
    // if (route.startsWith(homeRoute)) {
    //   if (route.length > homeRoute.length) {
    //     final id = route.substring(homeRoute.length + 1, route.length);
    //     if (id.isNotEmpty) return SinglePostPage(postId: id);
    //   }
    //   return const ChopperScreen();
    // }
    if (route == graphqlRoute) {
      return const GraghqlScreen();
    }
    return const SizedBox();
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath configuration) async {
    _routePath = configuration.name!;
  }

  void navigateTo(String name) {
    _routePath = name;
    notifyListeners();
  }
}
