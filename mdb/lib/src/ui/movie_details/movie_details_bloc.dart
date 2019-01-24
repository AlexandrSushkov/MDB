import '../../rep/movie_db_api.dart';
import '../../models/movie.dart';
import 'dart:async';

class MovieDetailsBloc {
  MovieDetailsBloc({this.api});

  final IMovieApi api;
  StreamController<Movie> _controller = StreamController<Movie>();
  StreamController<List<String>> _imagesController = StreamController();
  StreamController<List<Map<String, String>>> _castController =
      StreamController();
  StreamController<List<Map<String, String>>> _similarController =
      StreamController();

  Stream<Movie> getDetailsStream() => _controller.stream;

  Stream<List<String>> getImagesStream() => _imagesController.stream;

  Stream<List<Map<String, String>>> getCastStream() => _castController.stream;

  Stream<List<Map<String, String>>> getSimilarStream() =>
      _similarController.stream;

  void loadDetails(int id) async {
    try {
      var d = await api.getMovie(id);
      _controller.sink.add(d);
    } catch (e) {
      _controller.sink.addError(e.toString());
    }
  }

  void loadImages(int id) async {
    try {
      var d = await api.getMovieImages(id);
      _imagesController.sink.add(d);
    } catch (e) {
      _imagesController.sink.addError(e.toString());
    }
  }

  void loadCast(int id) async {
    try {
      var d = await api.getMovieCast(id);
      _castController.sink.add(d);
    } catch (e) {
      _castController.sink.addError(e.toString());
    }
  }

  void loadSimilar(int id) async {
    try {
      var d = await api.getMovieSimilar(id);
      _similarController.sink.add(d);
    } catch (e) {
      _similarController.sink.addError(e.toString());
    }
  }

  void dispose() {
    _controller.close();
    _imagesController.close();
    _castController.close();
    _similarController.close();
  }
}
