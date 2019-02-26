import 'dart:async';

import 'package:mdb/src/bloc/base/base_bloc.dart';
import 'package:mdb/src/data/model/local/genre.dart';
import 'package:mdb/src/data/model/remote/responce/movie_list_response.dart';
import 'package:mdb/src/data/repository/genre_repository.dart';
import 'package:mdb/src/data/repository/movie_repository.dart';
import 'package:mdb/src/utils/pair.dart';
import 'package:rxdart/rxdart.dart';

class DiscoverScreenBloc extends BaseBloc {
  final MovieRepository _movieRepository;
  final GenreRepository _genreRepository;
  final _subscriptions = <StreamSubscription<dynamic>>[];
  final Set<int> _selectedGenres = Set<int>();

  //event controllers
  final _onFilterClickEventStreamController = PublishSubject<void>();
  final _applyFilterStreamController = PublishSubject<Set<int>>();
  final _addFilterStreamController = PublishSubject<int>();
  final _removeFilterStreamController = PublishSubject<int>();

  //state controllers
  final _movieListStreamController = BehaviorSubject<MovieListResponse>();
  final _genreListStreamController = BehaviorSubject<List<Genre>>();
  final _errorHandlerStreamController = PublishSubject<String>();
  final _onFilterClickStateStreamController = PublishSubject<void>();

  DiscoverScreenBloc(this._movieRepository, this._genreRepository) {
    _initListeners();
    _fetchPopularMovies();
    _fetchGenres();
  }

  //input
  Sink<void> get onFilterClickEvent => _onFilterClickEventStreamController.sink;

  Sink<Set<int>> get applyFilterEvent => _applyFilterStreamController.sink;

  Sink<int> get addFilter => _addFilterStreamController.sink;

  Sink<int> get removeFilter => _removeFilterStreamController.sink;

  // Outputs
  Observable<MovieListResponse> get moviesState => _movieListStreamController.stream;

  Observable<Pair<List<Genre>, Set<int>>> get genresState =>
      _genreListStreamController.stream.zipWith(Stream.fromIterable(_selectedGenres).toSet().asStream(), (a, b) => Pair(a, b));

  Observable<String> get errorHandlerState => _errorHandlerStreamController.stream;

  Observable<void> get onFilterClickState => _onFilterClickStateStreamController.stream;

  @override
  void dispose() {
    _closeControllers();
    _clearSubscriptions();
  }

  _initListeners() {
    _subscriptions.add(_onFilterClickEventStreamController.stream.listen((_) => _showFilterSheet()));
    _subscriptions.add(_applyFilterStreamController.stream.listen((Set<int> selectedGenres) {
      if (selectedGenres.length == 0) {
        _fetchPopularMovies();
      } else {
        _fetchDiscoverByFilter(selectedGenres);
      }
    }));
    _subscriptions.add(_addFilterStreamController.stream.listen((genreId) {
      _selectedGenres.add(genreId);
      print(_selectedGenres.toString());
    }));
    _subscriptions.add(_removeFilterStreamController.stream.listen((genreId) {
      _selectedGenres.remove(genreId);
      print(_selectedGenres.toString());
    }));
    }

  _fetchPopularMovies() async {
    await _movieRepository.fetchPopularMovies().then((MovieListResponse popularMoviesResponse) {
      _movieListStreamController.sink.add(popularMoviesResponse);
      print(popularMoviesResponse.toString());
    }).catchError((e) {
      _handleError(e);
    });
  }

  _fetchGenres() async {
    await _genreRepository.fetchGenres().then((List<Genre> genres) {
      _genreListStreamController.sink.add(genres);
    }).catchError((e) {
      _handleError(e);
    });
  }

  _fetchDiscoverByFilter(Set<int> selectedGenres) async {
    await _movieRepository.fetchDiscoverByFilter(selectedGenres).then((MovieListResponse genresResponse) {
      _movieListStreamController.sink.add(genresResponse);
      print(genresResponse.toString());
    }).catchError((e) {
      _handleError(e);
    });
  }

  _showFilterSheet() {
    _onFilterClickStateStreamController.sink.add(VoidFunc);
  }

//  _handleError(Error e) => _errorHandler.sink.add(e.toString());
  _handleError(Error e) {
    _errorHandlerStreamController.sink.add(e.toString());
    print(e);
  }

  _closeControllers() {
    _onFilterClickStateStreamController.close();
    _onFilterClickEventStreamController.close();
    _applyFilterStreamController.close();
    _movieListStreamController.close();
    _genreListStreamController.close();
    _errorHandlerStreamController.close();
    _addFilterStreamController.close();
    _removeFilterStreamController.close();
  }

  _clearSubscriptions() {
    _subscriptions.forEach((subscription) => subscription.cancel());
  }
}
