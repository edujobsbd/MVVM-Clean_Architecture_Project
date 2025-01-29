import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:mvvmproject/app/app_prefs.dart';
import 'package:mvvmproject/data/data_sources/remote_data_source.dart';
import 'package:mvvmproject/data/network/app_api.dart';
import 'package:mvvmproject/data/network/dio_factory.dart';
import 'package:mvvmproject/data/network/network_info.dart';
import 'package:mvvmproject/data/repository/repository_impl.dart';
import 'package:mvvmproject/domain/repository/repository.dart';
import 'package:mvvmproject/domain/usecase/login_usecase.dart';
import 'package:mvvmproject/presentation/login/login_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  //app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  //network info instance
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(DataConnectionChecker()));

  //dioFactory info
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  // app services client

  final dio = await instance<DioFactory>().gerDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  //remoteData source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance()));

  //Repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));
  instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));


}

initLoginModule() {
  if(!GetIt.I.isRegistered<LoginViewModel>()){
    
  instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));

  instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}
