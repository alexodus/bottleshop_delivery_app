import 'package:bottleshopdeliveryapp/src/features/products/data/models/categories_tree_model.dart';
import 'package:bottleshopdeliveryapp/src/features/products/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

var icons = [
  'assets/icons/icon_absinth.png',
  'assets/icons/icon_armagnac.png',
  'assets/icons/icon_brandy.png',
  'assets/icons/icon_cachaca.png',
  'assets/icons/icon_calvados.png',
  'assets/icons/icon_cognac.png',
  'assets/icons/icon_destilaty.png',
  'assets/icons/icon_gin.png',
  'assets/icons/icon_liehoviny.png',
  'assets/icons/icon_likery.png',
  'assets/icons/icon_miesanenapoje.png',
  'assets/icons/icon_pivo.png',
  'assets/icons/icon_rum.png',
  'assets/icons/icon_tequila.png',
];

class CategoryIcon extends HookWidget {
  final CategoriesTreeModel category;
  final String heroTag;
  final double marginLeft;

  const CategoryIcon({
    Key key,
    @required this.category,
    @required this.heroTag,
    @required this.marginLeft,
  })  : assert(category != null),
        assert(heroTag != null),
        assert(marginLeft != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    icons.shuffle();
    final isCategorySelected = useProvider(
      categoryFilterProvider.select(
        (value) => value.isSelected(category.categoryDetails.id),
      ),
    );
    final iconName = icons.first;
    final tickerProvider = useSingleTickerProvider();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(left: marginLeft, top: 10, bottom: 10),
      child: InkWell(
        splashColor: Theme.of(context).accentColor,
        highlightColor: Theme.of(context).accentColor,
        onTap: () => context
            .read(categoryFilterProvider)
            .addCategory(category.categoryDetails.id),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 350),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: isCategorySelected
                ? Theme.of(context).primaryColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            children: <Widget>[
              Hero(
                tag: heroTag + category.categoryDetails.id,
                child: ImageIcon(
                  AssetImage(category.categoryDetails.iconName),
                  color: isCategorySelected
                      ? Theme.of(context).accentColor
                      : Theme.of(context).primaryColor,
                  size: 48,
                ),
              ),
              SizedBox(width: 10),
              AnimatedSize(
                duration: Duration(milliseconds: 350),
                curve: Curves.easeInOut,
                vsync: tickerProvider,
                child: Text(
                  isCategorySelected ? category.categoryDetails.name : '',
                  style: TextStyle(
                      fontSize: 14, color: Theme.of(context).accentColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
