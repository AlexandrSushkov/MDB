import 'package:mdb/src/data/model/local/genre.dart';

class GenresResponse{

  List<Genre> _genres;

  GenresResponse.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['genres'].length);
    List<Genre> temp = [];
    for (int i = 0; i < parsedJson['genres'].length; i++) {
      Genre result = Genre(parsedJson['genres'][i]);
      temp.add(result);
    }
    _genres = temp;
  }

  List<Genre> get genres => _genres;

}
