import '../../rep/movie_db_api.dart';
import '../../models/movie.dart';
import 'dart:async';

class MovieDetailsBloc {
  MovieDetailsBloc({this.api});

  final IMovieApi api;
  StreamController<Movie> _controller = StreamController<Movie>();

  Stream<Movie> getDetailsStream() => _controller.stream;

  void getDetails(int id) async {
    var d = await api.getMovie(id);
    _controller.sink.add(d);
  }

  void dispose() {
    _controller.close();
  }
}
