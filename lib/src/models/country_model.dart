import 'package:bottleshopdeliveryapp/src/models/localized_model.dart';
import 'package:flutter/material.dart';

@immutable
class CountryModel {
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

  CountryModel.fromJson(Map<String, dynamic> json, String id)
      : id = id,
        name = json[nameField],
        region = json[regionField],
        flagUrl = json[flagField],
        localizedName = json[localizedNameField] != null
            ? LocalizedModel.fromJson(json[localizedNameField])
            : null,
        localizedRegion = json[localizedRegionField] != null
            ? LocalizedModel.fromJson(json[localizedRegionField])
            : null;

  @override
  bool operator ==(other) =>
      other is CountryModel &&
      other.id == id &&
      other.name == name &&
      other.flagUrl == flagUrl &&
      other.region == region &&
      other.localizedName == localizedName &&
      other.localizedRegion == localizedRegion;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      flagUrl.hashCode ^
      region.hashCode ^
      localizedName.hashCode ^
      localizedRegion.hashCode;
}
