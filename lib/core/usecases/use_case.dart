import 'package:blog_app/core/exceptions/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<T, S> {
  Future<Either<Failure, T>> call(S params);
}

class NoParams {}
