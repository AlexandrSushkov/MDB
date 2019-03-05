import 'dart:async';

import 'package:mdb/src/data/api/api.dart';
import 'package:mdb/src/data/model/local/genre.dart';
import 'package:mdb/src/data/model/remote/responce/movie_list_response.dart';
import 'package:mdb/src/data/repository/mdb_repository.dart';

class MovieRepositoryImpl implements MovieRepository{
  final Api _api;

  MovieRepositoryImpl(this._api);

  Future<MovieListResponse> fetchPopularMovies() => _api.fetchPopularMovies();

  Future<MovieListResponse> fetchDiscover() => _api.fetchDiscover();

  Future<List<Genre>> fetchGenres() => _api.fetchGenres();

  Future<MovieListResponse> fetchDiscoverByFilter(Set<int> selectedGenres) => _api.fetchDiscoverByFilter(selectedGenres);
}

abstract class MovieRepository extends MdbRepository{
  Future<MovieListResponse> fetchPopularMovies();
  Future<MovieListResponse> fetchDiscover();
  Future<List<Genre>> fetchGenres();
  Future<MovieListResponse> fetchDiscoverByFilter(Set<int> selectedGenres);
}
