import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'locator.dart';
import 'routes/app_route_information_parser.dart';
import 'routes/app_router_delegate.dart';
import 'scroll_behavior.dart';
import 'utils/app_state_notifier.dart';

GlobalKey globalMainKey = GlobalKey();
Future<SharedPreferences> prefs = SharedPreferences.getInstance();

navigateTo(String route) async {
  locator<AppRouterDelegate>().navigateTo(route);
}

late List<CameraDescription> cameras;
bool isBackground = false;

final List<Locale> supportedLocales = <Locale>[
  const Locale('vi'),
  const Locale('en'),
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await initHiveForFlutter();
  setupLocator();
  runApp(
    ChangeNotifierProvider<AppStateNotifier>(
      create: (_) => AppStateNotifier(),
      child: const App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => AppState();
  static AppState? of(BuildContext context) =>
      context.findAncestorStateOfType<AppState>();
}

class AppState extends State<App> with WidgetsBindingObserver {
  final AppRouteInforParser _routeInfoParser = AppRouteInforParser();
  Locale currentLocale = supportedLocales[0];

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) return;
    if (state == AppLifecycleState.paused) {
      setState(() {
        isBackground = true;
      });
    }

    super.didChangeAppLifecycleState(state);
  }

  void setLocale(Locale value) {
    setState(() {
      currentLocale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateNotifier>(
      builder: (context, appState, child) {
        return MaterialApp.router(
          title: 'cv_test_project',
          debugShowCheckedModeBanner: false,
          themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          routeInformationParser: _routeInfoParser,
          routerDelegate: locator<AppRouterDelegate>(),
          builder: (context, child) => child!,
          scrollBehavior: MyCustomScrollBehavior(),
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: supportedLocales,
          locale: currentLocale,
        );
      },
    );
  }
}
