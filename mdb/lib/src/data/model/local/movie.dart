import 'package:json_annotation/json_annotation.dart';
import 'package:mdb/src/util/constants.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  Movie(this.voteCount, this.id, this.video, this.voteAverage, this.title, this.popularity, this.posterPath, this.originalLanguage, this.originalTitle,
      this.genreIds, this.backdropPath, this.adult, this.overview, this.releaseDate);

  @JsonKey(name: voteCountKey)
  int voteCount;
  int id;
  bool video;
  @JsonKey(name: voteAverageKey)
  var voteAverage;
  String title;
  double popularity;
  @JsonKey(name: posterPathKey)
  String posterPath;
  @JsonKey(name: originalLanguageKey)
  String originalLanguage;
  @JsonKey(name: originalTitleKey)
  String originalTitle;
  @JsonKey(name: genreIdsKey)
  List<int> genreIds = [];
  @JsonKey(name: backdropPathKey)
  String backdropPath;
  bool adult;
  String overview;
  @JsonKey(name: releaseDateKey)
  String releaseDate;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
