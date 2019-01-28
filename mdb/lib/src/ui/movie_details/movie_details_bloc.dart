import '../../rep/movie_db_api.dart';
import '../../models/movie.dart';
import 'dart:async';

class MovieDetailsBloc {
  MovieDetailsBloc({this.api}) {
    _newSimilar.stream.where((n) => !_isLoading).listen(_loadNextSimilar);
  }

  final IMovieApi api;
  bool _isLoading = false;
  StreamController<Movie> _controller = StreamController<Movie>();
  StreamController<List<String>> _imagesController = StreamController();
  StreamController<List<Map<String, String>>> _castController =
      StreamController();
  StreamController<List<Map<String, String>>> _similarController =
      StreamController();
  StreamController<int> _newSimilar = StreamController();

  Stream<Movie> getDetailsStream() => _controller.stream;

  Stream<List<String>> getImagesStream() => _imagesController.stream;

  Stream<List<Map<String, String>>> getCastStream() => _castController.stream;

  Stream<List<Map<String, String>>> getSimilarStream() =>
      _similarController.stream;

  Sink<int> get newSimilar => _newSimilar.sink;

  int _similarPage = 0;

  void _loadNextSimilar(int data) {
    _isLoading = true;
    _loadSimilar(data);
  }

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

  void _loadSimilar(int id) async {
    try {
      _similarPage++;
      var d = await api.getMovieSimilar(id, _similarPage);
      _similarController.sink.add(d);
    } catch (e) {
      _similarController.sink.addError(e.toString());
    } finally {
      _isLoading = false;
    }
  }

  void dispose() {
    _controller.close();
    _newSimilar.close();
    _imagesController.close();
    _castController.close();
    _similarController.close();
  }
}
