import 'package:mdb/mysrc/bloc/bloc.dart';
import 'package:mdb/mysrc/data/model/remote/discover_response.dart';
import 'package:mdb/mysrc/data/model/remote/genres_response.dart';
import 'package:mdb/mysrc/data/model/remote/popular_response.dart';
import 'package:mdb/mysrc/data/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc implements BlocBase {

  MoviesBloc(){
    fetchDiscover();
    fetchGenres();
  }

  final _movieRepository = MovieRepository();
  final _popularMoviesFetcher = PublishSubject<PopularResponse>();
  final _discoverFetcher = PublishSubject<DiscoverResponse>();
  final _genreFetcher = PublishSubject<GenresResponse>();

  Observable<PopularResponse> get popularMovies => _popularMoviesFetcher.stream;
  Observable<GenresResponse> get genres => _genreFetcher.stream;
  Observable<DiscoverResponse> get discoverMovies => _discoverFetcher.stream;

  fetchAllMovies() async {
    PopularResponse popularMoviesResponse = await _movieRepository.fetchPopularMovies();
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
    DiscoverResponse discoverResponse = await _movieRepository.fetchDiscoverByFilter(selectedGenres);
    _discoverFetcher.sink.add(discoverResponse);
  }

  dispose() {
    _popularMoviesFetcher.close();
    _discoverFetcher.close();
    _genreFetcher.close();
  }

}
