import '../data/mapper/mapper.dart';

extension NonNullString on String? {
  String get nonNull => this ?? emptyString;
}

extension NonNullInt on int? {
  int get nonNull => this ?? emptyInt;
}