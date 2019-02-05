import 'package:mdb/mysrc/data/model/remote/responce/discover_response.dart';
import 'package:mdb/mysrc/data/model/remote/responce/genres_response.dart';
import 'package:mdb/mysrc/data/model/remote/responce/popular_movies_responce.dart';
import 'package:mdb/mysrc/data/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc {
  final _movieRepository = MovieRepository();
  final _popularMoviesFetcher = PublishSubject<PopularMoviesResponse>();
  final _discoverFetcher = PublishSubject<DiscoverResponse>();
  final _genreFetcher = PublishSubject<GenresResponse>();

  Observable<PopularMoviesResponse> get popularMovies => _popularMoviesFetcher.stream;
  Observable<GenresResponse> get genres => _genreFetcher.stream;
  Observable<DiscoverResponse> get discoverMovies => _discoverFetcher.stream;

  fetchAllMovies() async {
    PopularMoviesResponse popularMoviesResponse = await _movieRepository.fetchPopularMovies();
    _popularMoviesFetcher.sink.add(popularMoviesResponse);
  }

  fetchDiscover() async {
    DiscoverResponse discoverResponse = await _movieRepository.fetchDiscover();
    _discoverFetcher.sink.add(discoverResponse);
  }

  fetchGenres() async {
    GenresResponse genresResponse = await _movieRepository.fetchGenres();
    _genreFetcher.sink.add(genresResponse);
  }

  fetchDiscoverByFilter(Set<int> selectedGenres) async {
    DiscoverResponse genresResponse = await _movieRepository.fetchDiscoverByFilter(selectedGenres);
    _discoverFetcher.sink.add(genresResponse);
    print(genresResponse.toString());
  }

  dispose() {
    _popularMoviesFetcher.close();
    _discoverFetcher.close();
    _genreFetcher.close();
  }
}

final bloc = MoviesBloc();
