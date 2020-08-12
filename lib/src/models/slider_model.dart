import 'package:flutter/foundation.dart';

class SliderModel {
  final String imageUrl;
  final String description;

  const SliderModel({@required this.imageUrl, @required this.description})
      : assert(imageUrl != null),
        assert(description != null);

  factory SliderModel.fromMap(Map<String, dynamic> data) {
    return SliderModel(
        imageUrl: data['imageUrl'], description: data['description']);
  }
}
