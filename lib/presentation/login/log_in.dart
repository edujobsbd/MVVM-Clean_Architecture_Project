import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvvmproject/presentation/login/login_viewmodel.dart';
import 'package:mvvmproject/presentation/resources/assets_manager.dart';
import 'package:mvvmproject/presentation/resources/value_manager.dart';
import 'package:mvvmproject/presentation/string_manager.dart';

import '../resources/color_manager.dart';

class LogInView extends StatefulWidget {
  const LogInView({Key? key}) : super(key: key);

  @override
  _LogInViewState createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  LoginViewModel _loginViewModel = LoginViewModel(null);

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _bind() {
    _loginViewModel.start();
    _userNameController.addListener(() {
      _loginViewModel.setUserName(_userNameController.text);
    });
    _passwordController.addListener(() {
      _loginViewModel.setPassword(_passwordController.text);
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getContent();
  }

  Widget _getContent() {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: AppPadding.p100),
        color: ColorManager.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image(
                  image: AssetImage(ImageAssets.splashLogo),
                ),
                SizedBox(
                  height: AppSize.as28,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _loginViewModel.outputIsPasswordValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        controller: _userNameController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: AppString.userName,
                          labelText: AppString.userName,
                          errorText: (snapshot.data ?? true)
                              ? null
                              : AppString.userNameError,
                        ),
                      );
                    },
                  ),
                ), //will be replaced with only left and right padding
                SizedBox(
                  height: AppSize.as28,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _loginViewModel.outputIsPasswordValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          hintText: AppString.password,
                          errorText: (snapshot.data ?? true)
                              ? null
                              : AppString.passwordError,
                          labelText: AppString.passwordError,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: AppSize.as28,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: StreamBuilder<bool>(
                      stream:
                          _loginViewModel.outputIsAllValid, //todo add stream
                      builder: (context, snapshot) {
                        return ElevatedButton(
                          onPressed: (snapshot.data ?? false)
                              ? () {
                                  _loginViewModel.login();
                                }
                              : null,
                          child: Text(AppString.login),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loginViewModel.dispose();
    super.dispose();
  }
}
