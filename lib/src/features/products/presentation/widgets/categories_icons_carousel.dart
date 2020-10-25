import 'package:bottleshopdeliveryapp/src/features/products/presentation/pages/categories_page.dart';
import 'package:bottleshopdeliveryapp/src/features/products/presentation/providers/providers.dart';
import 'package:bottleshopdeliveryapp/src/features/products/presentation/widgets/category_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class CategoriesIconsCarousel extends HookWidget {
  final ValueChanged<String> onPressed;
  const CategoriesIconsCarousel({
    Key key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = useProvider(productRepositoryProvider
        .select((value) => value.selectableCategories));
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
                Navigator.pushNamed(context, CategoriesPage.routeName);
              },
              icon: Icon(
                Icons.settings,
                size: 28,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              clipBehavior: Clip.hardEdge,
              margin: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor.withOpacity(1),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    topLeft: Radius.circular(60)),
              ),
              child: ListView.builder(
                itemCount: categories.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  double _marginLeft = 0;
                  (index == 0) ? _marginLeft = 12 : _marginLeft = 0;
                  final category = categories.elementAt(index);
                  return CategoryIcon(
                    heroTag: 'home_categories_1',
                    marginLeft: _marginLeft,
                    category: category,
                    onPressed: onPressed,
                  );
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
