import '../models/movie.dart';
import 'dart:convert';

abstract class IMovieApiMapper {
  Movie parseMovie(String response);

  List<String> parseImagesList(String response);

  List<Map<String, String>> parseCastList(String response);

  List<Map<String, String>> parseSimilarList(String response);
}

class MovieApiMapper implements IMovieApiMapper {
  @override
  Movie parseMovie(String response) {
    var r = json.decode(response);
    Movie m = Movie();
    m.title = r['original_title'];
    m.overview = r['overview'];
    m.posterPath = r['poster_path'];
    m.releaseDate = DateTime.parse(r['release_date']);
    m.tagLine = r['tagline'];
    m.revenue = r['revenue'];
    m.runtime = r['runtime'];
    for (var value in r['genres']) {
      m.genres.add(value['name']);
    }
    for (var value in r['production_countries']) {
      m.countries.add(value['name']);
    }
    return m;
  }

  @override
  List<Map<String, String>> parseCastList(String response) {
    var r = json.decode(response);
    List<Map<String, String>> res = [];
    for (var value in r['cast']) {
      res.add({'name': value['name'], 'photo': value['profile_path']});
    }
    return res;
  }

  @override
  List<Map<String, String>> parseSimilarList(String response) {
    var r = json.decode(response);
    List<Map<String, String>> res = [];
    for (var value in r['results']) {
      res.add({'title': value['original_title'], 'poster': value['poster_path']});
    }
    return res;
  }

  @override
  List<String> parseImagesList(String response) {
    var r = json.decode(response);
    List<String> res = [];
    for (var value in r['posters']) {
      res.add(value['file_path']);
    }
    return res;
  }
}
