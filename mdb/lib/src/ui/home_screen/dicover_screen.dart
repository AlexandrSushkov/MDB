import 'package:flutter/material.dart';
import '../movie_details/movie_details.dart';

class DiscoverScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
          child: GestureDetector(
        child: Text('Discover Screen'),
        onTap: () => goToDetail(context),
      )),
    );
  }

  void goToDetail(BuildContext context) {
    Route route = MaterialPageRoute(
        builder: (context) => MovieDetails(
              title: "Fight club",
              id: 550,
            ));
    Navigator.of(context).push(route);
  }
}
