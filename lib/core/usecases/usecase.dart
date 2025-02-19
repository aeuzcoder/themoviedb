import 'package:dartz/dartz.dart';
import 'package:themoviedb/core/error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call({required Params params});
}
