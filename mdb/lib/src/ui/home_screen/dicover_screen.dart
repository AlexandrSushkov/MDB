import 'package:flutter/material.dart';
import 'package:mdb/src/ui/movie_detail_screen.dart';

class DiscoverScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: GestureDetector(
          child: Text('Discover Screen'),
          onTap: () => goToDetail(context),
        )
      ),
    );
  }

  void goToDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MovieDetailScreen()
      ),
    );
  }

}

class DiscoverScreenNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Navigator in our app.
    return WillPopScope(
        onWillPop: () => _back(context),
        child:  Navigator(
          initialRoute: '/movie_details',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder = (BuildContext _) => DiscoverScreen();
            return MaterialPageRoute(builder: builder, settings: settings);
          },
        ),
    );

  }

  Future<bool> _back(BuildContext context) async {
    await Navigator.of(context);
  }
}