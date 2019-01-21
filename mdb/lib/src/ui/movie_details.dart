import 'package:flutter/material.dart';
import '../di/di.dart';
import '../rep/movie_db_api.dart';
import '../models/movie.dart';

class MovieDetails extends StatelessWidget {
  MovieDetails({Key key, this.title, this.id}) : super(key: key);
  final String title;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: _Body(
        id: id,
      ),
    );
  }
}

class _Body extends StatefulWidget {
  _Body({Key key, this.id}) : super(key: key);
  final int id;

  @override
  _BodyState createState() => _BodyState(id: id);
}

class _BodyState extends State<_Body> {
  _BodyState({this.id});

  int id;
  List ws = [];
  Movie _movie;
  IMovieApi _api = DepInj().getMovieApi();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return _movie == null
        ? _getProgressDialog()
        : Center(
            child: Text(_movie.title + "\n" + _movie.overview),
          );
  }

  _getProgressDialog() => Center(child: CircularProgressIndicator());

  _loadData() async {
    Movie m = await _api.getMovie(id);
    setState(() {
      _movie = m;
    });
  }
}
