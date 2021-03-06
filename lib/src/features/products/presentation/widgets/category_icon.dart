import 'dart:ui';

import 'package:bottleshopdeliveryapp/src/features/products/data/models/category_plain_model.dart';
import 'package:bottleshopdeliveryapp/src/features/products/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class CategoryIcon extends HookWidget {
  final SelectableCategory category;
  final String heroTag;
  final double marginLeft;
  final ValueChanged<String> onPressed;

  const CategoryIcon({
    Key key,
    @required this.category,
    @required this.heroTag,
    @required this.marginLeft,
    @required this.onPressed,
  })  : assert(category != null),
        assert(heroTag != null),
        assert(marginLeft != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(left: marginLeft, top: 10, bottom: 10),
      child: InkWell(
        splashColor: Theme.of(context).accentColor,
        highlightColor: Theme.of(context).accentColor,
        onTap: () {
          context.read(productRepositoryProvider).selectCategory(category.id);
          onPressed(category.id);
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 350),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: category.selected
                ? Theme.of(context).primaryColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            children: <Widget>[
              Hero(
                tag: heroTag + category.id,
                child: ImageIcon(
                  AssetImage(category.icon),
                  color: category.selected
                      ? Theme.of(context).accentColor
                      : Theme.of(context).primaryColor,
                  size: 32,
                ),
              ),
              SizedBox(width: 10),
              AnimatedSize(
                duration: Duration(milliseconds: 350),
                curve: Curves.easeInOut,
                vsync: useSingleTickerProvider(),
                child: Text(
                  category.selected ? category.name : '',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
