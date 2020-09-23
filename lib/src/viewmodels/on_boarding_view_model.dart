import 'package:bottleshopdeliveryapp/src/constants/strings.dart';
import 'package:bottleshopdeliveryapp/src/models/on_boarding.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/all.dart';

class OnBoardingViewModel extends ChangeNotifier {
  int _pageIndex = 0;

  void pageChanged(int index, CarouselPageChangedReason reason) {
    _pageIndex = index;
    notifyListeners();
  }

  int get currentIndex => _pageIndex;
}

final onBoardingScreensProvider = Provider((ref) => [
      OnBoarding(
          image: 'assets/images/onboarding0.png',
          description: Strings.onboardingLabels[0]),
      OnBoarding(
          image: 'assets/images/onboarding1.png',
          description: Strings.onboardingLabels[1]),
    ]);

final onBoardingViewModelProvider =
    ChangeNotifierProvider((_) => OnBoardingViewModel());
