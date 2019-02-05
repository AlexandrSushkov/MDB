
//Api
const String baseUrl = 'http://api.themoviedb.org/3/';
const String theMovieDBApiKey = '3d0d567b896c722ab267ed068e5cf805';

//endpoint
const String popularMovies = 'movie/popular';
const String genres = 'genre/movie/list';
const String discover = 'discover/movie';

//query parameters
const String apiKey = 'api_key';
const String withGenres = 'with_genres';

//json response keys
const String voteCountKey = 'vote_count';
const String voteAverageKey = 'vote_average';
const String posterPathKey = 'poster_path';
const String originalLanguageKey = 'original_language';
const String originalTitleKey = 'original_title';
const String genreIdsKey = 'genre_ids';
const String backdropPathKey = 'backdrop_path';
const String releaseDateKey = 'release_date';
const String totalResultsKey = 'total_results';
const String totalPagesKey = 'total_pages';
const String resultsKey = 'results';

//image size prefix
const String imageBaseUrl= 'https://image.tmdb.org/t/p/';
const String imageSizePrefixSmall = 'w185';
const String imageSizePrefixNormal = 'w300';
const String imageSizePrefixLarge = 'w600_and_h900_bestv2';
const String imageSizePrefixVeryLarge = 'w1280';
