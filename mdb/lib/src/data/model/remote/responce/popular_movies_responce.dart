import 'package:mdb/src/data/model/local/movie.dart';

class PopularMoviesResponse {
  int _page;
  int _total_results;
  int _total_pages;
  List<Movie> _movies = [];

  PopularMoviesResponse.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['results'].length);
    _page = parsedJson['page'];
    _total_results = parsedJson['total_results'];
    _total_pages = parsedJson['total_pages'];
    List<Movie> temp = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      Movie result = Movie(parsedJson['results'][i]);
      temp.add(result);
    }
    _movies = temp;
  }

  List<Movie> get movies => _movies;

  int get total_pages => _total_pages;

  int get total_results => _total_results;

  int get page => _page;
}