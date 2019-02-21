import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mdb/src/data/model/local/genre.dart';
import 'package:mdb/src/data/model/remote/responce/genres_response.dart';
import 'package:mdb/src/data/model/remote/responce/movie_list_response.dart';
import 'package:mdb/src/di/app_module.dart';
import 'package:mdb/src/utils/constants.dart';

Api _api;

Api get api {
  if (_api == null) {
    _api = Api._internal(appModule.dio);
  }
  return _api;
}

class Api {
  Api._internal(this._dio);

  final Dio _dio;

  Future<MovieListResponse> fetchPopularMovies() async {
    return await _dio.get(popularMovies).then((movieListResponse) {
      return MovieListResponse.fromJson(movieListResponse.data);
    });
  }

  Future<MovieListResponse> fetchDiscover() async {
    return await _dio.get(discover).then((movieListResponse) {
      return MovieListResponse.fromJson(movieListResponse.data);
    });
  }

  Future<MovieListResponse> fetchDiscoverByFilter(Set<int> selectedGenres) async {
    String selected = selectedGenres
        .toString()
        .replaceAll(
            RegExp(
              r'{',
            ),
            '')
        .replaceAll(
            RegExp(
              r'}',
            ),
            '');
    return await _dio.get(discover, queryParameters: {withGenres: selected}).then((movieListResponse) {
      return MovieListResponse.fromJson(movieListResponse.data);
    });
  }

  Future<List<Genre>> fetchGenres() async {
    return await _dio.get(genres).then((genreResponse) {
//      return Future.error(ArgumentError("genre test error"));
      return GenresResponse.fromJson(genreResponse.data).genres;
    });
  }
}
