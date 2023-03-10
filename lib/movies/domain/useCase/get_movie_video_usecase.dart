import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/usecases/base_usecase.dart';
import 'package:movie_app/movies/domain/entities/video.dart';
import 'package:movie_app/movies/domain/repository/base_movie_repo.dart';

class GetMovieVideoUseCase extends BaseUseCase<List<Videos>,VideoParameters>{
  final BaseMovieRepository baseMovieRepository;

  GetMovieVideoUseCase(this.baseMovieRepository);

  @override
  Future<Either<Failure, List<Videos>>> call(VideoParameters parameters) async{
    return await baseMovieRepository.getMovieVideo(parameters);
  }

}
class VideoParameters extends Equatable{
  final int movieId;

  const VideoParameters({required this.movieId});

  @override
  // TODO: implement props
  List<Object?> get props => [movieId];
}