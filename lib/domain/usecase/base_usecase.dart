import 'package:dartz/dartz.dart';

import '../../data/network/faliure.dart';

abstract class BaseUseCase<In,Out> {
  Future<Either<Failure,Out>> execute(In input);
}