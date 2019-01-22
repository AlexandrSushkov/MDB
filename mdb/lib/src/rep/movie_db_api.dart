import '../models/movie.dart';
import 'movie_api_mapper.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

abstract class IMovieApi {
  Future<Movie> getMovie(int id);
}

class MovieApi implements IMovieApi {
  MovieApi({this.mapper});

  final IMovieApiMapper mapper;

  @override
  Future<Movie> getMovie(int id) async {
    http.Response response = await http.get(
        "https://api.themoviedb.org/3/movie/$id?api_key=1");
    if (response.statusCode == 200) {
      return mapper.responseToMovie(response.body);
    } else {
      throw Exception("Something went wrong. Try again later.");
    }
  }
}
