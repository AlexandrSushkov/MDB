import 'package:mdb/src/data/model/remote/responce/popular_movies_responce.dart';
import 'package:mdb/src/data/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc {
  final _movieRepository = MovieRepository();
  final _popularMoviesFetcher = PublishSubject<PopularMoviesResponse>();

  Observable<PopularMoviesResponse> get popularMovies => _popularMoviesFetcher.stream;

  fetchAllMovies() async {
    PopularMoviesResponse popularMoviesResponse = await _movieRepository.fetchPopularMovies();
    _popularMoviesFetcher.sink.add(popularMoviesResponse);
  }

  dispose() {
    _popularMoviesFetcher.close();
  }
}

final bloc = MoviesBloc();