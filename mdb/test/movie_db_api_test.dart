import 'package:http/http.dart' as http;
import 'package:mdb/mysrc/models/movie.dart';
import 'package:mdb/mysrc/rep/api_request_builder.dart';
import 'package:mdb/mysrc/rep/movie_api_mapper.dart';
import 'package:mdb/mysrc/rep/movie_db_api.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockClient extends Mock implements http.Client {}

class MockMovieApiMapper extends Mock implements IMovieApiMapper {}

void main() {
  group("get movie", () {
    test("01", () async {
      final http.Client client = MockClient();
      final IMovieApiMapper apiMapper = MockMovieApiMapper();
      const TypeMatcher<Movie> matcher = TypeMatcher();
      final IMovieApi dbApi = MovieApi(mapper: apiMapper, client: client);
      final String response = '{"original_title":"Fight Club"}';
      when(client.get(ApiRequestBuilder.getMovieUrl(123)))
          .thenAnswer((_) async => http.Response(response, 200));
      when(apiMapper.parseMovie(response)).thenReturn(Movie());
      expect(await dbApi.getMovie(123), matcher);
    });

    test("02", () {
      final http.Client client = MockClient();
      final IMovieApiMapper apiMapper = MockMovieApiMapper();
      final IMovieApi dbApi = MovieApi(mapper: apiMapper, client: client);
      final String response = 'Not found';
      when(client.get(ApiRequestBuilder.getMovieUrl(123)))
          .thenAnswer((_) async => http.Response(response, 404));
      expect(dbApi.getMovie(123), throwsException);
    });
  });
}
