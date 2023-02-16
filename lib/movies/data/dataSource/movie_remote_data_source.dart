import 'package:dio/dio.dart';
import 'package:movie_app/core/error/exceptions.dart';
import 'package:movie_app/core/network/api_constance.dart';
import 'package:movie_app/core/network/error_message_model.dart';
import 'package:movie_app/movies/data/models/movie_details_model.dart';
import 'package:movie_app/movies/data/models/movie_model.dart';
import 'package:movie_app/movies/data/models/movie_recommendation.dart';
import 'package:movie_app/movies/data/models/video_model.dart';
import 'package:movie_app/movies/domain/entities/keywords.dart';
import 'package:movie_app/movies/domain/useCase/get_movie_details_useCase.dart';
import 'package:movie_app/movies/domain/useCase/get_movie_recommendation_useCase.dart';
import 'package:movie_app/movies/domain/useCase/get_movie_video_usecase.dart';
import 'package:movie_app/movies/domain/useCase/get_search_usecase.dart';

abstract class BaseMovieRemoteDataSource{
  Future<List<MovieModel>>getNowPlayingMovies();
  Future<List<MovieModel>>getTopRatedMovies();
  Future<List<MovieModel>>getPopularMovies();
  Future<List<MovieModel>>getUpcomingMovies();

  Future<MovieDetailsModel>getMovieDetails(MovieDetailsParameters parameters);

  Future<List<MovieRecommendationModel>>getMovieRecommendation(MovieRecommendationParameters parameters);

  Future<List<MovieModel>>getSearchMovies(SearchParameters searchParameters);
  Future<List<VideoModel>>getMovieVideo(VideoParameters movieId);

  Future<Keywords>getKeyword(int movieId);

}

class MovieRemoteDataSource extends BaseMovieRemoteDataSource{

  @override
  Future<List<MovieModel>>getNowPlayingMovies()async{
    final response=await Dio().get(
      ApiConstance.nowPlayingMoviesPath,

    );

    if(response.statusCode==200){
      return List<MovieModel>.from((response.data["results"]as List).map((e) => MovieModel.fromJson(e)));
    }
    else{
      throw ServerException(
          errorMessageModel:ErrorMessageModel.fromJson(response.data)
      );
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies()async {
    final response=await Dio().get(ApiConstance.topRatedMoviesPath);
    if(response.statusCode==200){
      return List<MovieModel>.from((response.data["results"]as List).map((e) =>MovieModel.fromJson(e)));
    }
    else{
      throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies()async {
    final response=await Dio().get(ApiConstance.popularMoviesPath);
    if(response.statusCode==200){
      return List<MovieModel>.from((response.data["results"]as List).map((e) =>MovieModel.fromJson(e)));
    }
    else{
      throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<MovieDetailsModel> getMovieDetails(MovieDetailsParameters parameters) async{
    final response=await Dio().get(ApiConstance.movieDetailsPath(parameters.movieId));
    if(response.statusCode==200){
      return MovieDetailsModel.fromJson(response.data);
    }
    else{
      throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<MovieRecommendationModel>> getMovieRecommendation(MovieRecommendationParameters parameters)async {
    final response=await Dio().get(ApiConstance.movieRecommendationPath(parameters.movieId),);
    if(response.statusCode==200)
    {

      return List<MovieRecommendationModel>.from((response.data["results"]as List).map((e) =>MovieRecommendationModel.fromJson(e)));

    }
    else{
      throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<MovieModel>> getUpcomingMovies()async {
    final response=await Dio().get(ApiConstance.upcomingMoviesPath);
    if(response.statusCode==200){
      return List<MovieModel>.from((response.data["results"]as List).map((e) =>MovieModel.fromJson(e)));
    }
    else{
      throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<VideoModel>> getMovieVideo(VideoParameters movieId) async{
    final response=await Dio().get(ApiConstance.videoPath(movieId.movieId),);
    if(response.statusCode==200)
    {

      return List<VideoModel>.from((response.data["results"]as List).map((e) =>VideoModel.fromJson(e)));

    }
    else{
      throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<MovieModel>> getSearchMovies(SearchParameters searchParameters)async {
    final response=await Dio().get(
      getPath(
          "search/movie",
          params: {
            'query':searchParameters.searchItem,
          }
      ),
    );
    if(response.statusCode==200)
    {
      print("Dio="+response.data);
      return List<MovieModel>.from((response.data["results"]as List).map((e) =>MovieModel.fromJson(e)));
    }
    else{
      throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<Keywords> getKeyword(int movieId)async {
    final response=await Dio().get("https://api.themoviedb.org/3/movie/$movieId/keywords?api_key=9c00afb9f04821fd4a07c79391873866");
    if(response.statusCode==200){
      return Keywords.fromJson(response.data);
    }
    else{
      throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }



}
String getPath( String path,{required Map<String, dynamic> params}){
  var paramsString='';
  if(params.isNotEmpty){
    params.forEach((key, value) {
      paramsString+='&$key=$value';
    });
  }
  return "${ApiConstance.baseUrl}$path?api_key=${ApiConstance.apiKey}${paramsString}";
}