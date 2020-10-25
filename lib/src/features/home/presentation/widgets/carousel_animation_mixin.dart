import 'package:bottleshopdeliveryapp/src/features/products/presentation/widgets/categories_icons_carousel.dart';
import 'package:bottleshopdeliveryapp/src/features/products/presentation/widgets/categorized_products.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class CarouselAnimationMixinFields {
  Animation<double> animationOpacity;
  AnimationController animationController;

  CarouselAnimationMixinFields._({
    this.animationController,
    this.animationOpacity,
  });

  factory CarouselAnimationMixinFields(AnimationController controller) {
    final curve = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    final animation = Tween(begin: 0.0, end: 1.0).animate(curve);
    return CarouselAnimationMixinFields._(
        animationController: controller, animationOpacity: animation);
  }
}

mixin CarouselAnimationMixin {
  CarouselAnimationMixinFields animationMixinFields;

  Widget buildAnimatedContainer(BuildContext context) {
    animationMixinFields.animationController.forward();
    return StickyHeader(
      header: CategoriesIconsCarousel(
        onPressed: (id) {
          animationMixinFields.animationController.reverse().then((f) {
            // TODO Update products based on returned category
            animationMixinFields.animationController.forward();
          });
        },
      ),
      content: CategorizedProducts(
          animationOpacity: animationMixinFields.animationOpacity),
    );
  }
}
