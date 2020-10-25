import 'package:bottleshopdeliveryapp/src/core/data/models/localized_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class UnitModel extends Equatable {
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

  UnitModel.fromMap(String id, Map<String, dynamic> data)
      : id = id,
        abbreviation = data[abbreviationField],
        unit = data[unitField],
        localizedAbbreviation =
            LocalizedModel.fromMap(data[localizedAbbreviationField]),
        localizedUnit = LocalizedModel.fromMap(data[localizedUnitField]);

  @override
  List<Object> get props {
    return [
      id,
      abbreviation,
      unit,
    ];
  }
}
