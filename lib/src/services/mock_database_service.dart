import 'package:bottleshopdeliveryapp/src/models/category.dart';
import 'package:bottleshopdeliveryapp/src/models/language.dart';
import 'package:bottleshopdeliveryapp/src/models/on_boarding.dart';
import 'package:bottleshopdeliveryapp/src/models/order.dart';
import 'package:bottleshopdeliveryapp/src/models/product.dart';
import 'package:bottleshopdeliveryapp/src/models/review.dart';
import 'package:bottleshopdeliveryapp/src/models/shop_notification.dart';
import 'package:bottleshopdeliveryapp/src/models/slider.dart' as model;
import 'package:bottleshopdeliveryapp/src/models/user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MockDatabaseService {
  List<Order> get orders => [
        Order(
            Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
                86.0, 5, 3, 10.0, 5.0),
            'RB4551532214564',
            OrderState.shipped),
        Order(
            Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
                86.0, 5, 3, 10.0, 5.0),
            'CH4561454563156',
            OrderState.toBeShipped),
        Order(
            Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
                86.0, 5, 3, 10.0, 5.0),
            'RB4551532214564',
            OrderState.unpaid),
        Order(
            Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
                86.0, 5, 3, 10.0, 5.0),
            'CH456124566652',
            OrderState.shipped),
      ];

  List<Language> get languages => [
        Language(
            "English", "English", "assets/images/united-states-of-america.png"),
        Language("Slovak", "Slovenčina", "assets/images/slovakia.png")
      ];

  List<OnBoarding> get onboardingScreens => [
        OnBoarding(
            image: 'assets/images/onboarding0.png',
            description:
                'Don\'t cry because it\'s over, smile because it happened.'),
        OnBoarding(
            image: 'assets/images/onboarding1.png',
            description: 'Be yourself, everyone else is already taken.'),
        OnBoarding(
            image: 'assets/images/onboarding2.png',
            description: 'So many books, so little time.'),
        OnBoarding(
            image: 'assets/images/onboarding3.png',
            description: 'A room without books is like a body without a soul.'),
      ];

  List<Category> get categories => [
        Category('Liqour', FontAwesomeIcons.glassWhiskey, true, [
          Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
              86.0, 5, 3, 10.0, 5.0),
          Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
              86.0, 5, 3, 10.0, 5.0),
        ]),
        Category('Wine', FontAwesomeIcons.wineGlassAlt, false, [
          Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
              86.0, 5, 3, 10.0, 5.0),
          Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
              86.0, 5, 3, 10.0, 5.0),
        ]),
        Category('Beer', FontAwesomeIcons.beer, false, [
          Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
              86.0, 5, 3, 10.0, 5.0),
          Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
              86.0, 5, 3, 10.0, 5.0),
        ]),
        Category('Beer', FontAwesomeIcons.beer, false, [
          Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
              86.0, 5, 3, 10.0, 5.0),
          Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
              86.0, 5, 3, 10.0, 5.0),
        ]),
        Category('Beer', FontAwesomeIcons.beer, false, [
          Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
              86.0, 5, 3, 10.0, 5.0),
          Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
              86.0, 5, 3, 10.0, 5.0),
        ]),
        Category('Beer', FontAwesomeIcons.beer, false, [
          Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
              86.0, 5, 3, 10.0, 5.0),
          Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
              86.0, 5, 3, 10.0, 5.0),
        ]),
      ];

  List<SubCategory> get subCategories => [
        SubCategory('White wine', false, [
          Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
              86.0, 5, 3, 10.0, 5.0),
          Product('Aberlou 15yo Doublecask', 'assets/images/product02.png', 5,
              86.0, 5, 3, 10.0, 5.0),
        ]),
        SubCategory('Red wine', false, [
          Product('Aberlou 15yo Doublecask', 'assets/images/product03.png', 5,
              86.0, 5, 3, 10.0, 5.0),
          Product('Aberlou 15yo Doublecask', 'assets/images/product04.png', 5,
              86.0, 5, 3, 10.0, 5.0),
        ]),
        SubCategory('Sparkling wine', false, [
          Product('Aberlou 15yo Doublecask', 'assets/images/product05.png', 5,
              86.0, 5, 3, 10.0, 5.0),
          Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
              86.0, 5, 3, 10.0, 5.0),
        ]),
        SubCategory('Absinth', false, [
          Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
              86.0, 5, 3, 10.0, 5.0),
          Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
              86.0, 5, 3, 10.0, 5.0),
        ]),
        SubCategory('Brandy', false, [
          Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
              86.0, 5, 3, 10.0, 5.0),
          Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
              86.0, 5, 3, 10.0, 5.0),
        ]),
        SubCategory('Cognac', false, [
          Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
              86.0, 5, 3, 10.0, 5.0),
          Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
              86.0, 5, 3, 10.0, 5.0),
        ]),
      ];

  List<Product> get flashSalesList => [
        Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
            86.0, 5, 3, 10.0, 5.0),
        Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
            86.0, 5, 3, 10.0, 5.0),
        Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
            86.0, 5, 3, 10.0, 5.0),
      ];
  List<Product> get products => [
        Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
            86.0, 5, 3, 10.0, 5.0),
        Product('Aberlou 15yo Doublecask', 'assets/images/product02.png', 5,
            86.0, 5, 3, 10.0, 5.0),
        Product('Aberlou 15yo Doublecask', 'assets/images/product03.png', 5,
            86.0, 5, 3, 10.0, 5.0),
        Product('Aberlou 15yo Doublecask', 'assets/images/product04.png', 5,
            86.0, 5, 3, 10.0, 5.0),
        Product('Aberlou 15yo Doublecask', 'assets/images/product05.png', 5,
            86.0, 5, 3, 10.0, 5.0),
        Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
            86.0, 5, 3, 10.0, 5.0),
        Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
            86.0, 5, 3, 10.0, 5.0),
        Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
            86.0, 5, 3, 10.0, 5.0),
        Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
            86.0, 5, 3, 10.0, 5.0),
      ];

  List<Product> get favorites => [
        Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
            86.0, 5, 3, 10.0, 5.0),
        Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
            86.0, 5, 3, 10.0, 5.0),
        Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
            86.0, 5, 3, 10.0, 5.0),
      ];

  List<Product> get cartList => [
        Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
            86.0, 5, 3, 10.0, 5.0),
        Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
            86.0, 5, 3, 10.0, 5.0),
        Product('Aberlou 15yo Doublecask', 'assets/images/product01.png', 5,
            86.0, 5, 3, 10.0, 5.0),
      ];

  List<ShopNotification> get shopNotifications => [
        ShopNotification(
            'assets/images/user0.jpg',
            'It is a long established fact that a reader will be distracted',
            '12min ago',
            false),
        ShopNotification(
            'assets/images/user1.jpg',
            'There are many variations of passages of Lorem Ipsum available',
            '2 hours ago',
            true),
        ShopNotification(
            'assets/images/user2.jpg',
            'Contrary to popular belief, Lorem Ipsum is not simply random text',
            '1 day ago',
            false),
      ];

  List<Review> get reviewsList => [
        Review(
            User.basic('Maria R. Garza', 'assets/images/user0.jpg'),
            'There are a few foods that predate colonization, and the European colonization of the Americas brought about the introduction of a large number of  ingredients',
            3.2),
        Review(
            User.basic('George T. Larkin', 'assets/images/user1.jpg'),
            'There are a few foods that predate colonization, and the European colonization of the Americas brought about the introduction of a large number of  ingredients',
            3.2),
        Review(
            User.basic('Edward E. Linn', 'assets/images/user3.jpg'),
            'There are a few foods that predate colonization, and the European colonization of the Americas brought about the introduction of a large number of  ingredients',
            3.2),
        Review(
            User.basic('George T. Larkin', 'assets/images/user0.jpg'),
            'There are a few foods that predate colonization, and the European colonization of the Americas brought about the introduction of a large number of  ingredients',
            3.2),
        Review(
            User.basic('Laurie Z. Bergeron', 'assets/images/user1.jpg'),
            'There are a few foods that predate colonization, and the European colonization of the Americas brought',
            3.2)
      ];

  List<model.Slider> get sliders => [
        model.Slider(
            image: 'assets/images/slider3.jpg',
            button: 'Collection',
            description: 'A room without books is like a body without a soul.'),
        model.Slider(
            image: 'assets/images/slider1.jpg',
            button: 'Explore',
            description: 'Be yourself, everyone else is already taken.'),
        model.Slider(
            image: 'assets/images/slider2.jpg',
            button: 'Visit Store',
            description: 'So many books, so little time.'),
      ];
}
