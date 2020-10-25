import 'package:bottleshopdeliveryapp/src/features/account/data/models/language.dart';
import 'package:hooks_riverpod/all.dart';

final languagesPageStateProvider = Provider(
  (_) => const [
    Language(
        englishName: 'English',
        localName: 'Angličtina',
        flag: 'assets/images/united-states-of-america.png'),
    Language(
        englishName: 'Slovak',
        flag: 'assets/images/slovakia.png',
        localName: 'Slovenčina'),
  ],
);
