import 'package:bottleshopdeliveryapp/src/features/account/data/models/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AnimationMixinFields {
  Animation<double> animation;
  Animation<double> sizeCheckAnimation;
  Animation<double> rotateCheckAnimation;
  Animation<double> opacityAnimation;
  Animation<double> opacityCheckAnimation;
  AnimationController animationController;

  AnimationMixinFields._(
      {this.animationController,
      this.animation,
      this.sizeCheckAnimation,
      this.rotateCheckAnimation,
      this.opacityAnimation,
      this.opacityCheckAnimation});

  factory AnimationMixinFields(AnimationController controller) {
    final curve = CurvedAnimation(parent: controller, curve: Curves.easeOut);
    final animation = Tween(begin: 0.0, end: 40.0).animate(curve);
    final opacityAnimation = Tween(begin: 0.0, end: 0.85).animate(curve);
    final opacityCheckAnimation = Tween(begin: 0.0, end: 1.0).animate(curve);
    final rotateCheckAnimation = Tween(begin: 2.0, end: 0.0).animate(curve);
    final sizeCheckAnimation = Tween(begin: 0.0, end: 24.0).animate(curve);
    return AnimationMixinFields._(
      animationController: controller,
      animation: animation,
      opacityAnimation: opacityAnimation,
      opacityCheckAnimation: opacityCheckAnimation,
      rotateCheckAnimation: rotateCheckAnimation,
      sizeCheckAnimation: sizeCheckAnimation,
    );
  }
}

mixin AnimationMixin {
  bool _isToggled = false;
  AnimationMixinFields fields;

  Widget buildAnimatedContainer(BuildContext context) {
    return Container(
      height: fields.animation.value,
      width: fields.animation.value,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        color: Theme.of(context)
            .accentColor
            .withOpacity(fields.opacityAnimation.value),
      ),
      child: Transform.rotate(
        angle: fields.rotateCheckAnimation.value,
        child: Icon(
          Icons.check,
          size: fields.sizeCheckAnimation.value,
          color: Theme.of(context)
              .primaryColor
              .withOpacity(fields.opacityCheckAnimation.value),
        ),
      ),
    );
  }

  void onTap() {
    if (_isToggled) {
      fields.animationController.reverse();
    } else {
      fields.animationController.forward();
    }
    _isToggled = !_isToggled;
  }
}

// ignore: must_be_immutable
class LanguageListItem extends HookWidget with AnimationMixin {
  final Language language;

  LanguageListItem({Key key, @required this.language});

  @override
  Widget build(BuildContext context) {
    handleAssignment();
    return InkWell(
      onTap: () => onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.9),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).focusColor.withOpacity(0.1),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    image: DecorationImage(
                        image: AssetImage(language.flag), fit: BoxFit.cover),
                  ),
                ),
                buildAnimatedContainer(context),
              ],
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    language.englishName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    language.localName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void handleAssignment() {
    final animationController =
        useAnimationController(duration: Duration(milliseconds: 350));
    fields = useMemoized(() => AnimationMixinFields(animationController));
  }
}
