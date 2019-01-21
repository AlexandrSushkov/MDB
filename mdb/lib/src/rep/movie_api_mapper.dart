import '../models/movie.dart';
import 'dart:convert';

abstract class IMovieApiMapper {
  Movie responseToMovie(String response);
}

class MovieApiMapper implements IMovieApiMapper {
  @override
  Movie responseToMovie(String response) {
    var r = json.decode(response);
    Movie m = Movie();
    m.title = r['original_title'];
    m.overview = r['overview'];
    return m;
  }
}