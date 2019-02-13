import 'package:json_annotation/json_annotation.dart';
import 'package:mdb/src/data/model/local/movie.dart';
import 'package:mdb/src/utils/constants.dart';

part 'movie_list_response.g.dart';

@JsonSerializable()
class MovieListResponse {
  MovieListResponse(this.page, this.totalResults, this.totalPages, this.movies);

  int page;
  @JsonKey(name: totalResultsKey)
  int totalResults;
  @JsonKey(name: totalPagesKey)
  int totalPages;
  @JsonKey(name: resultsKey)
  List<Movie> movies;

  factory MovieListResponse.fromJson(Map<String, dynamic> json) => _$MovieListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieListResponseToJson(this);
}

