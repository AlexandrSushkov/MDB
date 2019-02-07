import 'package:mdb/src/data/api/api.dart';
import 'package:mdb/src/data/model/remote/genres_response.dart';

class GenreRepository {

  final api = Api();

  Future<GenresResponse> fetchPopularMovies() => api.fetchGenres();

}
