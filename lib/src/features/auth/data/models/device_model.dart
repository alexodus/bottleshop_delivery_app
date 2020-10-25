import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Device extends Equatable {
  final String id;
  final DateTime createdAt;
  final bool expired;
  final bool uninstalled;
  final int lastUpdatedAt;
  final DeviceDetails deviceInfo;
  final String token;

  Device({
    @required this.id,
    this.token,
    this.createdAt,
    this.expired,
    this.uninstalled,
    this.lastUpdatedAt,
    this.deviceInfo,
  }) : assert(id != null);

  Device.fromMap(String id, Map<String, dynamic> data)
      : id = id,
        createdAt = data[DeviceFields.createdAt]?.toDate(),
        expired = data[DeviceFields.expired],
        uninstalled = data[DeviceFields.uninstalled] ?? false,
        lastUpdatedAt = data[DeviceFields.lastUpdatedAt],
        deviceInfo = DeviceDetails.fromJson(data[DeviceFields.deviceInfo]),
        token = data[DeviceFields.token];

  Map<String, dynamic> toMap() {
    return {
      DeviceFields.createdAt: createdAt,
      DeviceFields.deviceInfo: deviceInfo.toJson(),
      DeviceFields.expired: expired,
      DeviceFields.uninstalled: uninstalled,
      DeviceFields.lastUpdatedAt: lastUpdatedAt,
      DeviceFields.token: token,
    };
  }

  @override
  List<Object> get props => [
        id,
        createdAt,
        expired,
        uninstalled,
        lastUpdatedAt,
        deviceInfo,
        token,
      ];

  @override
  bool get stringify => true;
}

class DeviceDetails {
  String device;
  String model;
  String osVersion;
  String platform;

  DeviceDetails({this.device, this.model, this.osVersion, this.platform});

  DeviceDetails.fromJson(Map<String, dynamic> json) {
    device = json[DeviceDetailsFields.device];
    model = json[DeviceDetailsFields.model];
    osVersion = json[DeviceDetailsFields.osVersion];
    platform = json[DeviceDetailsFields.platform];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[DeviceDetailsFields.device] = this.device;
    data[DeviceDetailsFields.model] = this.model;
    data[DeviceDetailsFields.osVersion] = this.osVersion;
    data[DeviceDetailsFields.platform] = this.platform;
    return data;
  }
}

class DeviceDetailsFields {
  static const String device = 'device';
  static const String model = 'model';
  static const String osVersion = 'os_version';
  static const String platform = 'platform';
}

class DeviceFields {
  static const String createdAt = "created_at";
  static const String lastUpdatedAt = "last_updated_at";
  static const String token = "token";
  static const String expired = "expired";
  static const String uninstalled = "uninstalled";
  static const String deviceInfo = "device_info";
}
