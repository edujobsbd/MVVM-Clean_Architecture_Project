import 'package:dartz/dartz.dart';
import 'package:mvvmproject/domain/model/model.dart';

import '../../data/network/faliure.dart';
import '../../data/request/request.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
}
