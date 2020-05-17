import 'package:bottleshopdeliveryapp/src/core/models/on_boarding.dart';
import 'package:bottleshopdeliveryapp/src/core/viewmodels/base_view_model.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/cupertino.dart';

class OnBoardingViewModel extends BaseViewModel {
  int _pageIndex = 0;
  OnBoardingViewModel({BuildContext context}) : super(context: context);

  Future<void> skipOnboardingPermanently() async {
    await userPreferences.setOnBoardingShown(true);
  }

  dynamic pageChanged(int index, CarouselPageChangedReason reason) {
    print('changed: $index');
    _pageIndex = index;
    notifyListeners();
  }

  int get currentIndex => _pageIndex;

  List<OnBoarding> get screens => [
        OnBoarding(
            image: 'assets/images/onboarding0.png',
            description:
                'Don\'t cry because it\'s over, smile because it happened.'),
        OnBoarding(
            image: 'assets/images/onboarding1.png',
            description: 'Be yourself, everyone else is already taken.'),
      ];

  @override
  void dispose() {
    super.dispose();
  }
}
