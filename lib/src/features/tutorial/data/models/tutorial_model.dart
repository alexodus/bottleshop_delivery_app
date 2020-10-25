import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class TutorialModel extends Equatable {
  final String image;
  final String description;

  const TutorialModel({@required this.image, @required this.description})
      : assert(image != null),
        assert(description != null);

  @override
  List<Object> get props {
    return [image, description];
  }

  @override
  bool get stringify => true;

  factory TutorialModel.fromMap(Map<String, dynamic> map) {
    return TutorialModel(
      image: map['image'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': this.image,
      'description': this.description,
    };
  }
}
