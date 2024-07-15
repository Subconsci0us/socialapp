import 'package:fpdart/fpdart.dart';
import 'package:socialapp/core/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;
