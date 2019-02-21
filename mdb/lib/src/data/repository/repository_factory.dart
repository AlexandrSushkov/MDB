import 'package:mdb/src/data/api/api.dart';
import 'package:mdb/src/data/repository/genre_repository.dart';
import 'package:mdb/src/data/repository/mdb_repository.dart';
import 'package:mdb/src/data/repository/movie_repository.dart';

class RepositoryFactory {
  RepositoryFactory._internal();

  static T provide<T extends MdbRepository>() {
    switch (T) {
      case MovieRepository:
        return (MovieRepositoryImpl(api) as T);
        break;
      case GenreRepository:
        return (GenreRepositoryImpl(api) as T);
        break;
      default:
        throw Exception('$T is not implemented $RepositoryFactory');
    }
  }
}
