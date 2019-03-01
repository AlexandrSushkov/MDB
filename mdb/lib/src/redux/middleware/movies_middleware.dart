import 'package:mdb/src/data/repository/movie_repository.dart';
import 'package:mdb/src/data/repository/repository_factory.dart';
import 'package:mdb/src/redux/actions/actions.dart';
import 'package:mdb/src/redux/mdb_state.dart';
import 'package:redux/redux.dart';


List<Middleware<MdbState>> moviesMiddleware() {
  final movieRepository = RepositoryFactory.provide<MovieRepository>();

  return [
    TypedMiddleware<MdbState, LoadMoviesAction>(_loadMovies(movieRepository)),
  ];
}

Middleware<MdbState> _loadMovies(MovieRepository movieRepository) {
  return (Store<MdbState> store, action, NextDispatcher next) {
    movieRepository.fetchPopularMovies().then((moviesResponse) {
      store.dispatch(MoviesLoadedAction(moviesResponse));
    }).catchError((_) => store.dispatch(MoviesNotLoadedAction()));
    next(action);
  };
}
