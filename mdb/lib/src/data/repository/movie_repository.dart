import 'dart:async';
import 'package:mdb/src/data/api/api.dart';
import 'package:mdb/src/data/model/remote/discover_response.dart';
import 'package:mdb/src/data/model/remote/genres_response.dart';
import 'package:mdb/src/data/model/remote/popular_response.dart';

class MovieRepository {
  final api = Api();

  Future<PopularResponse> fetchPopularMovies() => api.fetchPopularMovies();

  Future<GenresResponse> fetchGenres() => api.fetchGenres();

  Future<DiscoverResponse> fetchDiscover() => api.fetchDiscover();

  Future<DiscoverResponse> fetchDiscoverByFilter(Set<int> selectedGenres) => api.fetchDiscoverByFilter(selectedGenres);
}
