enum LanguageType { English, Bengali }

const String English = 'en';
const String Bengali = 'bn';

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.English:
        return Bengali;
      case LanguageType.Bengali:
        return English;
    }
  }
}
