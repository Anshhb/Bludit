import 'package:fpdart/fpdart.dart';
import 'package:redd_clone/core/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;