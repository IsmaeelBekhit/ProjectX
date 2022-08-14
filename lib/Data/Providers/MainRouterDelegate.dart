import 'package:flutter/material.dart';
import 'package:projectx/Data/Models/MainRoutePath.dart';
import 'package:projectx/Data/Providers/MainProvider.dart';
import 'package:projectx/Views/Pages/Register.dart';
import 'package:provider/provider.dart';

import '../../Views/Pages/Home.dart';
import '../../Views/Pages/Splash.dart';
import '../../Views/Pages/Unknown.dart';
import '../../Views/Pages/onBoarding.dart';

class MainRouterDelegate extends RouterDelegate<MainRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MainRoutePath> {
  MainRoutePath path = MainRoutePath();

  final GlobalKey<NavigatorState> navigatorKey;
  bool splash = true;

  MainRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider(create: (_) => this),
        ListenableProvider(create: (_) => MainProvider())
      ],
      child: Navigator(
        key: navigatorKey,
        pages: [
          if (splash)
            const MaterialPage(key: ValueKey('SplashPage'), child: Splash())
          else if (!splash)
            if (path.userId.isNotEmpty &&
                path.userId != 'newUser' &&
                path.userId != '0')
              const MaterialPage(key: ValueKey('HomePage'), child: Home())
            else if (path.userId == '0')
              const MaterialPage(
                  key: ValueKey('RegisteringPage'), child: Register())
            else if (path.userId == 'newUser')
              /* TODO: */ /*const*/ MaterialPage(
                  key: ValueKey('onBoardingPage'), child: onBoarding()),
          if (path.isUnknown)
            const MaterialPage(key: ValueKey('UnknownPage'), child: Unknown())
        ],
        onPopPage: (route, result) {
          bool popStatus = route.didPop(result);
          // final page = route.settings as MaterialPage;
          // if(page.key == const ValueKey("RegisteringPage")){
          //   screenName = '/';
          // }
          return popStatus;
        },
      ),
    );
  }

  @override
  Future<void> setNewRoutePath(MainRoutePath mainRoutePath) async =>
      path = mainRoutePath;

  @override
  MainRoutePath get currentConfiguration {
    if (path.isUnknown) {
      return MainRoutePath.unknown();
    } else {
      return MainRoutePath.user(path.userId);
    }
  }

  void changeUser(String value) {
    path.userId = value;
    path.isUnknown = false;
    print(value);
    splash = false;
    notifyListeners();
  }
}
