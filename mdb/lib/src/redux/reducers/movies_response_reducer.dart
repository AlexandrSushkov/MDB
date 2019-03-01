import 'package:mdb/src/data/model/remote/responce/movie_list_response.dart';
import 'package:mdb/src/redux/actions/actions.dart';
import 'package:redux/redux.dart';

final movieListResponseReducer = combineReducers<MovieListResponse>([
  TypedReducer<MovieListResponse, MoviesLoadedAction>(_setLoadedMoviesResponse),
]);

MovieListResponse _setLoadedMoviesResponse(MovieListResponse movieListResponse, MoviesLoadedAction action) {
  return action.movieResponse;
}
