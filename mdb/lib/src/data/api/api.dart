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
    _api = Api._internal();
  }
  return _api;
}

class Api {
  Api._internal();

  Dio _dio = appModule.dio;

  Future<MovieListResponse> fetchPopularMovies() async {
    final response = await _dio.get(popularMovies);
    return MovieListResponse.fromJson(response.data);
  }

  Future<MovieListResponse> fetchDiscover() async {
    final response = await _dio.get(discover);
    return MovieListResponse.fromJson(response.data);
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

    final response = await _dio.get(discover, queryParameters: {withGenres: selected});
    return MovieListResponse.fromJson(response.data);
  }

  Future<List<Genre>> fetchGenres() async {
    try{
      final response = await _dio.get(genres);
      return GenresResponse.fromJson(response.data).genres;
    }on DioError catch(e) {
      return Future.error(e);
    }
  }
}
