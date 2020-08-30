import 'package:bottleshopdeliveryapp/src/models/language_model.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/base_view_model.dart';
import 'package:provider/provider.dart';

class LanguagesViewModel extends BaseViewModel {
  LanguagesViewModel(Locator locator) : super(locator: locator);
  List<LanguageModel> get languages => [
        LanguageModel(
            englishName: 'English',
            localName: 'Angličtina',
            flag: 'assets/images/united-states-of-america.png'),
        LanguageModel(
            englishName: 'Slovak',
            flag: 'assets/images/slovakia.png',
            localName: 'Slovenčina')
      ];
}
