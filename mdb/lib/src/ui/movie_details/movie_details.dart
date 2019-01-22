import 'package:flutter/material.dart';
import '../../di/di.dart';
import '../../models/movie.dart';
import 'movie_details_bloc.dart';

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
  MovieDetailsBloc bloc = MovieDetailsBloc(api: DepInj().getMovieApi());

  @override
  void initState() {
    super.initState();
    bloc.getDetails(id);
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.getDetailsStream(),
      builder: (BuildContext context, AsyncSnapshot<Movie> snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data.overview);
        }
        return _getProgressDialog();
      },
    );
  }

  _getProgressDialog() => Center(child: CircularProgressIndicator());
}
