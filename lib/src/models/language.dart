import 'package:flutter/foundation.dart' show required;

class Language {
  final String englishName;
  final String localName;
  final String flag;

  const Language(
      {@required this.englishName,
      @required this.localName,
      @required this.flag})
      : assert(englishName != null),
        assert(localName != null),
        assert(flag != null);

  factory Language.fromMap(Map<String, dynamic> data) {
    return Language(
        englishName: data['englishName'],
        localName: data['localName'],
        flag: data['flag']);
  }
}
