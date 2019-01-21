import 'package:flutter/material.dart';
import 'movie_details.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: Text('content'),
              onTap: () {
                Route route = MaterialPageRoute(
                    builder: (context) => MovieDetails(
                          title: "Fight club",
                          id: 550,
                        ));
                Navigator.of(context).push(route);
              },
            )
          ],
        ),
      ),
    );
  }
}
