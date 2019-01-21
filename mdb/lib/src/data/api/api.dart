import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:mdb/src/data/model/remote/responce/popular_movies_responce.dart';
import 'dart:convert';

import 'package:mdb/src/utils/constants.dart';

class Api {
  Client client = Client();

  Future<PopularMoviesResponse> fetchPopularMovies() async {
    print("entered");
    final response = await client.get(popularMovies);
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return PopularMoviesResponse.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
