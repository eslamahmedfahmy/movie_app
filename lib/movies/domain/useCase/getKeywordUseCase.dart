import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/usecases/base_usecase.dart';
import 'package:movie_app/movies/domain/entities/keywords.dart';
import 'package:movie_app/movies/domain/repository/base_movie_repo.dart';

class GetKeywordsUseCase extends BaseUseCase<Keywords,int>{
  final BaseMovieRepository baseMovieRepository;

  GetKeywordsUseCase(this.baseMovieRepository);

  @override
  Future<Either<Failure, Keywords>> call(int parameters)async {
    return await baseMovieRepository.getKeywords(parameters);
  }
}