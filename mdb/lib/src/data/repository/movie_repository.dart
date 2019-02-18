import 'dart:async';

import 'package:mdb/src/data/api/api.dart';
import 'package:mdb/src/data/model/local/genre.dart';
import 'package:mdb/src/data/model/remote/responce/genres_response.dart';
import 'package:mdb/src/data/model/remote/responce/movie_list_response.dart';

class MovieRepository {
  final _api = api;

  Future<MovieListResponse> fetchPopularMovies() => _api.fetchPopularMovies();

  Future<MovieListResponse> fetchDiscover() => _api.fetchDiscover();

  Future<List<Genre>> fetchGenres() => _api.fetchGenres();

  Future<MovieListResponse> fetchDiscoverByFilter(Set<int> selectedGenres) => _api.fetchDiscoverByFilter(selectedGenres);
}
