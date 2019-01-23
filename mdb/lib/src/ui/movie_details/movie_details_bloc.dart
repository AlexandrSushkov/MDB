import '../../rep/movie_db_api.dart';
import '../../models/movie.dart';
import 'dart:async';

class MovieDetailsBloc {
  MovieDetailsBloc({this.api});

  final IMovieApi api;
  StreamController<Movie> _controller = StreamController<Movie>();
  StreamController<List<String>> _imagesController = StreamController();

  Stream<Movie> getDetailsStream() => _controller.stream;

  Stream<List<String>> getImagesStream() => _imagesController.stream;

  void getDetails(int id) async {
    try {
      var d = await api.getMovie(id);
      _controller.sink.add(d);
    } catch (e) {
      _controller.sink.addError(e.toString());
    }
  }

  void getImages(int id) async {
    try {
      var d = await api.getMovieImages(id);
      _imagesController.sink.add(d);
    } catch (e) {
      _imagesController.sink.addError(e.toString());
    }
  }

  void dispose() {
    _controller.close();
    _imagesController.close();
  }
}
