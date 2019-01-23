import 'package:flutter/material.dart';
import 'package:mdb/src/ui/home_screen/dicover_screen.dart';
import 'package:mdb/src/ui/home_screen/home_screen.dart';
import 'package:mdb/src/ui/movie_detail_screen.dart';

class MdbRoutes {
  static const String home = '/';
  static const String discovery = '/discovery';
  static const String search = '/search';
  static const String watchList = '/watch_list';
  static const String details = '/movie_details';
}

Map<String, WidgetBuilder> smbRoutes = {
  MdbRoutes.home: (context) => HomeScreen(),
//  MdbRoutes.details: (context) => MovieDetailScreen(),
//  MdbRoutes.discovery: (context) => DiscoverScreenNavigator()
};


class MdbNavigator extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var routeBuilders = _routeBuilders(context);
    return Navigator(
        initialRoute: MdbRoutes.home,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders[MdbRoutes.home](context),
          );
        });
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      MdbRoutes.home: (context) => HomeScreen(),
      MdbRoutes.details: (context) => MovieDetailScreen()
    };
  }

  void pushDetail(BuildContext context) {
//    var routeBuilders = _routeBuilders(context);
    Navigator.pushNamed(context, '/movie_details');
  }

}