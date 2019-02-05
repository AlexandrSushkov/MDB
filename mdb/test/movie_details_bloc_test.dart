import 'package:mdb/mysrc/models/movie.dart';
import 'package:mdb/mysrc/rep/movie_db_api.dart';
import 'package:mdb/mysrc/ui/movie_details/movie_details_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockMovieApi extends Mock implements IMovieApi {}

void main() {
  group("bloc", () {
    IMovieApi api;
    MovieDetailsBloc bloc;
    setUp(() {
      api = MockMovieApi();
      bloc = MovieDetailsBloc(api: api);
    });
    test("01", () {
      Movie m = Movie();
      when(api.getMovie(123)).thenAnswer((_) async => m);
      bloc.loadDetails(123);
      expect(bloc.getDetailsStream(), emits(m));
    });
    test("02", () {
      expectLater(bloc.getDetailsStream(), emitsInOrder([]));
      bloc.dispose();
    });
    test("03", () {
      when(api.getMovie(123)).thenThrow("error");
      bloc.loadDetails(123);
      expect(bloc.getDetailsStream(), emitsError("error"));
    });
    test("04", () {});
  });
}
