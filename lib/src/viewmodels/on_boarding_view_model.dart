import 'package:bottleshopdeliveryapp/src/constants/strings.dart';
import 'package:bottleshopdeliveryapp/src/models/on_boarding.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/base_view_model.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:provider/provider.dart';

class OnBoardingViewModel extends BaseViewModel {
  int _pageIndex = 0;
  OnBoardingViewModel(Locator locator) : super(locator: locator);

  dynamic pageChanged(int index, CarouselPageChangedReason reason) {
    _pageIndex = index;
    notifyListeners();
  }

  int get currentIndex => _pageIndex;

  List<OnBoarding> get screens => [
        OnBoarding(
            image: 'assets/images/onboarding0.png',
            description: Strings.onboardingLabels[0]),
        OnBoarding(
            image: 'assets/images/onboarding1.png',
            description: Strings.onboardingLabels[1]),
      ];
}
