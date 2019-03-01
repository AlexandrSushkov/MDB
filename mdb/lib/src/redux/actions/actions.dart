import 'package:mdb/src/data/model/remote/responce/movie_list_response.dart';

class LoadMoviesAction {}

class MoviesNotLoadedAction {}

class MoviesLoadedAction {
  final MovieListResponse movieResponse;

  MoviesLoadedAction(this.movieResponse);

  @override
  String toString() {
    return 'MoviesLoadedAction{movie response: $movieResponse}';
  }
}