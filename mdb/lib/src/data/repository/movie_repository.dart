import 'dart:async';

import 'package:mdb/src/data/api/api.dart';
import 'package:mdb/src/data/model/remote/responce/genres_response.dart';
import 'package:mdb/src/data/model/remote/responce/movie_list_response.dart';

class MovieRepository {
  final api = Api();

  Future<MovieListResponse> fetchPopularMovies() => api.fetchPopularMovies();

  Future<MovieListResponse> fetchDiscover() => api.fetchDiscover();

  Future<GenresResponse> fetchGenres() => api.fetchGenres();

  Future<MovieListResponse> fetchDiscoverByFilter(Set<int> selectedGenres) => api.fetchDiscoverByFilter(selectedGenres);
}
