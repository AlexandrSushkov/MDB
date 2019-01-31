import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../models/movie.dart';
import 'api_request_builder.dart';
import 'movie_api_mapper.dart';

abstract class IMovieApi {
  Future<Movie> getMovie(int id);

  Future<List<String>> getMovieImages(int id);

  Future<List<Map<String, String>>> getMovieCast(int id);

  Future<List<Map<String, String>>> getMovieSimilar(int id, int page);
}

class MovieApi implements IMovieApi {
  MovieApi({@required this.mapper, @required this.client});

  final IMovieApiMapper mapper;
  final http.Client client;

  @override
  Future<Movie> getMovie(int id) async {
    http.Response response =
        await client.get(ApiRequestBuilder.getMovieUrl(id));
    if (response.statusCode == 200) {
      return mapper.parseMovie(response.body);
    } else {
      throw Exception("Something went wrong. Try again later.");
    }
  }

  @override
  Future<List<String>> getMovieImages(int id) async {
    http.Response response =
        await client.get(ApiRequestBuilder.getMovieImagesUrl(id));
    if (response.statusCode == 200) {
      return mapper.parseImagesList(response.body);
    } else {
      throw Exception("Something went wrong. Try again later.");
    }
  }

  @override
  Future<List<Map<String, String>>> getMovieCast(int id) async {
    http.Response response =
        await client.get(ApiRequestBuilder.getMovieCastUrl(id));
    if (response.statusCode == 200) {
      return mapper.parseCastList(response.body);
    } else {
      throw Exception("Something went wrong. Try again later.");
    }
  }

  @override
  Future<List<Map<String, String>>> getMovieSimilar(int id, int page) async {
    http.Response response =
        await client.get(ApiRequestBuilder.getMovieSimilarUrl(id, page));
    if (response.statusCode == 200) {
      return mapper.parseSimilarList(response.body);
    } else {
      throw Exception("Something went wrong. Try again later.");
    }
  }
}
