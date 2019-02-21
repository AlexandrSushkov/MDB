import 'package:mdb/src/bloc/base/block_provider.dart';
import 'package:mdb/src/data/model/local/genre.dart';
import 'package:mdb/src/data/model/remote/responce/movie_list_response.dart';
import 'package:mdb/src/data/repository/genre_repository.dart';
import 'package:mdb/src/data/repository/movie_repository.dart';
import 'package:mdb/src/utils/pair.dart';
import 'package:rxdart/rxdart.dart';

class DiscoverScreenBloc implements BlocBase {
  final MovieRepository _movieRepository;
  final GenreRepository _genreRepository;

  DiscoverScreenBloc(this._movieRepository, this._genreRepository) {
    fetchDiscover();
    fetchGenres();
  }

  final _popularMoviesFetcher = PublishSubject<MovieListResponse>();
  final _discoverFetcher = PublishSubject<MovieListResponse>();
  final _genreFetcher = BehaviorSubject<List<Genre>>();
  final Set<int> selectedGenres = Set<int>();

  // Outputs
  Observable<MovieListResponse> get popularMovies => _popularMoviesFetcher.stream;

  Observable<Pair<List<Genre>, Set<int>>> get genres =>
      _genreFetcher.stream.zipWith(Stream.fromIterable(selectedGenres).toSet().asStream(), (a, b) => Pair(a, b));

  Observable<MovieListResponse> get discoverMovies => _discoverFetcher.stream;

  @override
  void dispose() {
    _popularMoviesFetcher.close();
    _discoverFetcher.close();
    _genreFetcher.close();
  }

  fetchPopularMovies() async {
    await _movieRepository.fetchPopularMovies().then((MovieListResponse popularMoviesResponse) {
      _popularMoviesFetcher.sink.add(popularMoviesResponse);
      print(popularMoviesResponse.toString());
    }).catchError((e) {
      _handleError(e);
    });
  }

  fetchDiscover() async {
    await _movieRepository.fetchDiscover().then((MovieListResponse genresResponse) {
      _discoverFetcher.sink.add(genresResponse);
      print(genresResponse.toString());
    }).catchError((e) {
      _handleError(e);
    });
  }

  fetchGenres() async {
    await _genreRepository.fetchGenres().then((List<Genre> genres) {
      _genreFetcher.sink.add(genres);
    }).catchError((e) {
      _handleError(e);
    });
  }

  fetchDiscoverByFilter(Set<int> selectedGenres) async {
    if (selectedGenres.length == 0) {
      fetchDiscover();
    } else {
      selectedGenres.addAll(selectedGenres);
      await _movieRepository.fetchDiscoverByFilter(selectedGenres).then((MovieListResponse genresResponse) {
        _discoverFetcher.sink.add(genresResponse);
        print(genresResponse.toString());
      }).catchError((e) {
        _handleError(e);
      });
    }
  }

  _handleError(Error e) => print(e);
}
