import 'package:mdb/src/data/model/remote/responce/genres_response.dart';
import 'package:mdb/src/data/model/remote/responce/popular_movies_responce.dart';
import 'package:mdb/src/data/repository/genre_repository.dart';
import 'package:mdb/src/data/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc {
  final _movieRepository = MovieRepository();
  final _popularMoviesFetcher = PublishSubject<PopularMoviesResponse>();
  final _genreFetcher = PublishSubject<GenresResponse>();

  Observable<PopularMoviesResponse> get popularMovies => _popularMoviesFetcher.stream;
  Observable<GenresResponse> get genres => _genreFetcher.stream;

  fetchAllMovies() async {
    PopularMoviesResponse popularMoviesResponse = await _movieRepository.fetchPopularMovies();
    _popularMoviesFetcher.sink.add(popularMoviesResponse);
  }

  fetchGenres() async {
    GenresResponse genresResponse = await _movieRepository.fetchGenres();
    _genreFetcher.sink.add(genresResponse);
  }

  dispose() {
    _popularMoviesFetcher.close();
    _genreFetcher.close();
  }
}

final bloc = MoviesBloc();