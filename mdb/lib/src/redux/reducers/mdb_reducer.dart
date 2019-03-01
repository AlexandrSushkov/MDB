import 'package:mdb/src/redux/mdb_state.dart';
import 'package:mdb/src/redux/reducers/loading_reducer.dart';
import 'package:mdb/src/redux/reducers/movies_response_reducer.dart';

MdbState mdbReducer(MdbState state, action) {
  return MdbState(isLoading: loadingReducer(state.isLoading, action), movieListResponse: movieListResponseReducer(state.movieListResponse, action));
}
