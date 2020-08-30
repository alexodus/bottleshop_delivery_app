import 'package:bottleshopdeliveryapp/src/models/category.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/category_list_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryIcon extends StatelessWidget {
  final TickerProvider tickerProvider;
  final Category category;
  final String heroTag;
  final double marginLeft;
  final ValueChanged<String> onPressed;

  const CategoryIcon({
    Key key,
    @required this.tickerProvider,
    @required this.category,
    @required this.heroTag,
    @required this.marginLeft,
    this.onPressed,
  })  : assert(tickerProvider != null),
        assert(category != null),
        assert(heroTag != null),
        assert(marginLeft != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final isCategorySelected =
        context.watch<CategoryListModel>().isCategorySelected(category.name);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0),
      margin: EdgeInsets.only(left: marginLeft, top: 10, bottom: 10),
      child: InkWell(
        splashColor: Theme.of(context).accentColor,
        highlightColor: Theme.of(context).accentColor,
        onTap: () => onPressed(category.name),
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
                tag: heroTag + category.documentID,
                child: Icon(
                  Icons.widgets,
                  color: isCategorySelected
                      ? Theme.of(context).accentColor
                      : Theme.of(context).primaryColor,
                  size: 32,
                ),
              ),
              SizedBox(width: 10),
              AnimatedSize(
                duration: Duration(milliseconds: 350),
                curve: Curves.easeInOut,
                vsync: tickerProvider,
                child: Text(
                  isCategorySelected ? category.name : '',
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
