import 'dart:async';
import 'package:dio/dio.dart';
import 'package:mdb/src/data/model/remote/responce/discover_response.dart';
import 'package:mdb/src/data/model/remote/responce/genres_response.dart';
import 'package:mdb/src/data/model/remote/responce/popular_movies_responce.dart';
import 'package:mdb/src/utils/constants.dart';

class Api {
  Dio dio = Dio();

  Api() {
    dio.interceptors.add(apiKeyInterceptor);
    dio.interceptors.add(baseUrlInterceptor);
    dio.interceptors.add(logInterceptor);
  }

  Interceptor get apiKeyInterceptor => InterceptorsWrapper(onRequest: (RequestOptions requestOptions) {
        requestOptions.queryParameters.addAll({apiKey: theMovieDBApiKey});
      });

  Interceptor get baseUrlInterceptor => InterceptorsWrapper(onRequest: (RequestOptions requestOptions) {
        requestOptions.baseUrl = baseUrl;
      });

  Interceptor get logInterceptor => LogInterceptor(request: true, responseBody: true, error: true, requestHeader: false, responseHeader: false);

  Future<PopularMoviesResponse> fetchPopularMovies() async {
    final response = await dio.get(popularMovies);
    return PopularMoviesResponse.fromJson(response.data);
  }

  Future<GenresResponse> fetchGenres() async {
    final response = await dio.get(genres);
    return GenresResponse.fromJson(response.data);
  }

  Future<DiscoverResponse> fetchDiscover() async {
    final response = await dio.get(discover);
    return DiscoverResponse.fromJson(response.data);
  }

  Future<DiscoverResponse> fetchDiscoverByFilter(Set<int> selectedGenres) async {
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

    final response = await dio.get(discover, queryParameters: {withGenres: selected});
    return DiscoverResponse.fromJson(response.data);
  }
}
