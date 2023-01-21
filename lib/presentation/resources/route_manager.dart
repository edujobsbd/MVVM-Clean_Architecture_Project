import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvmproject/presentation/splash/splash.dart';
import 'package:mvvmproject/presentation/string_manager.dart';

import '../forgot_password/forgot_password.dart';
import '../login/log_in.dart';
import '../main/main.dart';
import '../on_boarding/on_boarding.dart';
import '../register/register.dart';
import '../store_details/store_details.dart';

class Routes {
  static const String splashRoute = '/';
  static const String onBoardingRoute = '/onboarding';
  static const String logInRoute = '/login';
  static const String registrationRoute = '/registration';
  static const String forgetPasswordRoute = '/forgetPassword';
  static const String mainRoute = '/main';
  static const String detailsRoute = '/details';
}

class RouteGenerator {
  static Route<dynamic>? getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => OnBoardingView());
      case Routes.logInRoute:
        return MaterialPageRoute(builder: (_) => LogInView());
      case Routes.registrationRoute:
        return MaterialPageRoute(builder: (_) => RegisterView());
      case Routes.forgetPasswordRoute:
        return MaterialPageRoute(builder: (_) => ForgotPasswordView());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => MainView());
      case Routes.detailsRoute:
        return MaterialPageRoute(builder: (_) => StoreDetailsView());
      default:
        unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text(AppString.noRouteFound),
              ),
              body: const Center(
                child: Text(AppString.noRouteFound),
              ),
            ));
  }
}
