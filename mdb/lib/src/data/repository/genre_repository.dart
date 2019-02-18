import 'package:mdb/src/data/api/api.dart';
import 'package:mdb/src/data/model/remote/responce/genres_response.dart';

class GenreRepository {
  final _api = api;

  Future<GenresResponse> fetchPopularMovies() => _api.fetchGenres();
}
