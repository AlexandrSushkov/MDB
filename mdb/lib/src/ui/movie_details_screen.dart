import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mdb/src/data/model/local/movie.dart';
import 'package:mdb/src/ui/movie_page_viver_item.dart';
import 'package:mdb/src/utils/constants.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({Key key, @required this.movie})
      : assert(movie != null),
        super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Hero(
              tag: movie.id,
              child: Container(
                height: 300.0,
                child: Image.network(
                  '$imagePrefixLarge${movie.poster_path}',
                  fit: BoxFit.cover,
                ),
              )),
          Text(movie.title),
          Text(movie.overview)
        ],
      ),
    ));
  }
}
