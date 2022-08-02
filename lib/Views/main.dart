import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projectx/Data/Parsers/MainRouteInformationParser.dart';
import 'package:projectx/Data/Providers/MainRouterDelegate.dart';
import 'package:projectx/Data/Models/MainRoutePath.dart';
import 'package:projectx/Data/Providers/MainProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/AppThemes.dart';

void main() async {

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.black.withOpacity(0.0),
        statusBarIconBrightness: Brightness.light,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: [SystemUiOverlay.top]);

  runApp(Main());
}

class Main extends StatelessWidget {
  RouterDelegate<MainRoutePath> mainRouterDelegate = MainRouterDelegate();
  RouteInformationParser<MainRoutePath> mainRouteInformationParser =
      MainRouteInformationParser();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: MainProvider(),
      child: Selector<MainProvider, ThemeMode>(
          selector: (context, provider) => provider.theme,
          builder: (context, theme, child) => MaterialApp.router(
              theme: AppThemes.lightTheme,
              // darkTheme: AppThemes.darkTheme,
              themeMode: theme,
              routeInformationParser: mainRouteInformationParser,
              routerDelegate: mainRouterDelegate)),
    );
  }
}
