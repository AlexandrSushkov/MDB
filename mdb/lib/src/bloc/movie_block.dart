import 'package:mdb/src/data/model/remote/responce/discover_response.dart';
import 'package:mdb/src/data/model/remote/responce/genres_response.dart';
import 'package:mdb/src/data/model/remote/responce/popular_movies_responce.dart';
import 'package:mdb/src/data/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc {
  final _movieRepository = MovieRepository();
  final _popularMoviesFetcher = PublishSubject<PopularMoviesResponse>();
  final _discoverFetcher = PublishSubject<DiscoverResponse>();
  final _genreFetcher = BehaviorSubject<GenresResponse>();
  final Set<int> selectedGenres = Set<int>();

  MoviesBloc() {
    fetchDiscover();
    fetchGenres();
  }

  Observable<PopularMoviesResponse> get popularMovies => _popularMoviesFetcher.stream;

  Observable<Pair<GenresResponse, Set<int>>> get genres => _genreFetcher.stream.zipWith(Stream.fromIterable(selectedGenres).toSet().asStream(), (a, b) => Pair(a, b));

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
    if(selectedGenres.length == 0){
      fetchDiscover();
    }else{
      selectedGenres.addAll(selectedGenres);
      DiscoverResponse genresResponse = await _movieRepository.fetchDiscoverByFilter(selectedGenres);
      _discoverFetcher.sink.add(genresResponse);
      print(genresResponse.toString());
    }

  }

  dispose() {
    _popularMoviesFetcher.close();
    _discoverFetcher.close();
    _genreFetcher.close();
  }
}

MoviesBloc _bloc;

MoviesBloc get bloc {
  if (_bloc == null) {
    _bloc = MoviesBloc();
  }
  return _bloc;
}

class Pair<T1, T2> {
  final T1 first;
  final T2 second;

  Pair(this.first, this.second);
}
