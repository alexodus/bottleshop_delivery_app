import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class LocalizedModel extends Equatable {
  static const String slovakField = 'sk';

  final String _slovak;

  String get local => _slovak;

  LocalizedModel({@required slovak}) : _slovak = slovak;

  LocalizedModel.fromMap(Map<String, dynamic> json)
      : _slovak = json[slovakField];

  @override
  List<Object> get props {
    return [_slovak];
  }

  @override
  bool get stringify => true;
}
