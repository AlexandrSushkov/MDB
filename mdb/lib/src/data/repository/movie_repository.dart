import 'dart:async';
import 'package:mdb/src/data/api/api.dart';
import 'package:mdb/src/data/model/remote/responce/discover_response.dart';
import 'package:mdb/src/data/model/remote/responce/genres_response.dart';
import 'package:mdb/src/data/model/remote/responce/popular_movies_responce.dart';

class MovieRepository {
  final api = Api();

  Future<PopularMoviesResponse> fetchPopularMovies() => api.fetchPopularMovies();

  Future<DiscoverResponse> fetchDiscover() => api.fetchDiscover();

  Future<GenresResponse> fetchGenres() => api.fetchGenres();

  Future<DiscoverResponse> fetchDiscoverByFilter(Set<int> selectedGenres) => api.fetchDiscoverByFilter(selectedGenres);
}
