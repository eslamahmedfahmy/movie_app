import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/usecases/base_usecase.dart';
import 'package:movie_app/movies/domain/entities/recommendations.dart';
import 'package:movie_app/movies/domain/repository/base_movie_repo.dart';

class GetMovieRecommendationUseCase extends BaseUseCase<List<Recommendations>,MovieRecommendationParameters>{
  final BaseMovieRepository baseMovieRepository;

  GetMovieRecommendationUseCase(this.baseMovieRepository);

  @override
  Future<Either<Failure, List<Recommendations>>> call(MovieRecommendationParameters parameters) async{
    return await baseMovieRepository.getRecommendationMovie(parameters);
  }

}

class MovieRecommendationParameters extends Equatable{
  final int movieId;

  const MovieRecommendationParameters({required this.movieId});

  @override
  // TODO: implement props
  List<Object?> get props => [movieId];
}