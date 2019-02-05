import 'dart:async';
import 'package:mdb/mysrc/data/api/api.dart';
import 'package:mdb/mysrc/data/model/remote/discover_response.dart';
import 'package:mdb/mysrc/data/model/remote/genres_response.dart';
import 'package:mdb/mysrc/data/model/remote/popular_movies_responce.dart';

class MovieRepository {
  final api = Api();

  Future<PopularMoviesResponse> fetchPopularMovies() => api.fetchPopularMovies();

  Future<GenresResponse> fetchGenres() => api.fetchGenres();

  Future<DiscoverResponse> fetchDiscover() => api.fetchDiscover();

  Future<DiscoverResponse> fetchDiscoverByFilter(Set<int> selectedGenres) => api.fetchDiscoverByFilter(selectedGenres);
}
