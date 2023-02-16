import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/movies/domain/entities/keywords.dart';
import 'package:movie_app/movies/domain/entities/movie.dart';
import 'package:movie_app/movies/domain/entities/movie_details.dart';
import 'package:movie_app/movies/domain/entities/recommendations.dart';
import 'package:movie_app/movies/domain/entities/video.dart';
import 'package:movie_app/movies/domain/useCase/get_movie_details_useCase.dart';
import 'package:movie_app/movies/domain/useCase/get_movie_recommendation_useCase.dart';
import 'package:movie_app/movies/domain/useCase/get_movie_video_usecase.dart';
import 'package:movie_app/movies/domain/useCase/get_search_usecase.dart';

abstract class BaseMovieRepository{

  Future<Either<Failure,List<Movie>>>getNowPlayingMovies();
  Future<Either<Failure,List<Movie>>>getTopRatedMovies();
  Future<Either<Failure,List<Movie>>>getPopularMovies();
  Future<Either<Failure,List<Movie>>>getUpcomingMovie();

  Future<Either<Failure,MovieDetial>>getMovieDetails(MovieDetailsParameters parameters);

  Future<Either<Failure,List<Recommendations>>>getRecommendationMovie(MovieRecommendationParameters parameters);

  // Future<Either<Failure,List<Movie>>>getSearchMovie(SearchParameters searchParameters);
  Future<Either<Failure,List<Movie>>>getSearchMovie(SearchParameters parameters);

  Future<Either<Failure,List<Videos>>>getMovieVideo(VideoParameters movieId);

  Future<Either<Failure,Keywords>>getKeywords(int movieId);
}