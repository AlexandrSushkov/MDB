import 'package:http/io_client.dart';

import '../rep/movie_api_mapper.dart';
import '../rep/movie_db_api.dart';

class DepInj {
  static final DepInj instance = DepInj._privateConstructor();

  factory DepInj() {
    return instance;
  }

  IMovieApiMapper _movieApiMapper;
  IMovieApi _movieApi;

  DepInj._privateConstructor() {
    _movieApiMapper = MovieApiMapper();
    _movieApi = MovieApi(mapper: _movieApiMapper, client: IOClient());
  }

  IMovieApi getMovieApi() => _movieApi;
}
