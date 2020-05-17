import 'package:bottleshopdeliveryapp/src/core/models/category.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/categories/categories.dart';
import 'package:bottleshopdeliveryapp/src/ui/shared/CategoryIconWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoriesIconsCarouselWidget extends StatefulWidget {
  final List<Category> categoriesList;
  final String heroTag;
  final ValueChanged<String> onChanged;

  CategoriesIconsCarouselWidget(
      {Key key, this.categoriesList, this.heroTag, this.onChanged})
      : super(key: key);

  @override
  _CategoriesIconsCarouselWidgetState createState() =>
      _CategoriesIconsCarouselWidgetState();
}

class _CategoriesIconsCarouselWidgetState
    extends State<CategoriesIconsCarouselWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: 80,
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor.withOpacity(1),
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(60),
                  topRight: Radius.circular(60)),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CategoriesScreen.routeName);
              },
              icon: FaIcon(
                FontAwesomeIcons.cog,
                size: 28,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Expanded(
            child: Container(
                margin: EdgeInsets.only(left: 0),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor.withOpacity(1),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      topLeft: Radius.circular(60)),
                ),
                child: ListView.builder(
                  itemCount: widget.categoriesList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    double _marginLeft = 0;
                    (index == 0) ? _marginLeft = 12 : _marginLeft = 0;
                    return CategoryIconWidget(
                        heroTag: widget.heroTag,
                        marginLeft: _marginLeft,
                        category: widget.categoriesList.elementAt(index),
                        onPressed: (id) {
                          setState(() {
                            widget.categoriesList.forEach((brand) {
                              brand.selected = false;
                              if (brand.id == id) {
                                brand.selected = true;
                              }
                            });
                            widget.onChanged(id);
                          });
                        });
                  },
                  scrollDirection: Axis.horizontal,
                )),
          ),
        ],
      ),
    );
  }
}
