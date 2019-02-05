import 'package:flutter/material.dart';
import 'package:mdb/mysrc/ui/home_screen/dicover_screen.dart';

class DiscoverScreenNavigator extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey();

  @override
  State<StatefulWidget> createState() => new DiscoverScreenNavigatorState();
}

class DiscoverScreenNavigatorState extends State<DiscoverScreenNavigator> {

  Future<bool> didPopRoute() async {
    final NavigatorState navigator = widget.navigatorKey.currentState;
    assert(navigator != null);
    return await navigator.maybePop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return !await didPopRoute();
        },
        child: _buildNavigator()
    );
  }

  Navigator _buildNavigator() {
    return Navigator(
      key: widget.navigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder = (BuildContext _) => DiscoverScreen();
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }

}