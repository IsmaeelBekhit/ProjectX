import 'package:flutter/material.dart';
import 'package:projectx/Data/Models/MainRoutePath.dart';

class MainRouteInformationParser extends RouteInformationParser<MainRoutePath>{

  @override
  Future<MainRoutePath> parseRouteInformation(RouteInformation routeInformation) async{
    final uri = Uri.parse(routeInformation.location!);
    if(uri.pathSegments.isEmpty) {
        return MainRoutePath();
    }
    else if(uri.pathSegments[0] == 'register'){
      return MainRoutePath.user('0');
    }
    else {
      return MainRoutePath.unknown();
    }
  }

  @override
  RouteInformation restoreRouteInformation(MainRoutePath path){
    if(path.userId == '0'){
      return const RouteInformation(location: '/register');
    }
    else if(path.isUnknown) {
      return const RouteInformation(location: '/404');
    } else {
      return const RouteInformation(location: '/');
    }
  }
}