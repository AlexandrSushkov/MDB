import 'package:mdb/src/data/api/api.dart';
import 'package:mdb/src/data/model/local/genre.dart';

class GenreRepository {
  final _api = api;

  Future<List<Genre>> fetchGenres() => _api.fetchGenres();
}
