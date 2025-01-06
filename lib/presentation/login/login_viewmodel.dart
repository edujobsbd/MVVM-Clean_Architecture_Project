import 'dart:async';

import 'package:mvvmproject/domain/usecase/login_usecase.dart';
import 'package:mvvmproject/presentation/common/freezed_data.dart';

import '../base/base_viewmodel.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  StreamController _isAllInputDataIsValidController =
      StreamController<void>.broadcast();
  var loginObject = LoginObject("", "");

  LoginUseCase? _loginUseCase; //todo remove null?
  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    _userNameStreamController.close();
    _isAllInputDataIsValidController.close();
    _passwordStreamController.close();
  }

  @override
  void start() {}

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputIsAllValid => _isAllInputDataIsValidController.sink;

  @override
  login() async {
    // (await _loginUseCase.execute(
    //   LoginUseCaseInput(loginObject.userName, loginObject.password),
    // ))
    //     .fold(
    //   (Failure) {
    //     print(Failure.message);
    //   },
    //   (data) {
    //     print(data.customer.name);
    //   },
    // );
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
  _isAllInputDataIsValidController.add(null);
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
    _isAllInputDataIsValidController.add(null);
  }

  @override
  // TODO: implement outputIsAllValid
  Stream<bool> get outputIsAllValid =>
      _isAllInputDataIsValidController.stream.map((_) => _isAllDataIsValid());

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  bool _isAllDataIsValid() {
   return _isPasswordValid(loginObject.password) &&
        _isUserNameValid(loginObject.userName);
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }
}

abstract class LoginViewModelInputs {
  //for actions
  setUserName(String userName);
  setPassword(String password);
  login();

  //for sreams
  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputIsAllValid;
}

abstract class LoginViewModelOutputs {
  //for actions
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get outputIsAllValid;
}
