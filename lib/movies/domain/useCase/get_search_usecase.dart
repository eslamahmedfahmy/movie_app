import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/usecases/base_usecase.dart';
import 'package:movie_app/movies/domain/entities/movie.dart';
import 'package:movie_app/movies/domain/repository/base_movie_repo.dart';

class GetSearchUseCase extends BaseUseCase<List<Movie>,SearchParameters>{
  final BaseMovieRepository baseMovieRepository;

  GetSearchUseCase(this.baseMovieRepository);

  @override
  Future<Either<Failure, List<Movie>>> call(SearchParameters parameters)async {
    return await baseMovieRepository.getSearchMovie(parameters);
  }

}

class SearchParameters extends Equatable{
  final String searchItem;

  const SearchParameters({required this.searchItem});

  @override
  // TODO: implement props
  List<Object?> get props => [searchItem];
}