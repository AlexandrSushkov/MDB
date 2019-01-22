import '../rep/movie_db_api.dart';
import '../rep/movie_api_mapper.dart';
import '../ui/movie_details/movie_details_bloc.dart';

class DepInj {
  static final DepInj instance = DepInj._privateconstructor();

  factory DepInj() {
    return instance;
  }

  IMovieApiMapper _movieApiMapper;
  IMovieApi _movieApi;

  DepInj._privateconstructor() {
    _movieApiMapper = MovieApiMapper();
    _movieApi = MovieApi(mapper: _movieApiMapper);
  }

  IMovieApi getMovieApi() => _movieApi;
}
