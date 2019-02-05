import 'package:json_annotation/json_annotation.dart';
import 'package:mdb/mysrc/data/model/local/movie.dart';

//part 'package:mdb/mysrc/data/model/remote/responce/popular_movies_responce.g.dart';

@JsonSerializable()
class PopularMoviesResponse {
  int page;
  int total_results;
  int total_pages;
  List<Movie> movies = [];

  PopularMoviesResponse();
//  PopularMoviesResponse(this.page, this.total_results, this.total_pages, this.movies);

//  factory PopularMoviesResponse.fromJson(Map<String, dynamic> json) => _$PopularMoviesResponseFromJson(json);
//
//  Map<String, dynamic> toJson() => _$PopularMoviesResponseToJson(this);

}
