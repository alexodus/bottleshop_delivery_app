import 'package:flutter/foundation.dart' show required;

class LanguageModel {
  final String englishName;
  final String localName;
  final String flag;

  const LanguageModel(
      {@required this.englishName,
      @required this.localName,
      @required this.flag})
      : assert(englishName != null),
        assert(localName != null),
        assert(flag != null);

  factory LanguageModel.fromMap(Map<String, dynamic> data) {
    return LanguageModel(
        englishName: data['englishName'],
        localName: data['localName'],
        flag: data['flag']);
  }
}
