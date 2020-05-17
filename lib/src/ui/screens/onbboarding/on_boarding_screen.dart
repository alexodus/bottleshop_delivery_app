import 'package:bottleshopdeliveryapp/src/core/utils/app_config.dart';
import 'package:bottleshopdeliveryapp/src/core/viewmodels/screens/on_boarding_view_model.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/sign_up/sign_up_screen.dart';
import 'package:bottleshopdeliveryapp/src/ui/view_model_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
  static const String routeName = '/onboarding';
  OnBoardingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<OnBoardingViewModel>(
      model: OnBoardingViewModel(context: context),
      builder: (model) {
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.96),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20, top: 50),
                  child: FlatButton(
                    onPressed: () async {
                      await model.skipOnboardingPermanently();
                      await Navigator.pushReplacementNamed(
                          context, SignUpScreen.routeName);
                    },
                    child: Text(
                      'Skip',
                      style: Theme.of(context).textTheme.button,
                    ),
                    color: Theme.of(context).accentColor,
                    shape: StadiumBorder(),
                  ),
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 500.0,
                    viewportFraction: 1.0,
                    onPageChanged: model.pageChanged,
                  ),
                  items: model.screens.map((boarding) {
                    return Builder(
                      builder: (context) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Image.asset(
                                boarding.image,
                                width: 500,
                              ),
                            ),
                            Container(
                              width: AppConfig(context).appWidth(75),
                              padding: const EdgeInsets.only(right: 20),
                              child: Text(
                                boarding.description,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }).toList(),
                ),
                Container(
                  width: AppConfig(context).appWidth(75),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: model.screens.map((boarding) {
                      return Container(
                        width: 25.0,
                        height: 3.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          color: model.currentIndex ==
                                  model.screens.indexOf(boarding)
                              ? Theme.of(context).hintColor.withOpacity(0.8)
                              : Theme.of(context).hintColor.withOpacity(0.2),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  width: AppConfig(context).appWidth(75),
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, SignUpScreen.routeName);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Sign up',
                          style: Theme.of(context).textTheme.headline4.merge(
                                TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                    color: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        bottomLeft: Radius.circular(50),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
