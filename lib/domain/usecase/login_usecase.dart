
import 'package:dartz/dartz.dart';
import 'package:mvvmproject/app/functionosl.dart';

import '../../data/network/faliure.dart';
import '../../data/request/request.dart';
import '../model/model.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      LoginUseCaseInput input) async {
    DeviceInfo deviceInfo = await getDeviceInfo();
    return await _repository.login(LoginRequest(email: input.email,password:
         input.password , imei: deviceInfo.identifier, device_type:deviceInfo.name));
  }
}

class LoginUseCaseInput {
  String email;
  String password;

  LoginUseCaseInput(this.email, this.password);
}