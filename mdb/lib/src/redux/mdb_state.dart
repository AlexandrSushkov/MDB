import 'package:mdb/src/data/model/remote/responce/movie_list_response.dart';
import 'package:meta/meta.dart';

@immutable
class MdbState{

  final bool isLoading;
  final MovieListResponse movieListResponse;

  MdbState({this.isLoading, this.movieListResponse});

  factory MdbState.loading() => MdbState(isLoading: true);


}
