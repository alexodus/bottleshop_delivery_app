import 'package:flutter/foundation.dart';

class OnBoarding {
  final String image;
  final String description;

  const OnBoarding({@required this.image, @required this.description})
      : assert(image != null),
        assert(description != null);
}
