import 'package:bottleshopdeliveryapp/src/core/data/models/localized_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class CountryModel extends Equatable {
  static const String nameField = 'name';
  static const String flagField = 'flag';
  static const String regionField = 'region';
  static const String localizedNameField = 'localizedName';
  static const String localizedRegionField = 'localizedRegion';

  final String id;
  final String name;
  final String flagUrl;
  final String region;
  final LocalizedModel localizedName;
  final LocalizedModel localizedRegion;

  CountryModel({
    @required this.id,
    @required this.flagUrl,
    @required this.region,
    @required this.localizedRegion,
    @required this.localizedName,
    @required this.name,
  });

  CountryModel.fromMap(String id, Map<String, dynamic> data)
      : id = id,
        name = data[nameField],
        region = data[regionField],
        flagUrl = data[flagField],
        localizedName = data[localizedNameField] != null
            ? LocalizedModel.fromMap(data[localizedNameField])
            : null,
        localizedRegion = data[localizedRegionField] != null
            ? LocalizedModel.fromMap(data[localizedRegionField])
            : null;

  @override
  List<Object> get props {
    return [id, name, region];
  }

  @override
  bool get stringify => true;
}
