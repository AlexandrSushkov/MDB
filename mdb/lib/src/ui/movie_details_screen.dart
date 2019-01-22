import 'package:flutter/material.dart';
import 'package:mdb/src/data/model/local/movie.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({Key key, @required this.movie})
      : assert(movie != null),
        super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('${movie.title}')),
        body: Text('${movie.overview}'),
      );
}
