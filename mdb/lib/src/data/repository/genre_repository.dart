import 'package:mdb/src/data/api/api.dart';
import 'package:mdb/src/data/model/local/genre.dart';
import 'package:mdb/src/data/repository/mdb_repository.dart';

class GenreRepositoryImpl implements GenreRepository{
  final Api _api;

  GenreRepositoryImpl(this._api);

  Future<List<Genre>> fetchGenres() => _api.fetchGenres();
}

abstract class GenreRepository extends MdbRepository{
  Future<List<Genre>> fetchGenres();
}
