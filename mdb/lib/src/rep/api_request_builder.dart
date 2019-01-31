import '../resource/resource.dart';

class ApiRequestBuilder {
  static String getMovieUrl(int id) {
    return "https://api.themoviedb.org/3/movie/$id?api_key=" + API_KEY;
  }

  static String getMovieImagesUrl(int id) {
    return "https://api.themoviedb.org/3/movie/$id/images?api_key=" + API_KEY;
  }

  static String getMovieCastUrl(int id) {
    return "https://api.themoviedb.org/3/movie/$id/credits?api_key=" + API_KEY;
  }

  static String getMovieSimilarUrl(int id, int page) {
    return "https://api.themoviedb.org/3/movie/$id/similar?api_key=" +
        API_KEY +
        "&page=" +
        page.toString();
  }
}
