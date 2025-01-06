import 'package:mvvmproject/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';




const String PREFS_KEY_LANGUAGE = 'PREFS_KEY_LANGUAGE';
class AppPreferences{
  SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);

  Future<String> getLanguage() async {

    String? language = _sharedPreferences.getString(PREFS_KEY_LANGUAGE);
    return language ?? LanguageType.English.getValue();
  }
}