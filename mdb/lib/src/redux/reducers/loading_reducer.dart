import 'package:mdb/src/redux/actions/actions.dart';
import 'package:redux/redux.dart';

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, MoviesLoadedAction>(_setLoaded),
  TypedReducer<bool, MoviesNotLoadedAction>(_setLoaded),
]);

bool _setLoaded(bool state, action) {
  return false;
}