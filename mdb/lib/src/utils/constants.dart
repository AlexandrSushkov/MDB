
const String theMovieDBApiKey = '3d0d567b896c722ab267ed068e5cf805';

//endpoint
const String popularMovies = 'http://api.themoviedb.org/3/movie/popular?api_key=$theMovieDBApiKey';
const String discoverMovies = 'https://api.themoviedb.org/3/discover/movie?api_key=3d0d567b896c722ab267ed068e5cf805&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=16';
const String genres = 'http://api.themoviedb.org/3/genre/movie/list?api_key=$theMovieDBApiKey';

//prefix
const String imagePrefixSmall = 'https://image.tmdb.org/t/p/w185';
//const String imagePrefixLarge = 'https://image.tmdb.org/t/p/w300';
const String imagePrefixLarge = 'https://image.tmdb.org/t/p/w600_and_h900_bestv2';
const String imagePrefixVeryLarge = 'https://image.tmdb.org/t/p/w1280';