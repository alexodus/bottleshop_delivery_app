import 'package:bottleshopdeliveryapp/src/features/account/data/models/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

class LanguageListItem extends HookWidget {
  final Language language;
  final bool isSelected;
  LanguageListItem(
      {Key key, @required this.language, @required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final animationController =
        useAnimationController(duration: Duration(milliseconds: 350));
    final checkState = useState(isSelected);
    final sequenceAnimation = SequenceAnimationBuilder()
        .addAnimatable(
          animatable: Tween<double>(begin: 0.0, end: 40.0),
          curve: Curves.easeOut,
          from: const Duration(milliseconds: 0),
          to: const Duration(milliseconds: 350),
          tag: 'grow',
        )
        .addAnimatable(
          animatable: Tween<double>(begin: 0.0, end: 24.0),
          curve: Curves.easeOut,
          from: const Duration(milliseconds: 0),
          to: const Duration(milliseconds: 350),
          tag: 'size-check',
        )
        .addAnimatable(
          animatable: Tween<double>(begin: 0.0, end: 0.85),
          curve: Curves.easeOut,
          from: const Duration(milliseconds: 0),
          to: const Duration(milliseconds: 350),
          tag: 'opacity',
        )
        .addAnimatable(
          animatable: Tween<double>(begin: 0.0, end: 1.0),
          curve: Curves.easeOut,
          from: const Duration(milliseconds: 0),
          to: const Duration(milliseconds: 350),
          tag: 'opacity-check',
        )
        .addAnimatable(
          animatable: Tween<double>(begin: 2.0, end: 0.0),
          curve: Curves.easeOut,
          from: const Duration(milliseconds: 0),
          to: const Duration(milliseconds: 350),
          tag: 'rotate-check',
        )
        .animate(animationController);
    if (checkState.value) {
      animationController.forward();
    }
    return InkWell(
      onTap: () {
        if (checkState.value) {
          animationController.reverse();
        } else {
          animationController.forward();
        }
        checkState.value = !checkState.value;
      },
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
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) => Row(
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
                        image: AssetImage(language.flag),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: sequenceAnimation['grow'].value,
                    width: sequenceAnimation['grow'].value,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      color: Theme.of(context)
                          .accentColor
                          .withOpacity(sequenceAnimation['opacity'].value),
                    ),
                    child: Transform.rotate(
                      angle: sequenceAnimation['rotate-check'].value,
                      child: Icon(
                        Icons.check,
                        size: sequenceAnimation['size-check'].value,
                        color: Theme.of(context).primaryColor.withOpacity(
                            sequenceAnimation['opacity-check'].value),
                      ),
                    ),
                  ),
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
      ),
    );
  }
}
