import 'package:flutter/material.dart';
import '../movie_details/movie_details.dart';

class DiscoverScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(child: Text('content')),
        onTap: () {
          Route route = MaterialPageRoute(
              builder: (context) => MovieDetails(
                    title: "Fight club",
                    id: 550,
                  ));
          Navigator.of(context).push(route);
        },
      ),
    );
  }
}
