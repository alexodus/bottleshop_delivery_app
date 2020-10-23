import 'package:flutter/foundation.dart';

@immutable
class SliderModel {
  final String id;
  final String imageUrl;
  final String description;

  const SliderModel(
      {@required this.id, @required this.imageUrl, @required this.description})
      : assert(imageUrl != null),
        assert(id != null),
        assert(description != null);

  factory SliderModel.fromMap(Map<String, dynamic> data, String id) {
    return SliderModel(
      id: id,
      imageUrl: data['imageUrl'],
      description: data['description'],
    );
  }
}
