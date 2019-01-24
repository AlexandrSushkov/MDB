import '../models/movie.dart';
import 'movie_api_mapper.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../resource/resource.dart';

abstract class IMovieApi {
  Future<Movie> getMovie(int id);

  Future<List<String>> getMovieImages(int id);

  Future<List<Map<String, String>>> getMovieCast(int id);

  Future<List<Map<String, String>>> getMovieSimilar(int id);
}

class MovieApi implements IMovieApi {
  MovieApi({this.mapper});

  final IMovieApiMapper mapper;

  @override
  Future<Movie> getMovie(int id) async {
    http.Response response = await http
        .get("https://api.themoviedb.org/3/movie/$id?api_key=" + API_KEY);
    if (response.statusCode == 200) {
      return mapper.parseMovie(response.body);
    } else {
      throw Exception("Something went wrong. Try again later.");
    }
  }

  @override
  Future<List<String>> getMovieImages(int id) async {
    http.Response response = await http.get(
        "https://api.themoviedb.org/3/movie/$id/images?api_key=" + API_KEY);
    if (response.statusCode == 200) {
      return mapper.parseImagesList(response.body);
    } else {
      throw Exception("Something went wrong. Try again later.");
    }
  }

  @override
  Future<List<Map<String, String>>> getMovieCast(int id) async {
    http.Response response = await http.get(
        "https://api.themoviedb.org/3/movie/$id/credits?api_key=" + API_KEY);
    if (response.statusCode == 200) {
      return mapper.parseCastList(response.body);
    } else {
      throw Exception("Something went wrong. Try again later.");
    }
  }

  @override
  Future<List<Map<String, String>>> getMovieSimilar(int id) async {
    http.Response response = await http.get(
        "https://api.themoviedb.org/3/movie/$id/similar?api_key=" + API_KEY);
    if (response.statusCode == 200) {
      return mapper.parseSimilarList(response.body);
    } else {
      throw Exception("Something went wrong. Try again later.");
    }
  }
}
