import 'package:bottleshopdeliveryapp/src/models/new/localized_model.dart';
import 'package:flutter/material.dart';

@immutable
class UnitModel {
  static const String abbreviationField = 'abbreviation';
  static const String unitField = 'unit';
  static const String localizedAbbreviationField = 'localized_abbreviation';
  static const String localizedUnitField = 'localized_unit';

  final String id;
  final String abbreviation;
  final String unit;
  final LocalizedModel localizedAbbreviation;
  final LocalizedModel localizedUnit;

  UnitModel({
    @required this.id,
    @required this.abbreviation,
    @required this.unit,
    @required this.localizedAbbreviation,
    @required this.localizedUnit,
  });

  UnitModel.fromJson(Map<String, dynamic> json, String id)
      : id = id,
        abbreviation = json[abbreviationField],
        unit = json[unitField],
        localizedAbbreviation =
            LocalizedModel.fromJson(json[localizedAbbreviationField]),
        localizedUnit = LocalizedModel.fromJson(json[localizedUnitField]);

  @override
  bool operator ==(other) =>
      other is UnitModel &&
      other.id == id &&
      other.abbreviation == abbreviation &&
      other.unit == unit &&
      other.localizedAbbreviation == localizedAbbreviation &&
      other.localizedUnit == localizedUnit;

  @override
  int get hashCode =>
      id.hashCode ^
      abbreviation.hashCode ^
      unit.hashCode ^
      localizedAbbreviation.hashCode ^
      localizedUnit.hashCode;
}
