import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Address extends Equatable {
  final String id;
  final String streetName;
  final String streetNumber;
  final String city;
  final String zipCode;

  const Address({
    @required this.id,
    @required this.streetName,
    @required this.streetNumber,
    @required this.city,
    @required this.zipCode,
  })  : assert(streetName != null),
        assert(id != null),
        assert(streetName != null),
        assert(streetNumber != null),
        assert(city != null),
        assert(zipCode != null);

  factory Address.fromMap(Map<String, dynamic> map, String documentId) {
    return Address(
      id: documentId,
      streetName: map['streetName'] as String,
      streetNumber: map['streetNumber'] as String,
      city: map['city'] as String,
      zipCode: map['zipCode'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'streetName': this.streetName,
      'streetNumber': this.streetNumber,
      'city': this.city,
      'zipCode': this.zipCode,
    };
  }

  @override
  List<Object> get props => [
        id,
        streetName,
        streetNumber,
        city,
        zipCode,
      ];

  @override
  bool get stringify => true;
}
