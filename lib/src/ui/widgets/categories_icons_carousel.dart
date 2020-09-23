import 'package:bottleshopdeliveryapp/src/models/categories_tree_model.dart';
import 'package:bottleshopdeliveryapp/src/repositories/product_repository.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/categories_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import 'category_icon.dart';

class CategoriesIconsCarousel extends HookWidget {
  const CategoriesIconsCarousel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<CategoriesTreeModel>> categories =
        useProvider(categoriesProvider);
    return categories.when(
      data: (categoryList) {
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
                    Navigator.pushNamed(context, CategoriesView.routeName);
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
                    dragStartBehavior: DragStartBehavior.start,
                    itemCount: categoryList.length,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: ScrollPhysics(
                      parent: ClampingScrollPhysics(),
                    ),
                    itemBuilder: (context, index) {
                      return Builder(
                        builder: (context) {
                          final category = categoryList.elementAt(index);
                          return CategoryIcon(
                            heroTag: 'home_categories_1',
                            marginLeft: (index == 0) ? 12 : 0,
                            category: category,
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
      loading: null,
      error: null,
    );
  }
}
