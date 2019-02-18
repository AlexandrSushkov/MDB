import 'package:mdb/src/bloc/base/block_provider.dart';
import 'package:mdb/src/data/model/remote/responce/genres_response.dart';
import 'package:mdb/src/data/model/remote/responce/movie_list_response.dart';
import 'package:mdb/src/data/repository/movie_repository.dart';
import 'package:mdb/src/utils/pair.dart';
import 'package:rxdart/rxdart.dart';

DiscoverScreenBloc _bloc;

DiscoverScreenBloc get bloc {
  if (_bloc == null) {
    _bloc = DiscoverScreenBloc._internal();
  }
  return _bloc;
}

class DiscoverScreenBloc implements BlocBase {
  DiscoverScreenBloc._internal() {
    fetchDiscover();
    fetchGenres();
  }

  final _movieRepository = MovieRepository();
  final _popularMoviesFetcher = PublishSubject<MovieListResponse>();
  final _discoverFetcher = PublishSubject<MovieListResponse>();
  final _genreFetcher = BehaviorSubject<GenresResponse>();
  final Set<int> selectedGenres = Set<int>();

  // Outputs
  Observable<MovieListResponse> get popularMovies => _popularMoviesFetcher.stream;

  Observable<Pair<GenresResponse, Set<int>>> get genres =>
      _genreFetcher.stream.zipWith(Stream.fromIterable(selectedGenres).toSet().asStream(), (a, b) => Pair(a, b));

  Observable<MovieListResponse> get discoverMovies => _discoverFetcher.stream;

  @override
  void dispose() {
    _popularMoviesFetcher.close();
    _discoverFetcher.close();
    _genreFetcher.close();
  }

  fetchPopularMovies() async {
    MovieListResponse popularMoviesResponse = await _movieRepository.fetchPopularMovies();
    _popularMoviesFetcher.sink.add(popularMoviesResponse);
  }

  fetchDiscover() async {
    MovieListResponse discoverMoviesResponse = await _movieRepository.fetchDiscover();
    _discoverFetcher.sink.add(discoverMoviesResponse);
  }

  fetchGenres() async {
    GenresResponse genresResponse = await _movieRepository.fetchGenres();
    _genreFetcher.sink.add(genresResponse);
  }

  fetchDiscoverByFilter(Set<int> selectedGenres) async {
    if (selectedGenres.length == 0) {
      fetchDiscover();
    } else {
      selectedGenres.addAll(selectedGenres);
      MovieListResponse genresResponse = await _movieRepository.fetchDiscoverByFilter(selectedGenres);
      _discoverFetcher.sink.add(genresResponse);
      print(genresResponse.toString());
    }
  }
}
