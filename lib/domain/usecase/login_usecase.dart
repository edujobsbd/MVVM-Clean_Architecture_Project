import 'package:mvvmproject/data/network/faliure.dart';
import 'package:dartz/dartz.dart';
import 'package:mvvmproject/domain/model/model.dart';
import 'package:mvvmproject/domain/repository/repository.dart';
import 'package:mvvmproject/domain/usecase/base_usecase.dart';

import '../../app/functionosl.dart';
import '../../data/request/request.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  Repository _repository;
  LoginUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(LoginUseCaseInput input) async{

    DeviceInfo deviceInfo = await getDeviceInfo();


    return await _repository.login(LoginRequest(email:input.email,password: input.password, deviceType: deviceInfo.identifier , imei: deviceInfo.name));
  }
 
}

class LoginUseCaseInput {
  final String email;
  final String password;

  LoginUseCaseInput(this.email, this.password);
}