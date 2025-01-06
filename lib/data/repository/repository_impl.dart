import 'package:dartz/dartz.dart';
import 'package:mvvmproject/data/data_sources/remote_data_source.dart';
import 'package:mvvmproject/data/mapper/mapper.dart';
import 'package:mvvmproject/data/network/error_handler.dart';
import 'package:mvvmproject/data/network/network_info.dart';

import '../../domain/model/model.dart';
import '../../domain/repository/repository.dart';
import '../network/faliure.dart';
import '../request/request.dart';

class RepositoryImpl extends Repository {
  RemoteDataSource _remoteDataSource;
  NetworkInfo _networkInfo;
  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(
              code: response.status??ApiInternalStatus.FAILURE,
              message:
                  response.message ?? ResponsesMessages.UNKNOWN));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return network failure
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());  //response.message ?? 'we are facing some issue from API' also can be added
    }
  }
}
